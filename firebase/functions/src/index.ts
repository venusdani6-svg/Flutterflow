import * as admin from "firebase-admin";

admin.initializeApp();

export { onUserDeleted } from "./triggers/auth";
export {
  adminGetDashboardStats,
  adminHealthCheck,
  adminGetUsers,
  adminApproveKYC,
  adminToggleFreeze,
  adminForceDeleteUser,
  adminGetReservations,
  adminForceCancel,
  adminGetTipsByReservation,
  adminGetLedger,
  adminGetStripeLogs,
  adminApprovePayout,
  adminUpdateSystemConfig,
  adminGetSystemConfig,
  adminUpsertBanner,
  adminGetReports,
  adminResolveReport,
  adminGetAffiliateOverview,
  adminUpdateAffiliateRate,
  adminGetAuditLogs,
} from "./admin";
