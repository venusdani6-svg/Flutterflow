import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {
  applyPrefectureQueryFilter,
  assertPrefectureAccess,
  filterRowsByPrefecture,
  getManagedPrefectures,
  isPrefectureAdmin,
  readPrefecture,
  requirePermission,
} from "../auth/adminPermissions";
import { verifyAdmin } from "../auth/verifyAdmin";

const db = () => admin.firestore();

export const adminGetCocotenShops = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "cocoten");
    const prefectures = getManagedPrefectures(adminUser);
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);

    const snap = await applyPrefectureQueryFilter(
      db().collection("cocoten_shops"),
      prefectures,
    )
      .orderBy("created_at", "desc")
      .limit(prefectures ? 500 : offset + limit)
      .get()
      .catch(async () =>
        applyPrefectureQueryFilter(
          db().collection("cocoten_shops"),
          prefectures,
        )
          .limit(prefectures ? 500 : offset + limit)
          .get(),
      );

    let shops = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    shops = filterRowsByPrefecture(shops, prefectures);
    const total = shops.length;
    const page = shops.slice(offset, offset + limit);
    return { shops: page, total, hasMore: offset + limit < total };
  });

export const adminUpsertCocotenShop = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "cocoten");
    const shopId =
      (data?.shopId as string) ?? db().collection("cocoten_shops").doc().id;
    const payload = {
      ...(data?.payload as Record<string, unknown>),
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
      updated_by: adminUser.uid,
    };
    if (isPrefectureAdmin(adminUser)) {
      const prefecture = readPrefecture(payload);
      if (prefecture) {
        assertPrefectureAccess(adminUser, prefecture);
      }
    }
    const docRef = db().collection("cocoten_shops").doc(shopId);
    const existing = await docRef.get();
    if (!existing.exists) {
      (payload as Record<string, unknown>).created_at =
        admin.firestore.FieldValue.serverTimestamp();
    }
    await docRef.set(payload, { merge: true });
    return { ok: true, shopId };
  });

export const adminGetJobBoardPosts = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "job_board");
    const prefectures = getManagedPrefectures(adminUser);
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);

    const snap = await applyPrefectureQueryFilter(
      db().collection("job_board"),
      prefectures,
    )
      .orderBy("created_at", "desc")
      .limit(prefectures ? 500 : offset + limit)
      .get()
      .catch(async () =>
        applyPrefectureQueryFilter(db().collection("job_board"), prefectures)
          .limit(prefectures ? 500 : offset + limit)
          .get(),
      );

    let posts = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    posts = filterRowsByPrefecture(posts, prefectures);
    const total = posts.length;
    const page = posts.slice(offset, offset + limit);
    return { posts: page, total, hasMore: offset + limit < total };
  });

export const adminUpsertJobBoardPost = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "job_board");
    const postId =
      (data?.postId as string) ?? db().collection("job_board").doc().id;
    const payload = {
      ...(data?.payload as Record<string, unknown>),
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
      updated_by: adminUser.uid,
    };
    if (isPrefectureAdmin(adminUser)) {
      const prefecture = readPrefecture(payload);
      if (prefecture) {
        assertPrefectureAccess(adminUser, prefecture);
      }
    }
    const docRef = db().collection("job_board").doc(postId);
    const existing = await docRef.get();
    if (!existing.exists) {
      (payload as Record<string, unknown>).created_at =
        admin.firestore.FieldValue.serverTimestamp();
    }
    await docRef.set(payload, { merge: true });
    return { ok: true, postId };
  });
