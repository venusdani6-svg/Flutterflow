"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.getStripeConnectStatus = exports.createStripeConnectOnboardingLink = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const verifyAuth_1 = require("../auth/verifyAuth");
const config_1 = require("./config");
const db = () => admin.firestore();
/**
 * Creates or resumes Stripe Connect Express onboarding for cast users (mobile).
 */
exports.createStripeConnectOnboardingLink = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b, _c;
    const authUser = (0, verifyAuth_1.verifyAuth)(context);
    const returnUrl = (_a = data === null || data === void 0 ? void 0 : data.returnUrl) !== null && _a !== void 0 ? _a : "https://icoccha.app/stripe/return";
    const refreshUrl = (_b = data === null || data === void 0 ? void 0 : data.refreshUrl) !== null && _b !== void 0 ? _b : returnUrl;
    const userRef = db().collection("users").doc(authUser.uid);
    const userSnap = await userRef.get();
    if (!userSnap.exists) {
        throw new functions.https.HttpsError("not-found", "User profile not found.");
    }
    const userData = (_c = userSnap.data()) !== null && _c !== void 0 ? _c : {};
    const role = userData.role;
    if (role !== 1) {
        throw new functions.https.HttpsError("permission-denied", "Stripe Connect onboarding is only available for cast users.");
    }
    const stripe = (0, config_1.getStripe)();
    let accountId = userData.stripe_connect_account_id;
    if (!accountId) {
        const account = await stripe.accounts.create({
            type: "express",
            country: "JP",
            email: userData.email,
            metadata: { firebase_uid: authUser.uid },
        });
        accountId = account.id;
        await userRef.set({
            stripe_connect_account_id: accountId,
            stripe_connect_onboarding_complete: false,
            stripe_connect_created_at: admin.firestore.FieldValue.serverTimestamp(),
        }, { merge: true });
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
exports.getStripeConnectStatus = functions
    .region("asia-northeast1")
    .https.onCall(async (_data, context) => {
    var _a, _b, _c, _d;
    const authUser = (0, verifyAuth_1.verifyAuth)(context);
    const userSnap = await db().collection("users").doc(authUser.uid).get();
    if (!userSnap.exists) {
        throw new functions.https.HttpsError("not-found", "User profile not found.");
    }
    const userData = (_a = userSnap.data()) !== null && _a !== void 0 ? _a : {};
    const accountId = userData.stripe_connect_account_id;
    if (!accountId) {
        return {
            hasAccount: false,
            onboardingComplete: false,
            chargesEnabled: false,
            payoutsEnabled: false,
        };
    }
    const stripe = (0, config_1.getStripe)();
    const account = await stripe.accounts.retrieve(accountId);
    const onboardingComplete = (_b = account.details_submitted) !== null && _b !== void 0 ? _b : false;
    const chargesEnabled = (_c = account.charges_enabled) !== null && _c !== void 0 ? _c : false;
    const payoutsEnabled = (_d = account.payouts_enabled) !== null && _d !== void 0 ? _d : false;
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
//# sourceMappingURL=stripe-connect.js.map