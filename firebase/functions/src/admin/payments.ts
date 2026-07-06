import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {
  applyPrefectureQueryFilter,
  assertPrefectureAccess,
  filterRowsByPrefecture,
  getManagedPrefectures,
  readPrefecture,
  requirePermission,
} from "../auth/adminPermissions";
import { verifyAdmin } from "../auth/verifyAdmin";
import { writeAuditLog } from "./audit";

const db = () => admin.firestore();

async function filterPayoutsByPrefecture(
  payouts: Record<string, unknown>[],
  prefectures: string[] | null,
): Promise<Record<string, unknown>[]> {
  if (prefectures === null) {
    return payouts;
  }
  const filtered: Record<string, unknown>[] = [];
  for (const payout of payouts) {
    const userId = String(payout.user_id ?? "");
    if (!userId) {
      continue;
    }
    const userSnap = await db().collection("users").doc(userId).get();
    const prefecture = readPrefecture(userSnap.data() ?? {});
    if (prefectures.includes(prefecture)) {
      filtered.push(payout);
    }
  }
  return filtered;
}

async function filterLedgerByPrefecture(
  entries: Record<string, unknown>[],
  prefectures: string[] | null,
): Promise<Record<string, unknown>[]> {
  if (prefectures === null) {
    return entries;
  }
  const filtered: Record<string, unknown>[] = [];
  for (const entry of entries) {
    const direct = readPrefecture(entry);
    if (direct && prefectures.includes(direct)) {
      filtered.push(entry);
      continue;
    }
    const reservationId = String(entry.reservation_id ?? "");
    if (reservationId) {
      const reservation = await db()
        .collection("reservations")
        .doc(reservationId)
        .get();
      const prefecture = readPrefecture(reservation.data() ?? {});
      if (prefectures.includes(prefecture)) {
        filtered.push(entry);
      }
      continue;
    }
    const userId = String(entry.user_id ?? "");
    if (userId) {
      const userSnap = await db().collection("users").doc(userId).get();
      const prefecture = readPrefecture(userSnap.data() ?? {});
      if (prefectures.includes(prefecture)) {
        filtered.push(entry);
      }
    }
  }
  return filtered;
}

export const adminGetLedger = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "payment_ledger");
    const prefectures = getManagedPrefectures(adminUser);

    const type = data?.type as string | undefined;
    const reservationId = data?.reservationId as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);

    let baseQuery: FirebaseFirestore.Query = applyPrefectureQueryFilter(
      db().collection("ledger"),
      prefectures,
    );
    if (type) {
      baseQuery = baseQuery.where("type", "==", type);
    }
    if (reservationId) {
      baseQuery = baseQuery.where("reservation_id", "==", reservationId);
    }

    const snap = await baseQuery
      .orderBy("created_at", "desc")
      .limit(prefectures ? 500 : offset + limit)
      .get();
    let entries = snap.docs.map((d) => ({ id: d.id, ...d.data() })) as Record<
      string,
      unknown
    >[];
    entries = filterRowsByPrefecture(entries, prefectures);
    if (prefectures) {
      entries = await filterLedgerByPrefecture(entries, prefectures);
    }
    const total = entries.length;
    const page = entries.slice(offset, offset + limit);
    return { entries: page, total, hasMore: offset + limit < total };
  });

export const adminGetStripeLogs = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "payment_ledger");
    const prefectures = getManagedPrefectures(adminUser);

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

    const fetchLimit = startDate || endDate || prefectures ? 500 : offset + limit;
    const snap = await baseQuery
      .orderBy("created_at", "desc")
      .limit(fetchLimit)
      .get();

    let logs = snap.docs.map((d) => ({ id: d.id, ...d.data() })) as Record<
      string,
      unknown
    >[];

    if (prefectures) {
      const filtered: Record<string, unknown>[] = [];
      for (const log of logs) {
        const reservationIdValue = String(log.reservation_id ?? "");
        if (!reservationIdValue) {
          continue;
        }
        const reservation = await db()
          .collection("reservations")
          .doc(reservationIdValue)
          .get();
        const prefecture = readPrefecture(reservation.data() ?? {});
        if (prefectures.includes(prefecture)) {
          filtered.push(log);
        }
      }
      logs = filtered;
    }

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

    const total = logs.length;
    const page = logs.slice(offset, offset + limit);
    return { logs: page, total, hasMore: offset + limit < total };
  });

export const adminGetPayoutRequests = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "withdrawal");
    const prefectures = getManagedPrefectures(adminUser);

    const status = data?.status as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);

    let baseQuery: FirebaseFirestore.Query = applyPrefectureQueryFilter(
      db().collection("payout_requests"),
      prefectures,
    );
    if (status) {
      baseQuery = baseQuery.where("status", "==", status);
    }

    const snap = await baseQuery
      .orderBy("created_at", "desc")
      .limit(prefectures ? 500 : offset + limit)
      .get();
    let payouts = snap.docs.map((d) => ({ id: d.id, ...d.data() })) as Record<
      string,
      unknown
    >[];
    payouts = filterRowsByPrefecture(payouts, prefectures);
    if (prefectures) {
      payouts = await filterPayoutsByPrefecture(payouts, prefectures);
    }
    const total = payouts.length;
    const page = payouts.slice(offset, offset + limit);
    return { payouts: page, total, hasMore: offset + limit < total };
  });

export const adminApprovePayout = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "withdrawal");
    const payoutId = data?.payoutId as string;
    const status = (data?.status as string) ?? "approved";
    const allowed = ["approved", "on_hold", "rejected", "pending"];
    if (!payoutId || !allowed.includes(status)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "payoutId and valid status are required.",
      );
    }
    const payoutDoc = await db().collection("payout_requests").doc(payoutId).get();
    if (!payoutDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Payout not found.");
    }
    const payoutData = payoutDoc.data() ?? {};
    const directPrefecture = readPrefecture(payoutData);
    if (directPrefecture) {
      assertPrefectureAccess(adminUser, directPrefecture);
    } else {
      const userId = String(payoutData.user_id ?? "");
      const userSnap = userId
        ? await db().collection("users").doc(userId).get()
        : null;
      assertPrefectureAccess(adminUser, readPrefecture(userSnap?.data() ?? {}));
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
