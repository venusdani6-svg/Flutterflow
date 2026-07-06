import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { verifyAdmin } from "../auth/verifyAdmin";

const db = () => admin.firestore();

export const adminGetLedger = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const type = data?.type as string | undefined;
    const reservationId = data?.reservationId as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    let query: FirebaseFirestore.Query = db()
      .collection("ledger")
      .orderBy("created_at", "desc")
      .limit(limit);
    if (type) {
      query = query.where("type", "==", type);
    }
    if (reservationId) {
      query = query.where("reservation_id", "==", reservationId);
    }
    const snap = await query.get().catch(async () => {
      return db().collection("ledger").limit(limit).get();
    });
    const entries = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    return { entries, total: entries.length };
  });

export const adminGetStripeLogs = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const eventType = data?.eventType as string | undefined;
    const reservationId = data?.reservationId as string | undefined;
    const startDate = data?.startDate as string | undefined;
    const endDate = data?.endDate as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);

    let query: FirebaseFirestore.Query = db()
      .collection("stripe_logs")
      .orderBy("created_at", "desc")
      .limit(limit);
    if (eventType) {
      query = query.where("event_type", "==", eventType);
    }
    if (reservationId) {
      query = query.where("reservation_id", "==", reservationId);
    }
    const snap = await query.get().catch(async () => {
      return db().collection("stripe_logs").limit(limit).get();
    });
    let logs = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    if (startDate || endDate) {
      const start = startDate ? new Date(startDate).getTime() : 0;
      const end = endDate ? new Date(endDate).getTime() : Date.now();
      logs = logs.filter((log) => {
        const created = (log as { created_at?: { toDate?: () => Date } })
          .created_at;
        const ts = created?.toDate?.()?.getTime() ?? 0;
        return ts >= start && ts <= end;
      });
    }
    return { logs, total: logs.length };
  });

export const adminGetPayoutRequests = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const status = data?.status as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);
    let query: FirebaseFirestore.Query = db()
      .collection("payout_requests")
      .orderBy("created_at", "desc");
    if (status) {
      query = query.where("status", "==", status);
    }
    const fetchLimit = limit + offset;
    query = query.limit(fetchLimit);
    const snap = await query.get();
    const all = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    const total = all.length;
    const page = all.slice(offset, offset + limit);
    return { payouts: page, total, hasMore: offset + limit < total };
  });

export const adminApprovePayout = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    const payoutId = data?.payoutId as string;
    const status = (data?.status as string) ?? "approved";
    const allowed = ["approved", "on_hold", "rejected", "pending"];
    if (!payoutId || !allowed.includes(status)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "payoutId and valid status are required.",
      );
    }
    await db()
      .collection("payout_requests")
      .doc(payoutId)
      .update({
        status,
        reviewed_at: admin.firestore.FieldValue.serverTimestamp(),
        reviewed_by: adminUser.uid,
      });
    return { ok: true, payoutId, status };
  });
