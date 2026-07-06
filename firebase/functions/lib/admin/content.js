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
exports.adminUpdateGuideline = exports.adminGetGuideline = exports.adminUpsertAnnouncement = exports.adminGetAnnouncements = exports.adminGetAuditLogs = exports.adminUpdateAffiliateRate = exports.adminGetAffiliateOverview = exports.adminResolveReport = exports.adminGetReports = exports.adminUpsertBanner = exports.adminGetBanners = exports.adminGetSystemConfig = exports.adminUpdateSystemConfig = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const adminPermissions_1 = require("../auth/adminPermissions");
const verifyAdmin_1 = require("../auth/verifyAdmin");
const db = () => admin.firestore();
exports.adminUpdateSystemConfig = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "system_settings");
    const section = (_a = data === null || data === void 0 ? void 0 : data.section) !== null && _a !== void 0 ? _a : "settings";
    const payload = (_b = data === null || data === void 0 ? void 0 : data.payload) !== null && _b !== void 0 ? _b : {};
    const docRef = db().collection("system_config").doc("default");
    await docRef.set({
        [section]: payload,
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
        updated_by: adminUser.uid,
    }, { merge: true });
    return { ok: true, section };
});
exports.adminGetSystemConfig = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "system_settings");
    const snap = await db().collection("system_config").doc("default").get();
    return snap.exists ? snap.data() : {};
});
exports.adminGetBanners = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "banners");
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const snap = await db()
        .collection("banners")
        .orderBy("sort_order", "asc")
        .limit(limit)
        .get()
        .catch(async () => db().collection("banners").limit(limit).get());
    const banners = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    return { banners, total: banners.length };
});
exports.adminUpsertBanner = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "banners");
    const bannerId = (_a = data === null || data === void 0 ? void 0 : data.bannerId) !== null && _a !== void 0 ? _a : db().collection("banners").doc().id;
    const payload = Object.assign(Object.assign({}, data === null || data === void 0 ? void 0 : data.payload), { updated_at: admin.firestore.FieldValue.serverTimestamp(), updated_by: adminUser.uid });
    await db().collection("banners").doc(bannerId).set(payload, { merge: true });
    return { ok: true, bannerId };
});
exports.adminGetReports = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "reports");
    const prefectures = (0, adminPermissions_1.getManagedPrefectures)(adminUser);
    const status = data === null || data === void 0 ? void 0 : data.status;
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    let baseQuery = (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("reports"), prefectures);
    if (status) {
        baseQuery = baseQuery.where("status", "==", status);
    }
    const snap = await baseQuery
        .orderBy("created_at", "desc")
        .limit(prefectures ? 500 : offset + limit)
        .get();
    let reports = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    reports = (0, adminPermissions_1.filterRowsByPrefecture)(reports, prefectures);
    const total = reports.length;
    const page = reports.slice(offset, offset + limit);
    return { reports: page, total, hasMore: offset + limit < total };
});
exports.adminResolveReport = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "reports");
    const reportId = data === null || data === void 0 ? void 0 : data.reportId;
    const resolution = (_a = data === null || data === void 0 ? void 0 : data.resolution) !== null && _a !== void 0 ? _a : "resolved";
    if (!reportId) {
        throw new functions.https.HttpsError("invalid-argument", "reportId is required.");
    }
    const reportDoc = await db().collection("reports").doc(reportId).get();
    (0, adminPermissions_1.assertPrefectureAccess)(adminUser, (0, adminPermissions_1.readPrefecture)((_b = reportDoc.data()) !== null && _b !== void 0 ? _b : {}));
    await db().collection("reports").doc(reportId).update({
        status: resolution,
        resolved_at: admin.firestore.FieldValue.serverTimestamp(),
        resolved_by: adminUser.uid,
    });
    return { ok: true, reportId, status: resolution };
});
exports.adminGetAffiliateOverview = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "affiliate");
    const prefectures = (0, adminPermissions_1.getManagedPrefectures)(adminUser);
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 100), 200);
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("users").where("is_affiliate", "==", true), prefectures)
        .limit(limit)
        .get()
        .catch(async () => db().collection("affiliate_stats").limit(limit).get());
    let affiliates = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    affiliates = (0, adminPermissions_1.filterRowsByPrefecture)(affiliates, prefectures);
    const monthlySnap = await db()
        .collection("affiliate_monthly_rewards")
        .orderBy("month", "desc")
        .limit(12)
        .get()
        .catch(() => null);
    const monthlyRewards = (_b = monthlySnap === null || monthlySnap === void 0 ? void 0 : monthlySnap.docs.map((d) => (Object.assign({ id: d.id }, d.data())))) !== null && _b !== void 0 ? _b : [];
    return { affiliates, total: affiliates.length, monthlyRewards };
});
exports.adminUpdateAffiliateRate = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "affiliate");
    const userId = data === null || data === void 0 ? void 0 : data.userId;
    const rate = Number(data === null || data === void 0 ? void 0 : data.rate);
    if (!userId || Number.isNaN(rate)) {
        throw new functions.https.HttpsError("invalid-argument", "userId and rate are required.");
    }
    const userDoc = await db().collection("users").doc(userId).get();
    (0, adminPermissions_1.assertPrefectureAccess)(adminUser, (0, adminPermissions_1.readPrefecture)((_a = userDoc.data()) !== null && _a !== void 0 ? _a : {}));
    await db().collection("users").doc(userId).update({ affiliate_rate: rate });
    return { ok: true, userId, rate };
});
exports.adminGetAuditLogs = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b, _c;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "audit_logs");
    const targetType = data === null || data === void 0 ? void 0 : data.targetType;
    const targetId = data === null || data === void 0 ? void 0 : data.targetId;
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    let query = db().collection("audit_logs");
    if (targetType) {
        query = query.where("target_type", "==", targetType);
    }
    if (targetId) {
        query = query.where("target_id", "==", targetId);
    }
    const countSnap = await query.count().get().catch(() => null);
    const snap = await query
        .orderBy("created_at", "desc")
        .offset(offset)
        .limit(limit)
        .get()
        .catch(async () => db()
        .collection("audit_logs")
        .orderBy("created_at", "desc")
        .offset(offset)
        .limit(limit)
        .get());
    const logs = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    const total = (_c = countSnap === null || countSnap === void 0 ? void 0 : countSnap.data().count) !== null && _c !== void 0 ? _c : logs.length;
    return { logs, total, hasMore: offset + limit < total };
});
exports.adminGetAnnouncements = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "system_settings");
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const snap = await db()
        .collection("announcements")
        .orderBy("created_at", "desc")
        .limit(limit)
        .get()
        .catch(async () => db().collection("announcements").limit(limit).get());
    const announcements = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    return { announcements, total: announcements.length };
});
exports.adminUpsertAnnouncement = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "system_settings");
    const announcementId = (_a = data === null || data === void 0 ? void 0 : data.announcementId) !== null && _a !== void 0 ? _a : db().collection("announcements").doc().id;
    const payload = Object.assign(Object.assign({}, data === null || data === void 0 ? void 0 : data.payload), { updated_at: admin.firestore.FieldValue.serverTimestamp(), updated_by: adminUser.uid });
    const docRef = db().collection("announcements").doc(announcementId);
    const existing = await docRef.get();
    if (!existing.exists) {
        payload.created_at =
            admin.firestore.FieldValue.serverTimestamp();
    }
    await docRef.set(payload, { merge: true });
    return { ok: true, announcementId };
});
exports.adminGetGuideline = functions
    .region("asia-northeast1")
    .https.onCall(async (_data, context) => {
    var _a, _b, _c, _d;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "system_settings");
    const snap = await db().collection("system_config").doc("default").get();
    const data = (_a = snap.data()) !== null && _a !== void 0 ? _a : {};
    return {
        content: (_c = (_b = data.guideline) !== null && _b !== void 0 ? _b : data.guidelines) !== null && _c !== void 0 ? _c : "",
        updated_at: (_d = data.guideline_updated_at) !== null && _d !== void 0 ? _d : null,
    };
});
exports.adminUpdateGuideline = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "system_settings");
    const content = (_a = data === null || data === void 0 ? void 0 : data.content) !== null && _a !== void 0 ? _a : "";
    await db()
        .collection("system_config")
        .doc("default")
        .set({
        guideline: content,
        guideline_updated_at: admin.firestore.FieldValue.serverTimestamp(),
        guideline_updated_by: adminUser.uid,
    }, { merge: true });
    return { ok: true };
});
//# sourceMappingURL=content.js.map