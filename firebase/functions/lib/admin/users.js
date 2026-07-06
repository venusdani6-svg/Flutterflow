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
exports.adminForceDeleteUser = exports.adminToggleFreeze = exports.adminApproveKYC = exports.adminGetUser = exports.adminGetUsers = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const verifyAdmin_1 = require("../auth/verifyAdmin");
const db = () => admin.firestore();
exports.adminGetUsers = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b, _c, _d, _e;
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const role = data === null || data === void 0 ? void 0 : data.role;
    const roleAdmin = data === null || data === void 0 ? void 0 : data.roleAdmin;
    const kycStatus = data === null || data === void 0 ? void 0 : data.kycStatus;
    const search = ((_a = data === null || data === void 0 ? void 0 : data.search) !== null && _a !== void 0 ? _a : "").trim().toLowerCase();
    const orderBy = (_b = data === null || data === void 0 ? void 0 : data.orderBy) !== null && _b !== void 0 ? _b : "created_time";
    const orderDirection = (_c = data === null || data === void 0 ? void 0 : data.orderDirection) !== null && _c !== void 0 ? _c : "desc";
    const isFrozen = data === null || data === void 0 ? void 0 : data.isFrozen;
    const limit = Math.min(Number((_d = data === null || data === void 0 ? void 0 : data.limit) !== null && _d !== void 0 ? _d : 50), 100);
    const offset = Number((_e = data === null || data === void 0 ? void 0 : data.offset) !== null && _e !== void 0 ? _e : 0);
    let query = db().collection("users");
    if (role !== undefined) {
        query = query.where("role", "==", role);
    }
    if (roleAdmin) {
        query = query.where("role_admin", "==", roleAdmin);
    }
    if (kycStatus) {
        query = query.where("kyc_status", "==", kycStatus);
    }
    if (isFrozen !== undefined) {
        query = query.where("is_frozen", "==", isFrozen);
    }
    const orderField = ["created_time", "email", "display_name"].includes(orderBy)
        ? orderBy
        : "created_time";
    query = query.orderBy(orderField, orderDirection === "asc" ? "asc" : "desc");
    const fetchLimit = search ? 500 : limit + offset;
    query = query.limit(fetchLimit);
    const snap = await query.get();
    let users = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    if (search) {
        users = users.filter((u) => {
            var _a, _b;
            const email = String((_a = u.email) !== null && _a !== void 0 ? _a : "").toLowerCase();
            const name = String((_b = u.display_name) !== null && _b !== void 0 ? _b : "").toLowerCase();
            return email.includes(search) || name.includes(search);
        });
    }
    const total = users.length;
    const page = users.slice(offset, offset + limit);
    return {
        users: page,
        total,
        hasMore: offset + limit < total,
    };
});
exports.adminGetUser = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const userId = data === null || data === void 0 ? void 0 : data.userId;
    if (!userId) {
        throw new functions.https.HttpsError("invalid-argument", "userId is required.");
    }
    const doc = await db().collection("users").doc(userId).get();
    if (!doc.exists) {
        throw new functions.https.HttpsError("not-found", "User not found.");
    }
    return Object.assign({ id: doc.id }, doc.data());
});
exports.adminApproveKYC = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    const userId = data === null || data === void 0 ? void 0 : data.userId;
    const approved = Boolean((_a = data === null || data === void 0 ? void 0 : data.approved) !== null && _a !== void 0 ? _a : true);
    if (!userId) {
        throw new functions.https.HttpsError("invalid-argument", "userId is required.");
    }
    await db()
        .collection("users")
        .doc(userId)
        .update({
        kyc_status: approved ? "approved" : "rejected",
        kyc_reviewed_at: admin.firestore.FieldValue.serverTimestamp(),
        kyc_reviewed_by: adminUser.uid,
    });
    return { ok: true, userId, kyc_status: approved ? "approved" : "rejected" };
});
exports.adminToggleFreeze = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const userId = data === null || data === void 0 ? void 0 : data.userId;
    const frozen = Boolean(data === null || data === void 0 ? void 0 : data.frozen);
    if (!userId) {
        throw new functions.https.HttpsError("invalid-argument", "userId is required.");
    }
    await db()
        .collection("users")
        .doc(userId)
        .update({ is_frozen: frozen, is_active: !frozen });
    return { ok: true, userId, frozen };
});
exports.adminForceDeleteUser = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const userId = data === null || data === void 0 ? void 0 : data.userId;
    if (!userId) {
        throw new functions.https.HttpsError("invalid-argument", "userId is required.");
    }
    await admin.auth().deleteUser(userId);
    await db().collection("users").doc(userId).delete();
    return { ok: true, userId };
});
//# sourceMappingURL=users.js.map