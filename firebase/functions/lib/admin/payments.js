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
const adminPermissions_1 = require("../auth/adminPermissions");
const verifyAdmin_1 = require("../auth/verifyAdmin");
const audit_1 = require("./audit");
const db = () => admin.firestore();
async function filterPayoutsByPrefecture(payouts, prefectures) {
    var _a, _b;
    if (prefectures === null) {
        return payouts;
    }
    const filtered = [];
    for (const payout of payouts) {
        const userId = String((_a = payout.user_id) !== null && _a !== void 0 ? _a : "");
        if (!userId) {
            continue;
        }
        const userSnap = await db().collection("users").doc(userId).get();
        const prefecture = (0, adminPermissions_1.readPrefecture)((_b = userSnap.data()) !== null && _b !== void 0 ? _b : {});
        if (prefectures.includes(prefecture)) {
            filtered.push(payout);
        }
    }
    return filtered;
}
async function filterLedgerByPrefecture(entries, prefectures) {
    var _a, _b, _c, _d;
    if (prefectures === null) {
        return entries;
    }
    const filtered = [];
    for (const entry of entries) {
        const direct = (0, adminPermissions_1.readPrefecture)(entry);
        if (direct && prefectures.includes(direct)) {
            filtered.push(entry);
            continue;
        }
        const reservationId = String((_a = entry.reservation_id) !== null && _a !== void 0 ? _a : "");
        if (reservationId) {
            const reservation = await db()
                .collection("reservations")
                .doc(reservationId)
                .get();
            const prefecture = (0, adminPermissions_1.readPrefecture)((_b = reservation.data()) !== null && _b !== void 0 ? _b : {});
            if (prefectures.includes(prefecture)) {
                filtered.push(entry);
            }
            continue;
        }
        const userId = String((_c = entry.user_id) !== null && _c !== void 0 ? _c : "");
        if (userId) {
            const userSnap = await db().collection("users").doc(userId).get();
            const prefecture = (0, adminPermissions_1.readPrefecture)((_d = userSnap.data()) !== null && _d !== void 0 ? _d : {});
            if (prefectures.includes(prefecture)) {
                filtered.push(entry);
            }
        }
    }
    return filtered;
}
exports.adminGetLedger = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "payment_ledger");
    const prefectures = (0, adminPermissions_1.getManagedPrefectures)(adminUser);
    const type = data === null || data === void 0 ? void 0 : data.type;
    const reservationId = data === null || data === void 0 ? void 0 : data.reservationId;
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    let baseQuery = (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("ledger"), prefectures);
    if (type) {
        baseQuery = baseQuery.where("type", "==", type);
    }
    if (reservationId) {
        baseQuery = baseQuery.where("reservation_id", "==", reservationId);
    }
    const snap = await baseQuery
        .orderBy("created_at", "desc")
        .limit(prefectures ? 500 : offset + limit)
        .get();
    let entries = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    entries = (0, adminPermissions_1.filterRowsByPrefecture)(entries, prefectures);
    if (prefectures) {
        entries = await filterLedgerByPrefecture(entries, prefectures);
    }
    const total = entries.length;
    const page = entries.slice(offset, offset + limit);
    return { entries: page, total, hasMore: offset + limit < total };
});
exports.adminGetStripeLogs = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b, _c, _d;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "payment_ledger");
    const prefectures = (0, adminPermissions_1.getManagedPrefectures)(adminUser);
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
    const fetchLimit = startDate || endDate || prefectures ? 500 : offset + limit;
    const snap = await baseQuery
        .orderBy("created_at", "desc")
        .limit(fetchLimit)
        .get();
    let logs = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    if (prefectures) {
        const filtered = [];
        for (const log of logs) {
            const reservationIdValue = String((_c = log.reservation_id) !== null && _c !== void 0 ? _c : "");
            if (!reservationIdValue) {
                continue;
            }
            const reservation = await db()
                .collection("reservations")
                .doc(reservationIdValue)
                .get();
            const prefecture = (0, adminPermissions_1.readPrefecture)((_d = reservation.data()) !== null && _d !== void 0 ? _d : {});
            if (prefectures.includes(prefecture)) {
                filtered.push(log);
            }
        }
        logs = filtered;
    }
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
    }
    const total = logs.length;
    const page = logs.slice(offset, offset + limit);
    return { logs: page, total, hasMore: offset + limit < total };
});
exports.adminGetPayoutRequests = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "withdrawal");
    const prefectures = (0, adminPermissions_1.getManagedPrefectures)(adminUser);
    const status = data === null || data === void 0 ? void 0 : data.status;
    const limit = Math.min(Number((_a = data === null || data === void 0 ? void 0 : data.limit) !== null && _a !== void 0 ? _a : 50), 100);
    const offset = Number((_b = data === null || data === void 0 ? void 0 : data.offset) !== null && _b !== void 0 ? _b : 0);
    let baseQuery = (0, adminPermissions_1.applyPrefectureQueryFilter)(db().collection("payout_requests"), prefectures);
    if (status) {
        baseQuery = baseQuery.where("status", "==", status);
    }
    const snap = await baseQuery
        .orderBy("created_at", "desc")
        .limit(prefectures ? 500 : offset + limit)
        .get();
    let payouts = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    payouts = (0, adminPermissions_1.filterRowsByPrefecture)(payouts, prefectures);
    if (prefectures) {
        payouts = await filterPayoutsByPrefecture(payouts, prefectures);
    }
    const total = payouts.length;
    const page = payouts.slice(offset, offset + limit);
    return { payouts: page, total, hasMore: offset + limit < total };
});
exports.adminApprovePayout = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b, _c, _d;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requirePermission)(adminUser, "withdrawal");
    const payoutId = data === null || data === void 0 ? void 0 : data.payoutId;
    const status = (_a = data === null || data === void 0 ? void 0 : data.status) !== null && _a !== void 0 ? _a : "approved";
    const allowed = ["approved", "on_hold", "rejected", "pending"];
    if (!payoutId || !allowed.includes(status)) {
        throw new functions.https.HttpsError("invalid-argument", "payoutId and valid status are required.");
    }
    const payoutDoc = await db().collection("payout_requests").doc(payoutId).get();
    if (!payoutDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Payout not found.");
    }
    const payoutData = (_b = payoutDoc.data()) !== null && _b !== void 0 ? _b : {};
    const directPrefecture = (0, adminPermissions_1.readPrefecture)(payoutData);
    if (directPrefecture) {
        (0, adminPermissions_1.assertPrefectureAccess)(adminUser, directPrefecture);
    }
    else {
        const userId = String((_c = payoutData.user_id) !== null && _c !== void 0 ? _c : "");
        const userSnap = userId
            ? await db().collection("users").doc(userId).get()
            : null;
        (0, adminPermissions_1.assertPrefectureAccess)(adminUser, (0, adminPermissions_1.readPrefecture)((_d = userSnap === null || userSnap === void 0 ? void 0 : userSnap.data()) !== null && _d !== void 0 ? _d : {}));
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