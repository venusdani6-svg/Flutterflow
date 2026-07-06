import * as admin from "firebase-admin";

admin.initializeApp();

export { onUserDeleted } from "./triggers/auth";
export {
  adminGetDashboardStats,
  adminHealthCheck,
  adminGetUsers,
  adminGetUser,
  adminApproveKYC,
  adminToggleFreeze,
  adminForceDeleteUser,
  adminGetReservations,
  adminGetReservation,
  adminForceCancel,
  adminGetTipsByReservation,
  adminGetLedger,
  adminGetStripeLogs,
  adminGetPayoutRequests,
  adminApprovePayout,
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
} from "./admin";
