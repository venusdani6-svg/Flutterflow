import * as functions from "firebase-functions";
import { AdminUserRecord } from "./verifyAdmin";

/** Screen-level permission keys (stored in users.admin_permissions). */
export const ADMIN_PERMISSION_KEYS = [
  "dashboard",
  "user_management",
  "reservations",
  "payment_ledger",
  "withdrawal",
  "kyc",
  "reports",
  "affiliate",
  "cocoten",
  "job_board",
  "banners",
  "system_settings",
  "audit_logs",
] as const;

export type AdminPermissionKey = (typeof ADMIN_PERMISSION_KEYS)[number];

export function isSuperAdmin(admin: AdminUserRecord): boolean {
  const role = admin.adminRole ?? "super_admin";
  return role === "super_admin";
}

export function isPrefectureAdmin(admin: AdminUserRecord): boolean {
  return admin.adminRole === "prefecture_admin";
}

export function getManagedPrefectures(
  admin: AdminUserRecord,
): string[] | null {
  if (isSuperAdmin(admin)) {
    return null;
  }
  return admin.managedPrefectures ?? [];
}

export function hasPermission(
  admin: AdminUserRecord,
  key: AdminPermissionKey,
): boolean {
  if (isSuperAdmin(admin)) {
    return true;
  }
  return admin.adminPermissions?.[key] === true;
}

export function requirePermission(
  admin: AdminUserRecord,
  key: AdminPermissionKey,
): void {
  if (!hasPermission(admin, key)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      `Missing permission: ${key}`,
    );
  }
}

export function requireSuperAdmin(admin: AdminUserRecord): void {
  if (!isSuperAdmin(admin)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Super administrator privileges are required.",
    );
  }
}

export function buildEffectivePermissions(
  admin: AdminUserRecord,
): Record<AdminPermissionKey, boolean> {
  const result = {} as Record<AdminPermissionKey, boolean>;
  for (const key of ADMIN_PERMISSION_KEYS) {
    result[key] = hasPermission(admin, key);
  }
  return result;
}

export function assertPrefectureAccess(
  admin: AdminUserRecord,
  documentPrefecture?: string,
): void {
  const scope = getManagedPrefectures(admin);
  if (scope === null) {
    return;
  }
  if (scope.length === 0) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "No managed prefectures assigned.",
    );
  }
  const prefecture = (documentPrefecture ?? "").trim();
  if (!prefecture || !scope.includes(prefecture)) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "This record is outside your managed prefectures.",
    );
  }
}

export function applyPrefectureQueryFilter(
  query: FirebaseFirestore.Query,
  prefectures: string[] | null,
): FirebaseFirestore.Query {
  if (prefectures === null) {
    return query;
  }
  if (prefectures.length === 0) {
    return query.where("prefecture", "==", "__none__");
  }
  if (prefectures.length <= 10) {
    return query.where("prefecture", "in", prefectures);
  }
  return query.where("prefecture", "in", prefectures.slice(0, 10));
}

export function filterRowsByPrefecture<T extends Record<string, unknown>>(
  rows: T[],
  prefectures: string[] | null,
  field = "prefecture",
): T[] {
  if (prefectures === null) {
    return rows;
  }
  if (prefectures.length === 0) {
    return [];
  }
  return rows.filter((row) => {
    const value = String(row[field] ?? "");
    return prefectures.includes(value);
  });
}

export function readPrefecture(data: Record<string, unknown>): string {
  return String(
    data.prefecture ?? data.service_prefecture ?? data.location_prefecture ?? "",
  );
}
