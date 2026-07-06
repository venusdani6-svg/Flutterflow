import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {
  ADMIN_PERMISSION_KEYS,
  buildEffectivePermissions,
  requireSuperAdmin,
} from "../auth/adminPermissions";
import { verifyAdmin } from "../auth/verifyAdmin";

const db = () => admin.firestore();

/** Returns effective permissions for the signed-in admin (menu + client guards). */
export const adminGetMyPermissions = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    const adminUser = await verifyAdmin(context);
    return {
      isSuperAdmin:
        !adminUser.adminRole || adminUser.adminRole === "super_admin",
      adminRole: adminUser.adminRole ?? "super_admin",
      permissions: buildEffectivePermissions(adminUser),
      permissionKeys: [...ADMIN_PERMISSION_KEYS],
      managedPrefectures: adminUser.managedPrefectures ?? [],
    };
  });

/** Super admin only: update another admin user's role, permissions, prefectures. */
export const adminUpdateAdminAccess = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requireSuperAdmin(adminUser);

    const userId = data?.userId as string;
    if (!userId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId is required.",
      );
    }

    const targetRef = db().collection("users").doc(userId);
    const targetSnap = await targetRef.get();
    if (!targetSnap.exists) {
      throw new functions.https.HttpsError("not-found", "User not found.");
    }
    if (targetSnap.data()?.role_admin !== "admin") {
      throw new functions.https.HttpsError(
        "failed-precondition",
        "Target user is not an administrator.",
      );
    }

    const update: Record<string, unknown> = {
      admin_access_updated_at: admin.firestore.FieldValue.serverTimestamp(),
      admin_access_updated_by: adminUser.uid,
    };

    if (data?.adminRole !== undefined) {
      const adminRole = data.adminRole as string;
      if (!["super_admin", "prefecture_admin"].includes(adminRole)) {
        throw new functions.https.HttpsError(
          "invalid-argument",
          "adminRole must be super_admin or prefecture_admin.",
        );
      }
      update.admin_role = adminRole;
    }

    if (data?.adminPermissions !== undefined) {
      const perms = data.adminPermissions as Record<string, boolean>;
      const sanitized: Record<string, boolean> = {};
      for (const key of ADMIN_PERMISSION_KEYS) {
        sanitized[key] = perms[key] === true;
      }
      update.admin_permissions = sanitized;
    }

    if (data?.managedPrefectures !== undefined) {
      const prefectures = (data.managedPrefectures as string[]) ?? [];
      update.managed_prefectures = prefectures.filter(
        (p) => typeof p === "string" && p.trim().length > 0,
      );
    }

    await targetRef.set(update, { merge: true });
    return { ok: true, userId };
  });
