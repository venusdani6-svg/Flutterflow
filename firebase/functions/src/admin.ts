import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {
  applyPrefectureQueryFilter,
  getManagedPrefectures,
  requirePermission,
} from "./auth/adminPermissions";
import { verifyAdmin } from "./auth/verifyAdmin";

const db = () => admin.firestore();

function startOfTodayJst(): Date {
  const now = new Date();
  const jstOffsetMs = 9 * 60 * 60 * 1000;
  const jst = new Date(now.getTime() + jstOffsetMs);
  jst.setUTCHours(0, 0, 0, 0);
  return new Date(jst.getTime() - jstOffsetMs);
}

async function countUsersByRole(
  role: number,
  prefectures: string[] | null,
): Promise<number> {
  const snap = await applyPrefectureQueryFilter(
    db().collection("users").where("role", "==", role),
    prefectures,
  )
    .count()
    .get();
  return snap.data().count;
}

async function countTodayRegistrations(
  prefectures: string[] | null,
): Promise<number> {
  const snap = await applyPrefectureQueryFilter(
    db()
      .collection("users")
      .where("created_time", ">=", startOfTodayJst()),
    prefectures,
  )
    .count()
    .get();
  return snap.data().count;
}

async function countPendingKyc(prefectures: string[] | null): Promise<number> {
  const snap = await applyPrefectureQueryFilter(
    db().collection("users").where("kyc_status", "==", "pending"),
    prefectures,
  )
    .count()
    .get()
    .catch(() => null);
  return snap?.data().count ?? 0;
}

async function countTodayReservations(
  prefectures: string[] | null,
): Promise<number> {
  const snap = await applyPrefectureQueryFilter(
    db()
      .collection("reservations")
      .where("created_at", ">=", startOfTodayJst()),
    prefectures,
  )
    .count()
    .get()
    .catch(() => null);
  return snap?.data().count ?? 0;
}

async function countPendingPayouts(
  prefectures: string[] | null,
): Promise<number> {
  const snap = await applyPrefectureQueryFilter(
    db().collection("payout_requests").where("status", "==", "pending"),
    prefectures,
  )
    .count()
    .get()
    .catch(() => null);
  return snap?.data().count ?? 0;
}

async function countPendingReports(
  prefectures: string[] | null,
): Promise<number> {
  const snap = await applyPrefectureQueryFilter(
    db().collection("reports").where("status", "in", ["pending", "open"]),
    prefectures,
  )
    .count()
    .get()
    .catch(() => null);
  return snap?.data().count ?? 0;
}

async function countAffiliates(prefectures: string[] | null): Promise<number> {
  const snap = await applyPrefectureQueryFilter(
    db().collection("users").where("is_affiliate", "==", true),
    prefectures,
  )
    .count()
    .get()
    .catch(() => null);
  if (snap) {
    return snap.data().count;
  }
  return countCollection("affiliate_stats");
}

async function countCocotenShops(): Promise<number> {
  return countCollection("cocoten_shops");
}

async function countJobBoardPosts(): Promise<number> {
  return countCollection("job_board");
}

async function getSalesToday(prefectures: string[] | null): Promise<number> {
  const snap = await applyPrefectureQueryFilter(
    db()
      .collection("ledger")
      .where("type", "==", "payment")
      .where("created_at", ">=", startOfTodayJst()),
    prefectures,
  )
    .get()
    .catch(() => null);
  if (!snap) {
    return 0;
  }
  return snap.docs.reduce(
    (sum, doc) => sum + Number(doc.data().amount ?? 0),
    0,
  );
}

async function getRecentActivityLogs(): Promise<
  Record<string, unknown>[]
> {
  const snap = await db()
    .collection("audit_logs")
    .orderBy("created_at", "desc")
    .limit(5)
    .get()
    .catch(() => null);
  if (!snap) {
    return [];
  }
  return snap.docs.map((doc) => {
    const data = doc.data();
    const createdAt = data.created_at as admin.firestore.Timestamp | undefined;
    return {
      id: doc.id,
      action: data.action ?? "",
      targetType: data.target_type ?? "",
      targetId: data.target_id ?? "",
      targetUserName: data.target_user_name ?? data.target_id ?? "-",
      actorUid: data.actor_uid ?? "",
      createdAt: createdAt?.toDate?.()?.toISOString() ?? null,
    };
  });
}

