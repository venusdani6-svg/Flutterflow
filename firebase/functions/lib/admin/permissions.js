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
exports.adminUpdateAdminAccess = exports.adminGetMyPermissions = void 0;
const admin = __importStar(require("firebase-admin"));
const functions = __importStar(require("firebase-functions"));
const adminPermissions_1 = require("../auth/adminPermissions");
const verifyAdmin_1 = require("../auth/verifyAdmin");
const db = () => admin.firestore();
/** Returns effective permissions for the signed-in admin (menu + client guards). */
exports.adminGetMyPermissions = functions
    .region("asia-northeast1")
    .https.onCall(async (_data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    return {
        isSuperAdmin: !adminUser.adminRole || adminUser.adminRole === "super_admin",
        adminRole: (_a = adminUser.adminRole) !== null && _a !== void 0 ? _a : "super_admin",
        permissions: (0, adminPermissions_1.buildEffectivePermissions)(adminUser),
        permissionKeys: [...adminPermissions_1.ADMIN_PERMISSION_KEYS],
        managedPrefectures: (_b = adminUser.managedPrefectures) !== null && _b !== void 0 ? _b : [],
    };
});
/** Super admin only: update another admin user's role, permissions, prefectures. */
exports.adminUpdateAdminAccess = functions
    .region("asia-northeast1")
    .https.onCall(async (data, context) => {
    var _a, _b;
    const adminUser = await (0, verifyAdmin_1.verifyAdmin)(context);
    (0, adminPermissions_1.requireSuperAdmin)(adminUser);
    const userId = data === null || data === void 0 ? void 0 : data.userId;
    if (!userId) {
        throw new functions.https.HttpsError("invalid-argument", "userId is required.");
    }
    const targetRef = db().collection("users").doc(userId);
    const targetSnap = await targetRef.get();
    if (!targetSnap.exists) {
        throw new functions.https.HttpsError("not-found", "User not found.");
    }
    if (((_a = targetSnap.data()) === null || _a === void 0 ? void 0 : _a.role_admin) !== "admin") {
        throw new functions.https.HttpsError("failed-precondition", "Target user is not an administrator.");
    }
    const update = {
        admin_access_updated_at: admin.firestore.FieldValue.serverTimestamp(),
        admin_access_updated_by: adminUser.uid,
    };
    if ((data === null || data === void 0 ? void 0 : data.adminRole) !== undefined) {
        const adminRole = data.adminRole;
        if (!["super_admin", "prefecture_admin"].includes(adminRole)) {
            throw new functions.https.HttpsError("invalid-argument", "adminRole must be super_admin or prefecture_admin.");
        }
        update.admin_role = adminRole;
    }
    if ((data === null || data === void 0 ? void 0 : data.adminPermissions) !== undefined) {
        const perms = data.adminPermissions;
        const sanitized = {};
        for (const key of adminPermissions_1.ADMIN_PERMISSION_KEYS) {
            sanitized[key] = perms[key] === true;
        }
        update.admin_permissions = sanitized;
    }
    if ((data === null || data === void 0 ? void 0 : data.managedPrefectures) !== undefined) {
        const prefectures = (_b = data.managedPrefectures) !== null && _b !== void 0 ? _b : [];
        update.managed_prefectures = prefectures.filter((p) => typeof p === "string" && p.trim().length > 0);
    }
    await targetRef.set(update, { merge: true });
    return { ok: true, userId };
});
//# sourceMappingURL=permissions.js.map