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
exports.adminForceDeleteUser = exports.adminToggleFreeze = exports.adminApproveKYC = exports.adminGetUsers = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const verifyAdmin_1 = require("../auth/verifyAdmin");
const db = () => admin.firestore();
function paginate(docs, limit = 50, offset = 0) {
    return docs.slice(offset, offset + limit).map((d) => (Object.assign({ id: d.id }, d.data())));
}
exports.adminGetUsers = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const role = data === null || data === void 0 ? void 0 : data.role;
    const kycStatus = data === null || data === void 0 ? void 0 : data.kycStatus;
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    let query = db().collection("users");
    if (role !== undefined) {
        query = query.where("role", "==", role);
    }
    if (kycStatus) {
        query = query.where("kyc_status", "==", kycStatus);
    }
    query = query.orderBy("created_time", "desc").limit(limit + offset);
    const snap = await query.get();
    return { users: paginate(snap.docs, limit, offset), total: snap.size };
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