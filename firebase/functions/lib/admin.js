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
exports.adminUpdateAdminAccess = exports.adminGetMyPermissions = exports.adminUpdateGuideline = exports.adminGetGuideline = exports.adminUpsertAnnouncement = exports.adminGetAnnouncements = exports.adminGetAuditLogs = exports.adminUpdateAffiliateRate = exports.adminGetAffiliateOverview = exports.adminResolveReport = exports.adminGetReports = exports.adminUpsertBanner = exports.adminGetBanners = exports.adminGetSystemConfig = exports.adminUpdateSystemConfig = exports.adminApprovePayout = exports.adminGetPayoutRequests = exports.adminGetStripeLogs = exports.adminGetLedger = exports.adminGetTipsByReservation = exports.adminForceCancel = exports.adminGetReservation = exports.adminGetReservations = exports.adminForceDeleteUser = exports.adminToggleFreeze = exports.adminApproveKYC = exports.adminGetUser = exports.adminGetUsers = exports.adminHealthCheck = exports.adminGetDashboardStats = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const adminPermissions_1 = require("./auth/adminPermissions");
const verifyAdmin_1 = require("./auth/verifyAdmin");
const db = () => admin.firestore();
function startOfTodayJst() {
    const now = new Date();
    const jstOffsetMs = 9 * 60 * 60 * 1000;
    const jst = new Date(now.getTime() + jstOffsetMs);
    jst.setUTCHours(0, 0, 0, 0);
    return new Date(jst.getTime() - jstOffsetMs);
}
async function countUsersByRole(role, prefectures) {
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("users").where("role", "==", role), prefectures)
        .count()
        .get();
    return snap.data().count;
}
async function countTodayRegistrations(prefectures) {
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db()
        .collection("users")
        .where("created_time", ">=", startOfTodayJst()), prefectures)
        .count()
        .get();
    return snap.data().count;
}
async function countPendingKyc(prefectures) {
    var _a;
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("users").where("kyc_status", "==", "pending"), prefectures)
        .count()
        .get()
        .catch(() => null);
    return (_a = snap === null || snap === void 0 ? void 0 : snap.data().count) !== null && _a !== void 0 ? _a : 0;
}
async function countTodayReservations(prefectures) {
    var _a;
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db()
        .collection("reservations")
        .where("created_at", ">=", startOfTodayJst()), prefectures)
        .count()
        .get()
        .catch(() => null);
    return (_a = snap === null || snap === void 0 ? void 0 : snap.data().count) !== null && _a !== void 0 ? _a : 0;
}
async function countPendingPayouts(prefectures) {
    var _a;
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("payout_requests").where("status", "==", "pending"), prefectures)
        .count()
        .get()
        .catch(() => null);
    return (_a = snap === null || snap === void 0 ? void 0 : snap.data().count) !== null && _a !== void 0 ? _a : 0;
}
async function countPendingReports(prefectures) {
    var _a;
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("reports").where("status", "in", ["pending", "open"]), prefectures)
        .count()
        .get()
        .catch(() => null);
    return (_a = snap === null || snap === void 0 ? void 0 : snap.data().count) !== null && _a !== void 0 ? _a : 0;
}
async function countAffiliates(prefectures) {
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("users").where("is_affiliate", "==", true), prefectures)
        .count()
        .get()
        .catch(() => null);
    if (snap) {
        return snap.data().count;
    }
    return countCollection("affiliate_stats");
}
async function countCocotenShops() {
    return countCollection("cocoten_shops");
}
async function countJobBoardPosts() {
    return countCollection("job_board");
}
async function getSalesToday(prefectures) {
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db()
        .collection("ledger")
        .where("type", "==", "payment")
        .where("created_at", ">=", startOfTodayJst()), prefectures)
        .get()
        .catch(() => null);
    if (!snap) {
        return 0;
    }
    return snap.docs.reduce((sum, doc) => { var _a; return sum + Number((_a = doc.data().amount) !== null && _a !== void 0 ? _a : 0); }, 0);
}
async function getRecentActivityLogs() {
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
        var _a, _b, _c, _d, _e, _f, _g, _h, _j;
        const data = doc.data();
        const createdAt = data.created_at;
        return {
            id: doc.id,
            action: (_a = data.action) !== null && _a !== void 0 ? _a : "",
            targetType: (_b = data.target_type) !== null && _b !== void 0 ? _b : "",
            targetId: (_c = data.target_id) !== null && _c !== void 0 ? _c : "",
            targetUserName: (_e = (_d = data.target_user_name) !== null && _d !== void 0 ? _d : data.target_id) !== null && _e !== void 0 ? _e : "-",
            actorUid: (_f = data.actor_uid) !== null && _f !== void 0 ? _f : "",
            createdAt: (_j = (_h = (_g = createdAt === null || createdAt === void 0 ? void 0 : createdAt.toDate) === null || _g === void 0 ? void 0 : _g.call(createdAt)) === null || _h === void 0 ? void 0 : _h.toISOString()) !== null && _j !== void 0 ? _j : null,
        };
    });
}
async function countCollection(name) {
    var _a;
    const snap = await db().collection(name).count().get().catch(() => null);
    return (_a = snap === null || snap === void 0 ? void 0 : snap.data().count) !== null && _a !== void 0 ? _a : 0;
}
async function getMonthlySales() {
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
        var _a, _b, _c;
        const data = doc.data();
        return {
            month: String((_a = data.month) !== null && _a !== void 0 ? _a : doc.id),
            amount: Number((_c = (_b = data.amount) !== null && _b !== void 0 ? _b : data.total) !== null && _c !== void 0 ? _c : 0),
        };
    });
}
/**
 * Dashboard KPI and chart data for the admin home screen.
 */
