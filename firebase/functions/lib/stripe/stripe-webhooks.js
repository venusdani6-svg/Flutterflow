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
exports.stripeWebhook = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const config_1 = require("./config");
const ledger_1 = require("./ledger");
const db = () => admin.firestore();
function amountFromStripe(amount, currency) {
    const zeroDecimal = ["jpy", "krw", "vnd"].includes((currency !== null && currency !== void 0 ? currency : "jpy").toLowerCase());
    return zeroDecimal ? amount : amount / 100;
}
async function handlePaymentIntentSucceeded(paymentIntent) {
    var _a, _b, _c;
    const metadata = (_a = paymentIntent.metadata) !== null && _a !== void 0 ? _a : {};
    const reservationId = (_b = metadata.reservation_id) !== null && _b !== void 0 ? _b : metadata.reservationId;
    const userId = (_c = metadata.user_id) !== null && _c !== void 0 ? _c : metadata.guest_id;
    const amount = amountFromStripe(paymentIntent.amount_received || paymentIntent.amount, paymentIntent.currency);
    await (0, ledger_1.writeLedgerEntry)({
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
            .set({
            payment_status: "paid",
            stripe_payment_intent_id: paymentIntent.id,
            total_amount: amount,
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
        }, { merge: true })
            .catch(() => undefined);
    }
}
async function handleChargeRefunded(charge) {
    var _a, _b, _c, _d;
    const metadata = (_a = charge.metadata) !== null && _a !== void 0 ? _a : {};
    const reservationId = (_b = metadata.reservation_id) !== null && _b !== void 0 ? _b : metadata.reservationId;
    const userId = (_c = metadata.user_id) !== null && _c !== void 0 ? _c : metadata.guest_id;
    const amount = amountFromStripe(charge.amount_refunded, charge.currency);
    await (0, ledger_1.writeLedgerEntry)({
        type: "refund",
        amount: -Math.abs(amount),
        reservationId: reservationId || undefined,
        userId: userId || undefined,
        description: `Stripe refund ${charge.id}`,
        stripeChargeId: charge.id,
        stripePaymentIntentId: typeof charge.payment_intent === "string"
            ? charge.payment_intent
            : (_d = charge.payment_intent) === null || _d === void 0 ? void 0 : _d.id,
    });
}
async function handleAccountUpdated(account) {
    var _a, _b, _c;
    const snap = await db()
        .collection("users")
        .where("stripe_connect_account_id", "==", account.id)
        .limit(1)
        .get();
    if (snap.empty) {
        return;
    }
    await snap.docs[0].ref.update({
        stripe_connect_onboarding_complete: (_a = account.details_submitted) !== null && _a !== void 0 ? _a : false,
        stripe_connect_charges_enabled: (_b = account.charges_enabled) !== null && _b !== void 0 ? _b : false,
        stripe_connect_payouts_enabled: (_c = account.payouts_enabled) !== null && _c !== void 0 ? _c : false,
        stripe_connect_updated_at: admin.firestore.FieldValue.serverTimestamp(),
    });
}
async function reservationIdFromEvent(event) {
    var _a, _b, _c;
    const obj = event.data.object;
    return (_b = (_a = obj.metadata) === null || _a === void 0 ? void 0 : _a.reservation_id) !== null && _b !== void 0 ? _b : (_c = obj.metadata) === null || _c === void 0 ? void 0 : _c.reservationId;
}
async function processStripeEvent(event) {
    const reservationId = await reservationIdFromEvent(event);
    const isNew = await (0, ledger_1.writeStripeLog)({
        eventId: event.id,
        eventType: event.type,
        reservationId,
        payload: event.data.object,
    });
    if (!isNew) {
        return;
    }
    switch (event.type) {
        case "payment_intent.succeeded":
            await handlePaymentIntentSucceeded(event.data.object);
            break;
        case "charge.refunded":
            await handleChargeRefunded(event.data.object);
            break;
        case "account.updated":
            await handleAccountUpdated(event.data.object);
            break;
        default:
            break;
    }
}
/**
 * Stripe webhook endpoint. Register in Stripe Dashboard:
 * https://asia-northeast1-<project>.cloudfunctions.net/stripeWebhook
 */
exports.stripeWebhook = functions
    .region("asia-northeast1")
    .https.onRequest(async (req, res) => {
    var _a;
    if (req.method !== "POST") {
        res.status(405).send("Method Not Allowed");
        return;
    }
    const signature = req.headers["stripe-signature"];
    if (!signature || typeof signature !== "string") {
        res.status(400).send("Missing stripe-signature header");
        return;
    }
    const stripe = (0, config_1.getStripe)();
    let event;
    try {
        const rawBody = (_a = req.rawBody) !== null && _a !== void 0 ? _a : Buffer.from(typeof req.body === "string" ? req.body : JSON.stringify(req.body));
        event = stripe.webhooks.constructEvent(rawBody, signature, (0, config_1.getStripeWebhookSecret)());
    }
    catch (err) {
        const message = err instanceof Error ? err.message : "Invalid signature";
        functions.logger.error("Stripe webhook signature verification failed", message);
        res.status(400).send(`Webhook Error: ${message}`);
        return;
    }
    try {
        await processStripeEvent(event);
        res.json({ received: true, id: event.id, type: event.type });
    }
    catch (err) {
        functions.logger.error("Stripe webhook handler error", err);
        res.status(500).send("Webhook handler failed");
    }
});
//# sourceMappingURL=stripe-webhooks.js.map