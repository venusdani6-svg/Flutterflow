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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getStripeSecretKey = getStripeSecretKey;
exports.getStripeWebhookSecret = getStripeWebhookSecret;
exports.getStripe = getStripe;
const functions = __importStar(require("firebase-functions"));
const stripe_1 = __importDefault(require("stripe"));
let stripeClient = null;
function getStripeSecretKey() {
    var _a, _b;
    const key = (_a = process.env.STRIPE_SECRET_KEY) !== null && _a !== void 0 ? _a : (_b = functions.config().stripe) === null || _b === void 0 ? void 0 : _b.secret_key;
    if (!key) {
        throw new Error("STRIPE_SECRET_KEY is not configured. Set via firebase functions:secrets:set or functions.config().");
    }
    return key;
}
function getStripeWebhookSecret() {
    var _a, _b;
    const secret = (_a = process.env.STRIPE_WEBHOOK_SECRET) !== null && _a !== void 0 ? _a : (_b = functions.config().stripe) === null || _b === void 0 ? void 0 : _b.webhook_secret;
    if (!secret) {
        throw new Error("STRIPE_WEBHOOK_SECRET is not configured. Set via firebase functions:secrets:set or functions.config().");
    }
    return secret;
}
function getStripe() {
    if (!stripeClient) {
        stripeClient = new stripe_1.default(getStripeSecretKey(), {
            apiVersion: "2020-08-27",
        });
    }
    return stripeClient;
}
//# sourceMappingURL=config.js.map