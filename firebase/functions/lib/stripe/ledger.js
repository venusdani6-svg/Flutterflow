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
exports.writeLedgerEntry = writeLedgerEntry;
exports.writeStripeLog = writeStripeLog;
const admin = __importStar(require("firebase-admin"));
const db = () => admin.firestore();
async function writeLedgerEntry(entry) {
    var _a, _b, _c, _d, _e;
    const ref = await db().collection("ledger").add({
        type: entry.type,
        amount: entry.amount,
        reservation_id: (_a = entry.reservationId) !== null && _a !== void 0 ? _a : null,
        user_id: (_b = entry.userId) !== null && _b !== void 0 ? _b : null,
        description: (_c = entry.description) !== null && _c !== void 0 ? _c : "",
        stripe_payment_intent_id: (_d = entry.stripePaymentIntentId) !== null && _d !== void 0 ? _d : null,
        stripe_charge_id: (_e = entry.stripeChargeId) !== null && _e !== void 0 ? _e : null,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
    });
    return ref.id;
}
async function writeStripeLog(params) {
    var _a;
    const existing = await db()
        .collection("stripe_logs")
        .where("stripe_event_id", "==", params.eventId)
        .limit(1)
        .get();
    if (!existing.empty) {
        return false;
    }
    await db().collection("stripe_logs").add({
        stripe_event_id: params.eventId,
        event_type: params.eventType,
        reservation_id: (_a = params.reservationId) !== null && _a !== void 0 ? _a : null,
        payload: params.payload,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
    });
    return true;
}
//# sourceMappingURL=ledger.js.map