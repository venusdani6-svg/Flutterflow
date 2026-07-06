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
exports.adminGetTipsByReservation = exports.adminForceCancel = exports.adminGetReservation = exports.adminGetReservations = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const verifyAdmin_1 = require("../auth/verifyAdmin");
const audit_1 = require("./audit");
const db = () => admin.firestore();
exports.adminGetReservations = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b, _c;
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const status = data === null || data === void 0 ? void 0 : data.status;
    const search = ((_a = data === null || data === void 0 ? void 0 : data.search) !== null && _a !== void 0 ? _a : "").trim().toLowerCase();
    const limit = Math.min(Number((_b = data === null || data === void 0 ? void 0 : data.limit) !== null && _b !== void 0 ? _b : 50), 100);
    const offset = Number((_c = data === null || data === void 0 ? void 0 : data.offset) !== null && _c !== void 0 ? _c : 0);
    if (search) {
        let query = db()
            .collection("reservations")
            .orderBy("created_at", "desc");
        if (status) {
            query = query.where("status", "==", status);
        }
        query = query.limit(500);
        const snap = await query.get();
        let reservations = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
        reservations = reservations.filter((r) => {
            var _a, _b, _c;
            const id = String((_a = r.id) !== null && _a !== void 0 ? _a : "").toLowerCase();
            const guest = String((_b = r.guest_id) !== null && _b !== void 0 ? _b : "").toLowerCase();
            const cast = String((_c = r.cast_id) !== null && _c !== void 0 ? _c : "").toLowerCase();
            return (id.includes(search) || guest.includes(search) || cast.includes(search));
        });
        const total = reservations.length;
        const page = reservations.slice(offset, offset + limit);
        return { reservations: page, total, hasMore: offset + limit < total };
    }
    let baseQuery = db().collection("reservations");
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
    const reservations = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    return { reservations, total, hasMore: offset + limit < total };
});
exports.adminGetReservation = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const reservationId = data === null || data === void 0 ? void 0 : data.reservationId;
    if (!reservationId) {
        throw new functions.https.HttpsError("invalid-argument", "reservationId is required.");
    }
    const doc = await db().collection("reservations").doc(reservationId).get();
    if (!doc.exists) {
        throw new functions.https.HttpsError("not-found", "Reservation not found.");
    }
    return Object.assign({ id: doc.id }, doc.data());
});
exports.adminForceCancel = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    const reservationId = data === null || data === void 0 ? void 0 : data.reservationId;
    const reason = (_a = data === null || data === void 0 ? void 0 : data.reason) !== null && _a !== void 0 ? _a : "admin_force_cancel";
    if (!reservationId) {
        throw new functions.https.HttpsError("invalid-argument", "reservationId is required.");
    }
    await db().collection("reservations").doc(reservationId).update({
        status: "cancelled",
        cancelled_by: "admin",
        cancel_reason: reason,
        cancelled_at: admin.firestore.FieldValue.serverTimestamp(),
        cancelled_by_uid: adminUser.uid,
    });
    await (0, audit_1.writeAuditLog)({
        actorUid: adminUser.uid,
        action: "reservation_force_cancelled",
        targetType: "reservation",
        targetId: reservationId,
        metadata: { reason },
    });
    return { ok: true, reservationId };
});
exports.adminGetTipsByReservation = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    await (0, verifyAdmin_1.verifyAdmin)(context);
    const reservationId = data === null || data === void 0 ? void 0 : data.reservationId;
    if (!reservationId) {
        throw new functions.https.HttpsError("invalid-argument", "reservationId is required.");
    }
    const snap = await db()
        .collection("ledger")
        .where("reservation_id", "==", reservationId)
        .where("type", "==", "tip")
        .get();
    const tips = snap.docs.map((d) => (Object.assign({ id: d.id }, d.data())));
    const total = tips.reduce((sum, t) => { var _a; return sum + Number((_a = t.amount) !== null && _a !== void 0 ? _a : 0); }, 0);
    return { tips, total, hasTips: tips.length > 0 };
});
//# sourceMappingURL=reservations.js.map