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
export {
  adminGetCocotenShops,
  adminUpsertCocotenShop,
  adminGetJobBoardPosts,
  adminUpsertJobBoardPost,
} from "./admin/cocoten";
export { adminGetMyPermissions, adminUpdateAdminAccess } from "./admin/permissions";

export { stripeWebhook } from "./stripe/stripe-webhooks";
export {
  createStripeConnectOnboardingLink,
  getStripeConnectStatus,
} from "./stripe/stripe-connect";
export { getAppHomeData, getAppFeatureFlags } from "./mobile/app-public";
