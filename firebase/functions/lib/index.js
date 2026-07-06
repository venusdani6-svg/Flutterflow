"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.getAppFeatureFlags = exports.getAppHomeData = exports.getStripeConnectStatus = exports.createStripeConnectOnboardingLink = exports.stripeWebhook = exports.adminUpdateGuideline = exports.adminGetGuideline = exports.adminUpsertAnnouncement = exports.adminGetAnnouncements = exports.adminGetAuditLogs = exports.adminUpdateAffiliateRate = exports.adminGetAffiliateOverview = exports.adminResolveReport = exports.adminGetReports = exports.adminUpsertBanner = exports.adminGetBanners = exports.adminGetSystemConfig = exports.adminUpdateSystemConfig = exports.adminApprovePayout = exports.adminGetPayoutRequests = exports.adminGetStripeLogs = exports.adminGetLedger = exports.adminGetTipsByReservation = exports.adminForceCancel = exports.adminGetReservation = exports.adminGetReservations = exports.adminForceDeleteUser = exports.adminToggleFreeze = exports.adminApproveKYC = exports.adminGetUser = exports.adminGetUsers = exports.adminHealthCheck = exports.adminGetDashboardStats = exports.onUserDeleted = void 0;
const admin = __importStar(require("firebase-admin"));
admin.initializeApp();
var auth_1 = require("./triggers/auth");
Object.defineProperty(exports, "onUserDeleted", { enumerable: true, get: function () { return auth_1.onUserDeleted; } });
var admin_1 = require("./admin");
Object.defineProperty(exports, "adminGetDashboardStats", { enumerable: true, get: function () { return admin_1.adminGetDashboardStats; } });
Object.defineProperty(exports, "adminHealthCheck", { enumerable: true, get: function () { return admin_1.adminHealthCheck; } });
Object.defineProperty(exports, "adminGetUsers", { enumerable: true, get: function () { return admin_1.adminGetUsers; } });
Object.defineProperty(exports, "adminGetUser", { enumerable: true, get: function () { return admin_1.adminGetUser; } });
Object.defineProperty(exports, "adminApproveKYC", { enumerable: true, get: function () { return admin_1.adminApproveKYC; } });
Object.defineProperty(exports, "adminToggleFreeze", { enumerable: true, get: function () { return admin_1.adminToggleFreeze; } });
Object.defineProperty(exports, "adminForceDeleteUser", { enumerable: true, get: function () { return admin_1.adminForceDeleteUser; } });
Object.defineProperty(exports, "adminGetReservations", { enumerable: true, get: function () { return admin_1.adminGetReservations; } });
Object.defineProperty(exports, "adminGetReservation", { enumerable: true, get: function () { return admin_1.adminGetReservation; } });
Object.defineProperty(exports, "adminForceCancel", { enumerable: true, get: function () { return admin_1.adminForceCancel; } });
Object.defineProperty(exports, "adminGetTipsByReservation", { enumerable: true, get: function () { return admin_1.adminGetTipsByReservation; } });
Object.defineProperty(exports, "adminGetLedger", { enumerable: true, get: function () { return admin_1.adminGetLedger; } });
Object.defineProperty(exports, "adminGetStripeLogs", { enumerable: true, get: function () { return admin_1.adminGetStripeLogs; } });
Object.defineProperty(exports, "adminGetPayoutRequests", { enumerable: true, get: function () { return admin_1.adminGetPayoutRequests; } });
Object.defineProperty(exports, "adminApprovePayout", { enumerable: true, get: function () { return admin_1.adminApprovePayout; } });
Object.defineProperty(exports, "adminUpdateSystemConfig", { enumerable: true, get: function () { return admin_1.adminUpdateSystemConfig; } });
Object.defineProperty(exports, "adminGetSystemConfig", { enumerable: true, get: function () { return admin_1.adminGetSystemConfig; } });
Object.defineProperty(exports, "adminGetBanners", { enumerable: true, get: function () { return admin_1.adminGetBanners; } });
Object.defineProperty(exports, "adminUpsertBanner", { enumerable: true, get: function () { return admin_1.adminUpsertBanner; } });
Object.defineProperty(exports, "adminGetReports", { enumerable: true, get: function () { return admin_1.adminGetReports; } });
Object.defineProperty(exports, "adminResolveReport", { enumerable: true, get: function () { return admin_1.adminResolveReport; } });
Object.defineProperty(exports, "adminGetAffiliateOverview", { enumerable: true, get: function () { return admin_1.adminGetAffiliateOverview; } });
Object.defineProperty(exports, "adminUpdateAffiliateRate", { enumerable: true, get: function () { return admin_1.adminUpdateAffiliateRate; } });
Object.defineProperty(exports, "adminGetAuditLogs", { enumerable: true, get: function () { return admin_1.adminGetAuditLogs; } });
Object.defineProperty(exports, "adminGetAnnouncements", { enumerable: true, get: function () { return admin_1.adminGetAnnouncements; } });
Object.defineProperty(exports, "adminUpsertAnnouncement", { enumerable: true, get: function () { return admin_1.adminUpsertAnnouncement; } });
Object.defineProperty(exports, "adminGetGuideline", { enumerable: true, get: function () { return admin_1.adminGetGuideline; } });
Object.defineProperty(exports, "adminUpdateGuideline", { enumerable: true, get: function () { return admin_1.adminUpdateGuideline; } });
var stripe_webhooks_1 = require("./stripe/stripe-webhooks");
Object.defineProperty(exports, "stripeWebhook", { enumerable: true, get: function () { return stripe_webhooks_1.stripeWebhook; } });
var stripe_connect_1 = require("./stripe/stripe-connect");
Object.defineProperty(exports, "createStripeConnectOnboardingLink", { enumerable: true, get: function () { return stripe_connect_1.createStripeConnectOnboardingLink; } });
Object.defineProperty(exports, "getStripeConnectStatus", { enumerable: true, get: function () { return stripe_connect_1.getStripeConnectStatus; } });
var app_public_1 = require("./mobile/app-public");
Object.defineProperty(exports, "getAppHomeData", { enumerable: true, get: function () { return app_public_1.getAppHomeData; } });
Object.defineProperty(exports, "getAppFeatureFlags", { enumerable: true, get: function () { return app_public_1.getAppFeatureFlags; } });
//# sourceMappingURL=index.js.map