async function countCollection(name: string): Promise<number> {
  const snap = await db().collection(name).count().get().catch(() => null);
  return snap?.data().count ?? 0;
}

async function getMonthlySales(): Promise<
  { month: string; amount: number }[]
> {
  const snap = await db()
    .collection("monthly_sales")
    .orderBy("month", "asc")
    .limit(12)
    .get()
    .catch(() => null);

  if (!snap || snap.empty) {
    return [];
  }

  return snap.docs.map((doc) => {
    const data = doc.data();
    return {
      month: String(data.month ?? doc.id),
      amount: Number(data.amount ?? data.total ?? 0),
    };
  });
}

/**
 * Dashboard KPI and chart data for the admin home screen.
 */
export const adminGetDashboardStats = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "dashboard");
    const prefectures = getManagedPrefectures(adminUser);

    const [
      todayNewRegistrations,
      guestCount,
      castCount,
      staffCount,
      pendingKyc,
      todayReservations,
      salesToday,
      pendingPayouts,
      pendingReports,
      affiliateCount,
      cocotenShopCount,
      jobBoardPostCount,
      monthlySales,
      recentActivityLogs,
    ] = await Promise.all([
      countTodayRegistrations(prefectures),
      countUsersByRole(0, prefectures).catch(() => 0),
      countUsersByRole(1, prefectures).catch(() => 0),
      countUsersByRole(2, prefectures).catch(() => 0),
      countPendingKyc(prefectures),
      countTodayReservations(prefectures),
      getSalesToday(prefectures),
      countPendingPayouts(prefectures),
      countPendingReports(prefectures),
      countAffiliates(prefectures),
      countCocotenShops(),
      countJobBoardPosts(),
      getMonthlySales(),
      getRecentActivityLogs(),
    ]);

    return {
      todayNewRegistrations,
      todayReservationCount: todayReservations,
      reservationCount: todayReservations,
      pendingKycCount: pendingKyc,
      salesToday,
      pendingPayoutCount: pendingPayouts,
      pendingReportsCount: pendingReports,
      affiliateCount,
      cocotenShopCount,
      jobBoardPostCount,
      userTypeCounts: {
        guest: guestCount,
        cast: castCount,
        staff: staffCount,
      },
      monthlySales,
      recentActivityLogs,
      managedPrefectures: prefectures ?? [],
      generatedAt: new Date().toISOString(),
    };
  });

/**
 * Health-check callable for deployment verification.
 */
export const adminHealthCheck = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    const adminUser = await verifyAdmin(context);
    return {
      ok: true,
      uid: adminUser.uid,
      email: adminUser.email ?? null,
    };
  });

export {
  adminGetUsers,
  adminGetUser,
  adminApproveKYC,
  adminToggleFreeze,
  adminForceDeleteUser,
} from "./admin/users";
export {
  adminGetReservations,
  adminGetReservation,
  adminForceCancel,
  adminGetTipsByReservation,
} from "./admin/reservations";
export {
  adminGetLedger,
  adminGetStripeLogs,
  adminGetPayoutRequests,
  adminApprovePayout,
} from "./admin/payments";
export {
  adminUpdateSystemConfig,
  adminGetSystemConfig,
  adminGetBanners,
  adminUpsertBanner,
  adminGetReports,
  adminResolveReport,
  adminGetAffiliateOverview,
  adminUpdateAffiliateRate,
  adminGetAuditLogs,
  adminGetAnnouncements,
  adminUpsertAnnouncement,
  adminGetGuideline,
  adminUpdateGuideline,
} from "./admin/content";
export { adminGetMyPermissions, adminUpdateAdminAccess } from "./admin/permissions";
