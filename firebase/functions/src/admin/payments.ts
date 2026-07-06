import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { verifyAdmin } from "../auth/verifyAdmin";
import { writeAuditLog } from "./audit";

const db = () => admin.firestore();

export const adminGetLedger = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const type = data?.type as string | undefined;
    const reservationId = data?.reservationId as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);

    let baseQuery: FirebaseFirestore.Query = db().collection("ledger");
    if (type) {
      baseQuery = baseQuery.where("type", "==", type);
    }
    if (reservationId) {
      baseQuery = baseQuery.where("reservation_id", "==", reservationId);
    }

    const countSnap = await baseQuery.count().get();
    const total = countSnap.data().count;

    const snap = await baseQuery
      .orderBy("created_at", "desc")
      .offset(offset)
      .limit(limit)
      .get();
    const entries = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    return { entries, total, hasMore: offset + limit < total };
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
    const offset = Number(data?.offset ?? 0);

    let baseQuery: FirebaseFirestore.Query = db().collection("stripe_logs");
    if (eventType) {
      baseQuery = baseQuery.where("event_type", "==", eventType);
    }
    if (reservationId) {
      baseQuery = baseQuery.where("reservation_id", "==", reservationId);
    }

    const fetchLimit = startDate || endDate ? 500 : offset + limit;
    const snap = await baseQuery
      .orderBy("created_at", "desc")
      .limit(fetchLimit)
      .get();

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
      const total = logs.length;
      const page = logs.slice(offset, offset + limit);
      return { logs: page, total, hasMore: offset + limit < total };
    }

    const countSnap = await baseQuery.count().get();
    const total = countSnap.data().count;
    const pageSnap = await baseQuery
      .orderBy("created_at", "desc")
      .offset(offset)
      .limit(limit)
      .get();
    logs = pageSnap.docs.map((d) => ({ id: d.id, ...d.data() }));
    return { logs, total, hasMore: offset + limit < total };
  });

export const adminGetPayoutRequests = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const status = data?.status as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);

    let baseQuery: FirebaseFirestore.Query = db().collection("payout_requests");
    if (status) {
      baseQuery = baseQuery.where("status", "==", status);
    }

    const countSnap = await baseQuery.count().get();
    const total = countSnap.data().count;

    const snap = await baseQuery
      .orderBy("created_at", "desc")
      .offset(offset)
      .limit(limit)
      .get();
    const payouts = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    return { payouts, total, hasMore: offset + limit < total };
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
    await writeAuditLog({
      actorUid: adminUser.uid,
      action: `payout_${status}`,
      targetType: "payout",
      targetId: payoutId,
    });
    return { ok: true, payoutId, status };
  });
