import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import Stripe from "stripe";
import { getStripe, getStripeWebhookSecret } from "./config";
import { writeLedgerEntry, writeStripeLog } from "./ledger";

const db = () => admin.firestore();

function amountFromStripe(amount: number, currency?: string): number {
  const zeroDecimal = ["jpy", "krw", "vnd"].includes((currency ?? "jpy").toLowerCase());
  return zeroDecimal ? amount : amount / 100;
}

async function handlePaymentIntentSucceeded(
  paymentIntent: Stripe.PaymentIntent,
): Promise<void> {
  const metadata = paymentIntent.metadata ?? {};
  const reservationId = metadata.reservation_id ?? metadata.reservationId;
  const userId = metadata.user_id ?? metadata.guest_id;
  const amount = amountFromStripe(
    paymentIntent.amount_received || paymentIntent.amount,
    paymentIntent.currency,
  );

  await writeLedgerEntry({
    type: "payment",
    amount,
    reservationId: reservationId || undefined,
    userId: userId || undefined,
    description: `Stripe payment ${paymentIntent.id}`,
    stripePaymentIntentId: paymentIntent.id,
  });

  if (reservationId) {
    await db()
      .collection("reservations")
      .doc(reservationId)
      .set(
        {
          payment_status: "paid",
          stripe_payment_intent_id: paymentIntent.id,
          total_amount: amount,
          updated_at: admin.firestore.FieldValue.serverTimestamp(),
        },
        { merge: true },
      )
      .catch(() => undefined);
  }
}

async function handleChargeRefunded(charge: Stripe.Charge): Promise<void> {
  const metadata = charge.metadata ?? {};
  const reservationId = metadata.reservation_id ?? metadata.reservationId;
  const userId = metadata.user_id ?? metadata.guest_id;
  const amount = amountFromStripe(
    charge.amount_refunded,
    charge.currency,
  );

  await writeLedgerEntry({
    type: "refund",
    amount: -Math.abs(amount),
    reservationId: reservationId || undefined,
    userId: userId || undefined,
    description: `Stripe refund ${charge.id}`,
    stripeChargeId: charge.id,
    stripePaymentIntentId:
      typeof charge.payment_intent === "string"
        ? charge.payment_intent
        : charge.payment_intent?.id,
  });
}

async function handleAccountUpdated(account: Stripe.Account): Promise<void> {
  const snap = await db()
    .collection("users")
    .where("stripe_connect_account_id", "==", account.id)
    .limit(1)
    .get();
  if (snap.empty) {
    return;
  }
  await snap.docs[0].ref.update({
    stripe_connect_onboarding_complete: account.details_submitted ?? false,
    stripe_connect_charges_enabled: account.charges_enabled ?? false,
    stripe_connect_payouts_enabled: account.payouts_enabled ?? false,
    stripe_connect_updated_at: admin.firestore.FieldValue.serverTimestamp(),
  });
}

async function reservationIdFromEvent(event: Stripe.Event): Promise<string | undefined> {
  const obj = event.data.object as { metadata?: Record<string, string> };
  return obj.metadata?.reservation_id ?? obj.metadata?.reservationId;
}

async function processStripeEvent(event: Stripe.Event): Promise<void> {
  const reservationId = await reservationIdFromEvent(event);

  const isNew = await writeStripeLog({
    eventId: event.id,
    eventType: event.type,
    reservationId,
    payload: event.data.object as unknown as Record<string, unknown>,
  });
  if (!isNew) {
    return;
  }

  switch (event.type) {
    case "payment_intent.succeeded":
      await handlePaymentIntentSucceeded(event.data.object as Stripe.PaymentIntent);
      break;
    case "charge.refunded":
      await handleChargeRefunded(event.data.object as Stripe.Charge);
      break;
    case "account.updated":
      await handleAccountUpdated(event.data.object as Stripe.Account);
      break;
    default:
      break;
  }
}

/**
 * Stripe webhook endpoint. Register in Stripe Dashboard:
 * https://asia-northeast1-<project>.cloudfunctions.net/stripeWebhook
 */
export const stripeWebhook = functions
  .region("asia-northeast1")
  .https.onRequest(async (req, res) => {
    if (req.method !== "POST") {
      res.status(405).send("Method Not Allowed");
      return;
    }

    const signature = req.headers["stripe-signature"];
    if (!signature || typeof signature !== "string") {
      res.status(400).send("Missing stripe-signature header");
      return;
    }

    const stripe = getStripe();
    let event: Stripe.Event;
    try {
      const rawBody =
        (req as functions.https.Request & { rawBody?: Buffer }).rawBody ??
        Buffer.from(typeof req.body === "string" ? req.body : JSON.stringify(req.body));
      event = stripe.webhooks.constructEvent(
        rawBody,
        signature,
        getStripeWebhookSecret(),
      );
    } catch (err) {
      const message = err instanceof Error ? err.message : "Invalid signature";
      functions.logger.error("Stripe webhook signature verification failed", message);
      res.status(400).send(`Webhook Error: ${message}`);
      return;
    }

    try {
      await processStripeEvent(event);
      res.json({ received: true, id: event.id, type: event.type });
    } catch (err) {
      functions.logger.error("Stripe webhook handler error", err);
      res.status(500).send("Webhook handler failed");
    }
  });
