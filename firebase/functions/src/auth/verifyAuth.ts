import * as functions from "firebase-functions";
import { CallableContext } from "firebase-functions/v1/https";

export interface AuthUserContext {
  uid: string;
  email?: string;
}

/** Verifies any authenticated Firebase user (mobile / cast / guest). */
export function verifyAuth(context: CallableContext): AuthUserContext {
  if (!context.auth?.uid) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Authentication is required.",
    );
  }
  return {
    uid: context.auth.uid,
    email: context.auth.token.email,
  };
}
