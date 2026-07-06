import * as functions from "firebase-functions";
import Stripe from "stripe";

let stripeClient: Stripe | null = null;

export function getStripeSecretKey(): string {
  const key =
    process.env.STRIPE_SECRET_KEY ??
    (functions.config().stripe?.secret_key as string | undefined);
  if (!key) {
    throw new Error(
      "STRIPE_SECRET_KEY is not configured. Set via firebase functions:secrets:set or functions.config().",
    );
  }
  return key;
}

export function getStripeWebhookSecret(): string {
  const secret =
    process.env.STRIPE_WEBHOOK_SECRET ??
    (functions.config().stripe?.webhook_secret as string | undefined);
  if (!secret) {
    throw new Error(
      "STRIPE_WEBHOOK_SECRET is not configured. Set via firebase functions:secrets:set or functions.config().",
    );
  }
  return secret;
}

export function getStripe(): Stripe {
  if (!stripeClient) {
    stripeClient = new Stripe(getStripeSecretKey(), {
      apiVersion: "2020-08-27",
    });
  }
  return stripeClient;
}
