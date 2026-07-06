import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

export const onUserDeleted = functions.auth.user().onDelete(async (user) => {
  const firestore = admin.firestore();
  await firestore.collection("users").doc(user.uid).delete();
});
