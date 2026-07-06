import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { verifyAdmin } from "../auth/verifyAdmin";

const db = () => admin.firestore();

function paginate<T>(
  docs: FirebaseFirestore.QueryDocumentSnapshot[],
  limit = 50,
  offset = 0,
): T[] {
  return docs.slice(offset, offset + limit).map((d) => ({
    id: d.id,
    ...d.data(),
  })) as T[];
}

export const adminGetUsers = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const role = data?.role as number | undefined;
    const kycStatus = data?.kycStatus as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);

    let query: FirebaseFirestore.Query = db().collection("users");
    if (role !== undefined) {
      query = query.where("role", "==", role);
    }
    if (kycStatus) {
      query = query.where("kyc_status", "==", kycStatus);
    }
    query = query.orderBy("created_time", "desc").limit(limit + offset);
    const snap = await query.get();
    return { users: paginate(snap.docs, limit, offset), total: snap.size };
  });

export const adminApproveKYC = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    const userId = data?.userId as string;
    const approved = Boolean(data?.approved ?? true);
    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required.",
      );
    }
    await db()
      .collection("users")
      .doc(userId)
      .update({
        kyc_status: approved ? "approved" : "rejected",
        kyc_reviewed_at: admin.firestore.FieldValue.serverTimestamp(),
        kyc_reviewed_by: adminUser.uid,
      });
    return { ok: true, userId, kyc_status: approved ? "approved" : "rejected" };
  });

export const adminToggleFreeze = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const userId = data?.userId as string;
    const frozen = Boolean(data?.frozen);
    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required.",
      );
    }
    await db()
      .collection("users")
      .doc(userId)
      .update({ is_frozen: frozen, is_active: !frozen });
    return { ok: true, userId, frozen };
  });

export const adminForceDeleteUser = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    await verifyAdmin(context);
    const userId = data?.userId as string;
    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required.",
      );
    }
    await admin.auth().deleteUser(userId);
    await db().collection("users").doc(userId).delete();
    return { ok: true, userId };
  });
