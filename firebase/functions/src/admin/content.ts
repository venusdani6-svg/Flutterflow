import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import {
  applyPrefectureQueryFilter,
  assertPrefectureAccess,
  filterRowsByPrefecture,
  getManagedPrefectures,
  readPrefecture,
  requirePermission,
} from "../auth/adminPermissions";
import { verifyAdmin } from "../auth/verifyAdmin";

const db = () => admin.firestore();

export const adminUpdateSystemConfig = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "system_settings");
    const section = (data?.section as string) ?? "settings";
    const payload = data?.payload ?? {};
    const docRef = db().collection("system_config").doc("default");
    await docRef.set(
      {
        [section]: payload,
        updated_at: admin.firestore.FieldValue.serverTimestamp(),
        updated_by: adminUser.uid,
      },
      { merge: true },
    );
    return { ok: true, section };
  });

export const adminGetSystemConfig = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "system_settings");
    const snap = await db().collection("system_config").doc("default").get();
    return snap.exists ? snap.data() : {};
  });

export const adminGetBanners = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "banners");
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const snap = await db()
      .collection("banners")
      .orderBy("sort_order", "asc")
      .limit(limit)
      .get()
      .catch(async () => db().collection("banners").limit(limit).get());
    const banners = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    return { banners, total: banners.length };
  });

export const adminUpsertBanner = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "banners");
    const bannerId = (data?.bannerId as string) ?? db().collection("banners").doc().id;
    const payload = { ...(data?.payload as Record<string, unknown>), updated_at: admin.firestore.FieldValue.serverTimestamp(), updated_by: adminUser.uid };
    await db().collection("banners").doc(bannerId).set(payload, { merge: true });
    return { ok: true, bannerId };
  });

export const adminGetReports = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "reports");
    const prefectures = getManagedPrefectures(adminUser);
    const status = data?.status as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);
    let baseQuery: FirebaseFirestore.Query = applyPrefectureQueryFilter(
      db().collection("reports"),
      prefectures,
    );
    if (status) {
      baseQuery = baseQuery.where("status", "==", status);
    }
    const snap = await baseQuery
      .orderBy("created_at", "desc")
      .limit(prefectures ? 500 : offset + limit)
      .get();
    let reports = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    reports = filterRowsByPrefecture(reports, prefectures);
    const total = reports.length;
    const page = reports.slice(offset, offset + limit);
    return { reports: page, total, hasMore: offset + limit < total };
  });

export const adminResolveReport = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "reports");
    const reportId = data?.reportId as string;
    const resolution = (data?.resolution as string) ?? "resolved";
    if (!reportId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "reportId is required.",
      );
    }
    const reportDoc = await db().collection("reports").doc(reportId).get();
    assertPrefectureAccess(adminUser, readPrefecture(reportDoc.data() ?? {}));
    await db().collection("reports").doc(reportId).update({
      status: resolution,
      resolved_at: admin.firestore.FieldValue.serverTimestamp(),
      resolved_by: adminUser.uid,
    });
    return { ok: true, reportId, status: resolution };
  });

export const adminGetAffiliateOverview = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "affiliate");
    const prefectures = getManagedPrefectures(adminUser);
    const limit = Math.min(Number(data?.limit ?? 100), 200);
    const snap = await applyPrefectureQueryFilter(
      db().collection("users").where("is_affiliate", "==", true),
      prefectures,
    )
      .limit(limit)
      .get()
      .catch(async () =>
        db().collection("affiliate_stats").limit(limit).get(),
      );
    let affiliates = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    affiliates = filterRowsByPrefecture(affiliates, prefectures);
    const monthlySnap = await db()
      .collection("affiliate_monthly_rewards")
      .orderBy("month", "desc")
      .limit(12)
      .get()
      .catch(() => null);
    const monthlyRewards =
      monthlySnap?.docs.map((d) => ({ id: d.id, ...d.data() })) ?? [];
    return { affiliates, total: affiliates.length, monthlyRewards };
  });

export const adminUpdateAffiliateRate = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "affiliate");
    const userId = data?.userId as string;
    const rate = Number(data?.rate);
    if (!userId || Number.isNaN(rate)) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "userId and rate are required.",
      );
    }
    const userDoc = await db().collection("users").doc(userId).get();
    assertPrefectureAccess(adminUser, readPrefecture(userDoc.data() ?? {}));
    await db().collection("users").doc(userId).update({ affiliate_rate: rate });
    return { ok: true, userId, rate };
  });

export const adminGetAuditLogs = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "audit_logs");
    const targetType = data?.targetType as string | undefined;
    const targetId = data?.targetId as string | undefined;
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const offset = Number(data?.offset ?? 0);
    let query: FirebaseFirestore.Query = db().collection("audit_logs");
    if (targetType) {
      query = query.where("target_type", "==", targetType);
    }
    if (targetId) {
      query = query.where("target_id", "==", targetId);
    }
    const countSnap = await query.count().get().catch(() => null);
    const snap = await query
      .orderBy("created_at", "desc")
      .offset(offset)
      .limit(limit)
      .get()
      .catch(async () =>
        db()
          .collection("audit_logs")
          .orderBy("created_at", "desc")
          .offset(offset)
          .limit(limit)
          .get(),
      );
    const logs = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    const total = countSnap?.data().count ?? logs.length;
    return { logs, total, hasMore: offset + limit < total };
  });

export const adminGetAnnouncements = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "system_settings");
    const limit = Math.min(Number(data?.limit ?? 50), 100);
    const snap = await db()
      .collection("announcements")
      .orderBy("created_at", "desc")
      .limit(limit)
      .get()
      .catch(async () => db().collection("announcements").limit(limit).get());
    const announcements = snap.docs.map((d) => ({ id: d.id, ...d.data() }));
    return { announcements, total: announcements.length };
  });

export const adminUpsertAnnouncement = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "system_settings");
    const announcementId =
      (data?.announcementId as string) ??
      db().collection("announcements").doc().id;
    const payload = {
      ...(data?.payload as Record<string, unknown>),
      updated_at: admin.firestore.FieldValue.serverTimestamp(),
      updated_by: adminUser.uid,
    };
    const docRef = db().collection("announcements").doc(announcementId);
    const existing = await docRef.get();
    if (!existing.exists) {
      (payload as Record<string, unknown>).created_at =
        admin.firestore.FieldValue.serverTimestamp();
    }
    await docRef.set(payload, { merge: true });
    return { ok: true, announcementId };
  });

export const adminGetGuideline = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "system_settings");
    const snap = await db().collection("system_config").doc("default").get();
    const data = snap.data() ?? {};
    return {
      content: data.guideline ?? data.guidelines ?? "",
      updated_at: data.guideline_updated_at ?? null,
    };
  });

export const adminUpdateGuideline = functions
  .region("asia-northeast1")
  .https.onCall(async (data, context) => {
    const adminUser = await verifyAdmin(context);
    requirePermission(adminUser, "system_settings");
    const content = (data?.content as string) ?? "";
    await db()
      .collection("system_config")
      .doc("default")
      .set(
        {
          guideline: content,
          guideline_updated_at: admin.firestore.FieldValue.serverTimestamp(),
          guideline_updated_by: adminUser.uid,
        },
        { merge: true },
      );
    return { ok: true };
  });
