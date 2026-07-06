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
exports.adminApprovePayout = exports.adminGetPayoutRequests = exports.adminGetStripeLogs = exports.adminGetLedger = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const verifyAdmin_1 = require("../auth/verifyAdmin");
const audit_1 = require("./audit");
const db = () => admin.firestore();
exports.adminGetLedger = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const type = data === null || data === void 0 ? void 0 : data.type;
    const reservationId = data === null || data === void 0 ? void 0 : data.reservationId;
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    let baseQuery = db().collection("ledger");
    if (type) {
        baseQuery = baseQuery.where("type", "==", type);
    }
    if (reservationId) {
        baseQuery = baseQuery.where("reservation_id", "==", reservationId);
    }
    const countSnap = await baseQuery.count().get();
    const total = countSnap.data().count;
    const snap = await baseQuery
        .orderBy("created_at", "desc")
        .offset(offset)
        .limit(limit)
        .get();
    const entries = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    return { entries, total, hasMore: offset + limit < total };
});
exports.adminGetStripeLogs = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const eventType = data === null || data === void 0 ? void 0 : data.eventType;
    const reservationId = data === null || data === void 0 ? void 0 : data.reservationId;
    const startDate = data === null || data === void 0 ? void 0 : data.startDate;
    const endDate = data === null || data === void 0 ? void 0 : data.endDate;
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    let baseQuery = db().collection("stripe_logs");
    if (eventType) {
        baseQuery = baseQuery.where("event_type", "==", eventType);
    }
    if (reservationId) {
        baseQuery = baseQuery.where("reservation_id", "==", reservationId);
    }
    const fetchLimit = startDate || endDate ? 500 : offset + limit;
    const snap = await baseQuery
        .orderBy("created_at", "desc")
        .limit(fetchLimit)
        .get();
    let logs = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    if (startDate || endDate) {
        const start = startDate ? new Date(startDate).getTime() : 0;
        const end = endDate ? new Date(endDate).getTime() : Date.now();
        logs = logs.filter((log) => {
            var _a, _b, _c;
            const created = log
                .created_at;
            const ts = (_c = (_b = (_a = created === null || created === void 0 ? void 0 : created.toDate) === null || _a === void 0 ? void 0 : _a.call(created)) === null || _b === void 0 ? void 0 : _b.getTime()) !== null && _c !== void 0 ? _c : 0;
            return ts >= start && ts <= end;
        });
        const total = logs.length;
        const page = logs.slice(offset, offset + limit);
        return { logs: page, total, hasMore: offset + limit < total };
    }
    const countSnap = await baseQuery.count().get();
    const total = countSnap.data().count;
    const pageSnap = await baseQuery
        .orderBy("created_at", "desc")
        .offset(offset)
        .limit(limit)
        .get();
    logs = pageSnap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    return { logs, total, hasMore: offset + limit < total };
});
exports.adminGetPayoutRequests = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const status = data === null || data === void 0 ? void 0 : data.status;
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    let baseQuery = db().collection("payout_requests");
    if (status) {
        baseQuery = baseQuery.where("status", "==", status);
    }
    const countSnap = await baseQuery.count().get();
    const total = countSnap.data().count;
    const snap = await baseQuery
        .orderBy("created_at", "desc")
        .offset(offset)
        .limit(limit)
        .get();
    const payouts = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    return { payouts, total, hasMore: offset + limit < total };
});
exports.adminApprovePayout = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    const payoutId = data === null || data === void 0 ? void 0 : data.payoutId;
    const status = (_a = data === null || data === void 0 ? void 0 : data.status) !== null && _a !== void 0 ? _a : "approved";
    const allowed = ["approved", "on_hold", "rejected", "pending"];
    if (!payoutId || !allowed.includes(status)) {
        throw new functions.https.HttpsError("invalid-argument", "payoutId and valid status are required.");
    }
    await db()
        .collection("payout_requests")
        .doc(payoutId)
        .update({
        status,
        reviewed_at: admin.firestore.FieldValue.serverTimestamp(),
        reviewed_by: adminUser.uid,
    });
    await (0, audit_1.writeAuditLog)({
        actorUid: adminUser.uid,
        action: `payout_${status}`,
        targetType: "payout",
        targetId: payoutId,
    });
    return { ok: true, payoutId, status };
});
//# sourceMappingURL=payments.js.map