exports.adminGetDashboardStats = functions
    .region("asia-northeast1")
    .https.onCall(async (_data, context) => {
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "dashboard");
    const prefectures = (0, adminPermissions_1.getManagedPrefectures)(adminUser);
    const [todayNewRegistrations, guestCount, castCount, staffCount, pendingKyc, todayReservations, salesToday, pendingPayouts, pendingReports, affiliateCount, cocotenShopCount, jobBoardPostCount, monthlySales, recentActivityLogs,] = await Promise.all([
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
        managedPrefectures: prefectures !== null && prefectures !== void 0 ? prefectures : [],
        generatedAt: new Date().toISOString(),
    };
});
/**
 * Health-check callable for deployment verification.
 */
exports.adminHealthCheck = functions
    .region("asia-northeast1")
    .https.onCall(async (_data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    return {
        ok: true,
        uid: adminUser.uid,
        email: (_a = adminUser.email) !== null && _a !== void 0 ? _a : null,
    };
});
var users_1 = require("./admin/users");
Object.defineProperty(exports, "adminGetUsers", { enumerable: true, get: function () { return users_1.adminGetUsers; } });
Object.defineProperty(exports, "adminGetUser", { enumerable: true, get: function () { return users_1.adminGetUser; } });
Object.defineProperty(exports, "adminApproveKYC", { enumerable: true, get: function () { return users_1.adminApproveKYC; } });
Object.defineProperty(exports, "adminToggleFreeze", { enumerable: true, get: function () { return users_1.adminToggleFreeze; } });
Object.defineProperty(exports, "adminForceDeleteUser", { enumerable: true, get: function () { return users_1.adminForceDeleteUser; } });
var reservations_1 = require("./admin/reservations");
Object.defineProperty(exports, "adminGetReservations", { enumerable: true, get: function () { return reservations_1.adminGetReservations; } });
Object.defineProperty(exports, "adminGetReservation", { enumerable: true, get: function () { return reservations_1.adminGetReservation; } });
Object.defineProperty(exports, "adminForceCancel", { enumerable: true, get: function () { return reservations_1.adminForceCancel; } });
Object.defineProperty(exports, "adminGetTipsByReservation", { enumerable: true, get: function () { return reservations_1.adminGetTipsByReservation; } });
var payments_1 = require("./admin/payments");
Object.defineProperty(exports, "adminGetLedger", { enumerable: true, get: function () { return payments_1.adminGetLedger; } });
Object.defineProperty(exports, "adminGetStripeLogs", { enumerable: true, get: function () { return payments_1.adminGetStripeLogs; } });
Object.defineProperty(exports, "adminGetPayoutRequests", { enumerable: true, get: function () { return payments_1.adminGetPayoutRequests; } });
Object.defineProperty(exports, "adminApprovePayout", { enumerable: true, get: function () { return payments_1.adminApprovePayout; } });
var content_1 = require("./admin/content");
Object.defineProperty(exports, "adminUpdateSystemConfig", { enumerable: true, get: function () { return content_1.adminUpdateSystemConfig; } });
Object.defineProperty(exports, "adminGetSystemConfig", { enumerable: true, get: function () { return content_1.adminGetSystemConfig; } });
Object.defineProperty(exports, "adminGetBanners", { enumerable: true, get: function () { return content_1.adminGetBanners; } });
Object.defineProperty(exports, "adminUpsertBanner", { enumerable: true, get: function () { return content_1.adminUpsertBanner; } });
Object.defineProperty(exports, "adminGetReports", { enumerable: true, get: function () { return content_1.adminGetReports; } });
Object.defineProperty(exports, "adminResolveReport", { enumerable: true, get: function () { return content_1.adminResolveReport; } });
Object.defineProperty(exports, "adminGetAffiliateOverview", { enumerable: true, get: function () { return content_1.adminGetAffiliateOverview; } });
Object.defineProperty(exports, "adminUpdateAffiliateRate", { enumerable: true, get: function () { return content_1.adminUpdateAffiliateRate; } });
Object.defineProperty(exports, "adminGetAuditLogs", { enumerable: true, get: function () { return content_1.adminGetAuditLogs; } });
Object.defineProperty(exports, "adminGetAnnouncements", { enumerable: true, get: function () { return content_1.adminGetAnnouncements; } });
Object.defineProperty(exports, "adminUpsertAnnouncement", { enumerable: true, get: function () { return content_1.adminUpsertAnnouncement; } });
Object.defineProperty(exports, "adminGetGuideline", { enumerable: true, get: function () { return content_1.adminGetGuideline; } });
Object.defineProperty(exports, "adminUpdateGuideline", { enumerable: true, get: function () { return content_1.adminUpdateGuideline; } });
var permissions_1 = require("./admin/permissions");
Object.defineProperty(exports, "adminGetMyPermissions", { enumerable: true, get: function () { return permissions_1.adminGetMyPermissions; } });
Object.defineProperty(exports, "adminUpdateAdminAccess", { enumerable: true, get: function () { return permissions_1.adminUpdateAdminAccess; } });
//# sourceMappingURL=admin.js.map