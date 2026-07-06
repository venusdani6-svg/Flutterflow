import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { CallableContext } from "firebase-functions/v1/https";

export interface AdminUserRecord {
  uid: string;
  email?: string;
  roleAdmin?: string;
  adminRole?: string;
  adminPermissions?: Record<string, boolean>;
  managedPrefectures?: string[];
}

/**
 * Verifies the caller is authenticated and has role_admin == "admin".
 * All admin Cloud Functions must call this first.
 */
export async function verifyAdmin(
  context: CallableContext,
): Promise<AdminUserRecord> {
  if (!context.auth?.uid) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Authentication is required.",
    );
  }

  const userSnap = await admin
    .firestore()
    .collection("users")
    .doc(context.auth.uid)
    .get();

  if (!userSnap.exists) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "User profile not found.",
    );
  }

  const data = userSnap.data() ?? {};

  if (data.role_admin !== "admin") {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Administrator privileges are required.",
    );
  }

  return {
    uid: context.auth.uid,
    email: data.email as string | undefined,
    roleAdmin: data.role_admin as string | undefined,
    adminRole: data.admin_role as string | undefined,
    adminPermissions: data.admin_permissions as
      | Record<string, boolean>
      | undefined,
    managedPrefectures: data.managed_prefectures as string[] | undefined,
  };
}
