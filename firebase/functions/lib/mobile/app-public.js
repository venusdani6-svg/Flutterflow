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
exports.getAppFeatureFlags = exports.getAppHomeData = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
const verifyAuth_1 = require("../auth/verifyAuth");
const db = () => admin.firestore();
/**
 * Mobile Home screen: active banners + announcements snippet.
 * Call on app launch / pull-to-refresh so admin banner changes appear on Home.
 */
exports.getAppHomeData = functions
    .region("asia-northeast1")
    .https.onCall(async (_data, context) => {
    var _a, _b;
    (0, verifyAuth_1.verifyAuth)(context);
    const [bannerSnap, configSnap, announcementSnap] = await Promise.all([
        db()
            .collection("banners")
            .where("active", "==", true)
            .orderBy("sort_order", "asc")
            .limit(20)
            .get()
            .catch(async () => db().collection("banners").limit(20).get()),
        db().collection("system_config").doc("default").get(),
        db()
            .collection("announcements")
            .where("published", "==", true)
            .orderBy("created_at", "desc")
            .limit(5)
            .get()
            .catch(async () => db()
            .collection("announcements")
            .where("active", "==", true)
            .limit(5)
            .get()),
    ]);
    const config = (_a = configSnap.data()) !== null && _a !== void 0 ? _a : {};
    const featuresEnabled = (_b = config.features_enabled) !== null && _b !== void 0 ? _b : {};
    return {
        banners: bannerSnap.docs.map((d) => (Object.assign({ id: d.id }, d.data()))),
        featuresEnabled,
        announcements: announcementSnap.docs.map((d) => (Object.assign({ id: d.id }, d.data()))),
        generatedAt: new Date().toISOString(),
    };
});
/**
 * Feature flags for mobile tab visibility (cocoten, staff, affiliate, etc.).
 * Re-fetch after admin saves system settings (features_enabled).
 */
exports.getAppFeatureFlags = functions
    .region("asia-northeast1")
    .https.onCall(async (_data, context) => {
    var _a, _b, _c, _d;
    (0, verifyAuth_1.verifyAuth)(context);
    const configSnap = await db().collection("system_config").doc("default").get();
    const config = (_a = configSnap.data()) !== null && _a !== void 0 ? _a : {};
    const featuresEnabled = (_b = config.features_enabled) !== null && _b !== void 0 ? _b : {};
    return {
        featuresEnabled: {
            cocoten: featuresEnabled.cocoten === true,
            staff: featuresEnabled.staff === true || featuresEnabled.staff_security === true,
            staff_shuttle: featuresEnabled.staff_shuttle === true,
            affiliate: featuresEnabled.affiliate === true,
        },
        settings: {
            chat_close_sec: (_d = (_c = config.settings) === null || _c === void 0 ? void 0 : _c.chat_close_sec) !== null && _d !== void 0 ? _d : null,
        },
        generatedAt: new Date().toISOString(),
    };
});
//# sourceMappingURL=app-public.js.map