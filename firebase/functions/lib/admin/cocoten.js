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
exports.adminUpsertJobBoardPost = exports.adminGetJobBoardPosts = exports.adminUpsertCocotenShop = exports.adminGetCocotenShops = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const adminPermissions_1 = require("../auth/adminPermissions");
const verifyAdmin_1 = require("../auth/verifyAdmin");
const db = () => admin.firestore();
exports.adminGetCocotenShops = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "cocoten");
    const prefectures = (0, adminPermissions_1.getManagedPrefectures)(adminUser);
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("cocoten_shops"), prefectures)
        .orderBy("created_at", "desc")
        .limit(prefectures ? 500 : offset + limit)
        .get()
        .catch(async () => (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("cocoten_shops"), prefectures)
        .limit(prefectures ? 500 : offset + limit)
        .get());
    let shops = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    shops = (0, adminPermissions_1.filterRowsByPrefecture)(shops, prefectures);
    const total = shops.length;
    const page = shops.slice(offset, offset + limit);
    return { shops: page, total, hasMore: offset + limit < total };
});
exports.adminUpsertCocotenShop = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "cocoten");
    const shopId = (_a = data === null || data === void 0 ? void 0 : data.shopId) !== null && _a !== void 0 ? _a : db().collection("cocoten_shops").doc().id;
    const payload = Object.assign(Object.assign({}, data === null || data === void 0 ? void 0 : data.payload), { updated_at: admin.firestore.FieldValue.serverTimestamp(), updated_by: adminUser.uid });
    if ((0, adminPermissions_1.isPrefectureAdmin)(adminUser)) {
        const prefecture = (0, adminPermissions_1.readPrefecture)(payload);
        if (prefecture) {
            (0, adminPermissions_1.assertPrefectureAccess)(adminUser, prefecture);
        }
    }
    const docRef = db().collection("cocoten_shops").doc(shopId);
    const existing = await docRef.get();
    if (!existing.exists) {
        payload.created_at =
            admin.firestore.FieldValue.serverTimestamp();
    }
    await docRef.set(payload, { merge: true });
    return { ok: true, shopId };
});
exports.adminGetJobBoardPosts = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "job_board");
    const prefectures = (0, adminPermissions_1.getManagedPrefectures)(adminUser);
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    const snap = await (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("job_board"), prefectures)
        .orderBy("created_at", "desc")
        .limit(prefectures ? 500 : offset + limit)
        .get()
        .catch(async () => (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("job_board"), prefectures)
        .limit(prefectures ? 500 : offset + limit)
        .get());
    let posts = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    posts = (0, adminPermissions_1.filterRowsByPrefecture)(posts, prefectures);
    const total = posts.length;
    const page = posts.slice(offset, offset + limit);
    return { posts: page, total, hasMore: offset + limit < total };
});
exports.adminUpsertJobBoardPost = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "job_board");
    const postId = (_a = data === null || data === void 0 ? void 0 : data.postId) !== null && _a !== void 0 ? _a : db().collection("job_board").doc().id;
    const payload = Object.assign(Object.assign({}, data === null || data === void 0 ? void 0 : data.payload), { updated_at: admin.firestore.FieldValue.serverTimestamp(), updated_by: adminUser.uid });
    if ((0, adminPermissions_1.isPrefectureAdmin)(adminUser)) {
        const prefecture = (0, adminPermissions_1.readPrefecture)(payload);
        if (prefecture) {
            (0, adminPermissions_1.assertPrefectureAccess)(adminUser, prefecture);
        }
    }
    const docRef = db().collection("job_board").doc(postId);
    const existing = await docRef.get();
    if (!existing.exists) {
        payload.created_at =
            admin.firestore.FieldValue.serverTimestamp();
    }
    await docRef.set(payload, { merge: true });
    return { ok: true, postId };
});
//# sourceMappingURL=cocoten.js.map