import * as admin from "firebase-admin";

const db = () => admin.firestore();

export async function writeLedgerEntry(entry: {
  type: string;
  amount: number;
  reservationId?: string;
  userId?: string;
  description?: string;
  stripePaymentIntentId?: string;
  stripeChargeId?: string;
}): Promise<string> {
  const ref = await db().collection("ledger").add({
    type: entry.type,
    amount: entry.amount,
    reservation_id: entry.reservationId ?? null,
    user_id: entry.userId ?? null,
    description: entry.description ?? "",
    stripe_payment_intent_id: entry.stripePaymentIntentId ?? null,
    stripe_charge_id: entry.stripeChargeId ?? null,
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  return ref.id;
}

export async function writeStripeLog(params: {
  eventId: string;
  eventType: string;
  reservationId?: string;
  payload: Record<string, unknown>;
}): Promise<boolean> {
  const existing = await db()
    .collection("stripe_logs")
    .where("stripe_event_id", "==", params.eventId)
    .limit(1)
    .get();
  if (!existing.empty) {
    return false;
  }
  await db().collection("stripe_logs").add({
    stripe_event_id: params.eventId,
    event_type: params.eventType,
    reservation_id: params.reservationId ?? null,
    payload: params.payload,
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  return true;
}
