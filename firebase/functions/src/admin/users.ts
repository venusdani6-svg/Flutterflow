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

function applyUserFilters(
  query: FirebaseFirestore.Query,
  filters: {
    role?: number;
    roleAdmin?: string;
    kycStatus?: string;
    isFrozen?: boolean;
  },
  prefectures: string[] | null,
): FirebaseFirestore.Query {
  let q = applyPrefectureQueryFilter(query, prefectures);
  if (filters.role !== undefined) {
    q = q.where("role", "==", filters.role);
  }
  if (filters.roleAdmin) {
    q = q.where("role_admin", "==", filters.roleAdmin);
  }
  if (filters.kycStatus) {
    q = q.where("kyc_status", "==", filters.kycStatus);
  }
  if (filters.isFrozen !== undefined) {
    q = q.where("is_frozen", "==", filters.isFrozen);
  }
  return q;
}

export const adminGetUsers = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "user_management");
    const prefectures = getManagedPrefectures(adminUser);

    const role = data?.role as number | undefined;
    const roleAdmin = data?.roleAdmin as string | undefined;
    const kycStatus = data?.kycStatus as string | undefined;
    const search = ((data?.search as string) ?? "").trim().toLowerCase();
    const orderBy = (data?.orderBy as string) ?? "created_time";
    const orderDirection = (data?.orderDirection as string) ?? "desc";
    const isFrozen = data?.isFrozen as boolean | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);

    const filters = { role, roleAdmin, kycStatus, isFrozen };
    const orderField = ["created_time", "email", "display_name"].includes(
      orderBy,
    )
      ? orderBy
      : "created_time";

    if (search) {
      let query = applyUserFilters(db().collection("users"), filters, prefectures);
      query = query.orderBy(
        orderField,
        orderDirection === "asc" ? "asc" : "desc",
      );
      query = query.limit(500);
      const snap = await query.get();
      let users = snap.docs.map((d) => ({ id: d.id, ...d.data() })) as Record<
        string,
        unknown
      >[];
      users = filterRowsByPrefecture(users, prefectures);
      users = users.filter((u) => {
        const email = String(u.email ?? "").toLowerCase();
        const name = String(u.display_name ?? "").toLowerCase();
        return email.includes(search) || name.includes(search);
      });
      const total = users.length;
      const page = users.slice(offset, offset + limit);
      return { users: page, total, hasMore: offset + limit < total };
    }

    const baseQuery = applyUserFilters(db().collection("users"), filters, prefectures);
    const countSnap = await baseQuery.count().get();
    let total = countSnap.data().count;

    let dataQuery = baseQuery
      .orderBy(orderField, orderDirection === "asc" ? "asc" : "desc")
      .offset(offset)
      .limit(limit);
    const snap = await dataQuery.get();
    let users = snap.docs.map((d) => ({ id: d.id, ...d.data() }));

    if (prefectures && prefectures.length > 10) {
      users = filterRowsByPrefecture(users, prefectures);
      total = users.length;
    }

    return {
      users,
      total,
      hasMore: offset + limit < total,
    };
  });

export const adminGetUser = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "user_management");
    const userId = data?.userId as string;
    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required.",
      );
    }
    const doc = await db().collection("users").doc(userId).get();
    if (!doc.exists) {
      throw new functions.https.HttpsError("not-found", "User not found.");
    }
    const userData = doc.data() ?? {};
    assertPrefectureAccess(adminUser, readPrefecture(userData));
    return { id: doc.id, ...userData };
  });

export const adminApproveKYC = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "kyc");
    const userId = data?.userId as string;
    const approved = Boolean(data?.approved ?? true);
    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required.",
      );
    }
    const userDoc = await db().collection("users").doc(userId).get();
    const userData = userDoc.data() ?? {};
    assertPrefectureAccess(adminUser, readPrefecture(userData));
    const userName = String(userData.display_name ?? userId);
    const kycStatus = approved ? "approved" : "rejected";
    await db().collection("users").doc(userId).update({
      kyc_status: kycStatus,
      kyc_reviewed_at: admin.firestore.FieldValue.serverTimestamp(),
      kyc_reviewed_by: adminUser.uid,
    });
    await writeAuditLog({
      actorUid: adminUser.uid,
      action: approved ? "kyc_approved" : "kyc_rejected",
      targetType: "user",
      targetId: userId,
      targetUserName: userName,
    });
    return { ok: true, userId, kyc_status: kycStatus };
  });

export const adminToggleFreeze = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "user_management");
    const userId = data?.userId as string;
    const frozen = Boolean(data?.frozen);
    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required.",
      );
    }
    const userDoc = await db().collection("users").doc(userId).get();
    const userData = userDoc.data() ?? {};
    assertPrefectureAccess(adminUser, readPrefecture(userData));
    const userName = String(userData.display_name ?? userId);
    await db()
      .collection("users")
      .doc(userId)
      .update({ is_frozen: frozen, is_active: !frozen });
    await writeAuditLog({
      actorUid: adminUser.uid,
      action: frozen ? "user_frozen" : "user_unfrozen",
      targetType: "user",
      targetId: userId,
      targetUserName: userName,
    });
    return { ok: true, userId, frozen };
  });

export const adminForceDeleteUser = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "user_management");
    const userId = data?.userId as string;
    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required.",
      );
    }
    const userDoc = await db().collection("users").doc(userId).get();
    const userData = userDoc.data() ?? {};
    assertPrefectureAccess(adminUser, readPrefecture(userData));
    const userName = String(userData.display_name ?? userId);
    await writeAuditLog({
      actorUid: adminUser.uid,
      action: "user_deleted",
      targetType: "user",
      targetId: userId,
      targetUserName: userName,
    });
    await admin.auth().deleteUser(userId);
    await db().collection("users").doc(userId).delete();
    return { ok: true, userId };
  });
