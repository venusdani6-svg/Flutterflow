import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { verifyAdmin } from "../auth/verifyAdmin";

const db = () => admin.firestore();

export const adminGetReservations = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const status = data?.status as string | undefined;
    const search = ((data?.search as string) ?? "").trim().toLowerCase();
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);
    let query: FirebaseFirestore.Query = db()
      .collection("reservations")
      .orderBy("created_at", "desc");
    if (status) {
      query = query.where("status", "==", status);
    }
    const fetchLimit = search ? 500 : limit + offset;
    query = query.limit(fetchLimit);
    const snap = await query.get();
    let reservations = snap.docs.map((d) => ({ id: d.id, ...d.data() })) as Record<
      string,
      unknown
    >[];

    if (search) {
      reservations = reservations.filter((r) => {
        const id = String(r.id ?? "").toLowerCase();
        const guest = String(r.guest_id ?? "").toLowerCase();
        const cast = String(r.cast_id ?? "").toLowerCase();
        return id.includes(search) || guest.includes(search) || cast.includes(search);
      });
    }

    const total = reservations.length;
    const page = reservations.slice(offset, offset + limit);
    return { reservations: page, total, hasMore: offset + limit < total };
  });

export const adminGetReservation = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const reservationId = data?.reservationId as string;
    if (!reservationId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "reservationId is required.",
      );
    }
    const doc = await db().collection("reservations").doc(reservationId).get();
    if (!doc.exists) {
      throw new functions.https.HttpsError(
        "not-found",
        "Reservation not found.",
      );
    }
    return { id: doc.id, ...doc.data() };
  });

export const adminForceCancel = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    const reservationId = data?.reservationId as string;
    const reason = (data?.reason as string) ?? "admin_force_cancel";
    if (!reservationId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "reservationId is required.",
      );
    }
    await db().collection("reservations").doc(reservationId).update({
      status: "cancelled",
      cancelled_by: "admin",
      cancel_reason: reason,
      cancelled_at: admin.firestore.FieldValue.serverTimestamp(),
      cancelled_by_uid: adminUser.uid,
    });
    return { ok: true, reservationId };
  });

export const adminGetTipsByReservation = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const reservationId = data?.reservationId as string;
    if (!reservationId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "reservationId is required.",
      );
    }
    const snap = await db()
      .collection("ledger")
      .where("reservation_id", "==", reservationId)
      .where("type", "==", "tip")
      .get();
    const tips = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    const total = tips.reduce(
      (sum, t) => sum + Number((t as { amount?: number }).amount ?? 0),
      0,
    );
    return { tips, total, hasTips: tips.length > 0 };
  });
