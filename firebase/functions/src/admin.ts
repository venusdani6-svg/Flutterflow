import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import { verifyAdmin } from "./auth/verifyAdmin";

const db = () => admin.firestore();

function startOfTodayJst(): Date {
  const now = new Date();
  const jstOffsetMs = 9 * 60 * 60 * 1000;
  const jst = new Date(now.getTime() + jstOffsetMs);
  jst.setUTCHours(0, 0, 0, 0);
  return new Date(jst.getTime() - jstOffsetMs);
}

async function countUsersByRole(role: number): Promise<number> {
  const snap = await db()
    .collection("users")
    .where("role", "==", role)
    .count()
    .get();
  return snap.data().count;
}

async function countTodayRegistrations(): Promise<number> {
  const snap = await db()
    .collection("users")
    .where("created_time", ">=", startOfTodayJst())
    .count()
    .get();
  return snap.data().count;
}

async function countPendingKyc(): Promise<number> {
  const snap = await db()
    .collection("users")
    .where("kyc_status", "==", "pending")
    .count()
    .get()
    .catch(() => null);
  return snap?.data().count ?? 0;
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
    await verifyAdmin(context);

    const [
      todayNewRegistrations,
      guestCount,
      castCount,
      staffCount,
      pendingKyc,
      reservationCount,
      monthlySales,
    ] = await Promise.all([
      countTodayRegistrations(),
      countUsersByRole(0).catch(() => 0),
      countUsersByRole(1).catch(() => 0),
      countUsersByRole(2).catch(() => 0),
      countPendingKyc(),
      countCollection("reservations"),
      getMonthlySales(),
    ]);

    return {
      todayNewRegistrations,
      reservationCount,
      pendingKycCount: pendingKyc,
      salesToday: 0,
      userTypeCounts: {
        guest: guestCount,
        cast: castCount,
        staff: staffCount,
      },
      monthlySales,
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
  adminApproveKYC,
  adminToggleFreeze,
  adminForceDeleteUser,
} from "./admin/users";
export {
  adminGetReservations,
  adminForceCancel,
  adminGetTipsByReservation,
} from "./admin/reservations";
export {
  adminGetLedger,
  adminGetStripeLogs,
  adminApprovePayout,
} from "./admin/payments";
export {
  adminUpdateSystemConfig,
  adminGetSystemConfig,
  adminUpsertBanner,
  adminGetReports,
  adminResolveReport,
  adminGetAffiliateOverview,
  adminUpdateAffiliateRate,
  adminGetAuditLogs,
} from "./admin/content";
