import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { verifyAuth } from "../auth/verifyAuth";
import { getStripe } from "./config";

const db = () => admin.firestore();

/**
 * Creates or resumes Stripe Connect Express onboarding for cast users (mobile).
 */
export const createStripeConnectOnboardingLink = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const authUser = verifyAuth(context);
    const returnUrl = (data?.returnUrl as string) ?? "https://icoccha.app/stripe/return";
    const refreshUrl = (data?.refreshUrl as string) ?? returnUrl;

    const userRef = db().collection("users").doc(authUser.uid);
    const userSnap = await userRef.get();
    if (!userSnap.exists) {
      throw new functions.https.HttpsError("not-found", "User profile not found.");
    }
    const userData = userSnap.data() ?? {};
    const role = userData.role as number | undefined;
    if (role !== 1) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Stripe Connect onboarding is only available for cast users.",
      );
    }

    const stripe = getStripe();
    let accountId = userData.stripe_connect_account_id as string | undefined;
    if (!accountId) {
      const account = await stripe.accounts.create({
        type: "express",
        country: "JP",
        email: userData.email as string | undefined,
        metadata: { firebase_uid: authUser.uid },
      });
      accountId = account.id;
      await userRef.set(
        {
          stripe_connect_account_id: accountId,
          stripe_connect_onboarding_complete: false,
          stripe_connect_created_at: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      );
    }

    const accountLink = await stripe.accountLinks.create({
      account: accountId,
      refresh_url: refreshUrl,
      return_url: returnUrl,
      type: "account_onboarding",
    });

    return {
      url: accountLink.url,
      accountId,
      expiresAt: accountLink.expires_at,
    };
  });

/**
 * Returns Stripe Connect onboarding status for the authenticated cast user.
 */
export const getStripeConnectStatus = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    const authUser = verifyAuth(context);
    const userSnap = await db().collection("users").doc(authUser.uid).get();
    if (!userSnap.exists) {
      throw new functions.https.HttpsError("not-found", "User profile not found.");
    }
    const userData = userSnap.data() ?? {};
    const accountId = userData.stripe_connect_account_id as string | undefined;
    if (!accountId) {
      return {
        hasAccount: false,
        onboardingComplete: false,
        chargesEnabled: false,
        payoutsEnabled: false,
      };
    }

    const stripe = getStripe();
    const account = await stripe.accounts.retrieve(accountId);
    const onboardingComplete = account.details_submitted ?? false;
    const chargesEnabled = account.charges_enabled ?? false;
    const payoutsEnabled = account.payouts_enabled ?? false;

    await userSnap.ref.update({
      stripe_connect_onboarding_complete: onboardingComplete,
      stripe_connect_charges_enabled: chargesEnabled,
      stripe_connect_payouts_enabled: payoutsEnabled,
      stripe_connect_updated_at: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      hasAccount: true,
      accountId,
      onboardingComplete,
      chargesEnabled,
      payoutsEnabled,
    };
  });
