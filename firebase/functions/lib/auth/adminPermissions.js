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
exports.ADMIN_PERMISSION_KEYS = void 0;
exports.isSuperAdmin = isSuperAdmin;
exports.isPrefectureAdmin = isPrefectureAdmin;
exports.getManagedPrefectures = getManagedPrefectures;
exports.hasPermission = hasPermission;
exports.requirePermission = requirePermission;
exports.requireSuperAdmin = requireSuperAdmin;
exports.buildEffectivePermissions = buildEffectivePermissions;
exports.assertPrefectureAccess = assertPrefectureAccess;
exports.applyPrefectureQueryFilter = applyPrefectureQueryFilter;
exports.filterRowsByPrefecture = filterRowsByPrefecture;
exports.readPrefecture = readPrefecture;
const functions = __importStar(require("firebase-functions"));
/** Screen-level permission keys (stored in users.admin_permissions). */
exports.ADMIN_PERMISSION_KEYS = [
    "dashboard",
    "user_management",
    "reservations",
    "payment_ledger",
    "withdrawal",
    "kyc",
    "reports",
    "affiliate",
    "cocoten",
    "job_board",
    "banners",
    "system_settings",
    "audit_logs",
];
function isSuperAdmin(admin) {
    var _a;
    const role = (_a = admin.adminRole) !== null && _a !== void 0 ? _a : "super_admin";
    return role === "super_admin";
}
function isPrefectureAdmin(admin) {
    return admin.adminRole === "prefecture_admin";
}
function getManagedPrefectures(admin) {
    var _a;
    if (isSuperAdmin(admin)) {
        return null;
    }
    return (_a = admin.managedPrefectures) !== null && _a !== void 0 ? _a : [];
}
function hasPermission(admin, key) {
    var _a;
    if (isSuperAdmin(admin)) {
        return true;
    }
    return ((_a = admin.adminPermissions) === null || _a === void 0 ? void 0 : _a[key]) === true;
}
function requirePermission(admin, key) {
    if (!hasPermission(admin, key)) {
        throw new functions.https.HttpsError("permission-denied", `Missing permission: ${key}`);
    }
}
function requireSuperAdmin(admin) {
    if (!isSuperAdmin(admin)) {
        throw new functions.https.HttpsError("permission-denied", "Super administrator privileges are required.");
    }
}
function buildEffectivePermissions(admin) {
    const result = {};
    for (const key of exports.ADMIN_PERMISSION_KEYS) {
        result[key] = hasPermission(admin, key);
    }
    return result;
}
function assertPrefectureAccess(admin, documentPrefecture) {
    const scope = getManagedPrefectures(admin);
    if (scope === null) {
        return;
    }
    if (scope.length === 0) {
        throw new functions.https.HttpsError("permission-denied", "No managed prefectures assigned.");
    }
    const prefecture = (documentPrefecture !== null && documentPrefecture !== void 0 ? documentPrefecture : "").trim();
    if (!prefecture || !scope.includes(prefecture)) {
        throw new functions.https.HttpsError("permission-denied", "This record is outside your managed prefectures.");
    }
}
function applyPrefectureQueryFilter(query, prefectures) {
    if (prefectures === null) {
        return query;
    }
    if (prefectures.length === 0) {
        return query.where("prefecture", "==", "__none__");
    }
    if (prefectures.length <= 10) {
        return query.where("prefecture", "in", prefectures);
    }
    return query.where("prefecture", "in", prefectures.slice(0, 10));
}
function filterRowsByPrefecture(rows, prefectures, field = "prefecture") {
    if (prefectures === null) {
        return rows;
    }
    if (prefectures.length === 0) {
        return [];
    }
    return rows.filter((row) => {
        var _a;
        const value = String((_a = row[field]) !== null && _a !== void 0 ? _a : "");
        return prefectures.includes(value);
    });
}
function readPrefecture(data) {
    var _a, _b, _c;
    return String((_c = (_b = (_a = data.prefecture) !== null && _a !== void 0 ? _a : data.service_prefecture) !== null && _b !== void 0 ? _b : data.location_prefecture) !== null && _c !== void 0 ? _c : "");
}
//# sourceMappingURL=adminPermissions.js.map