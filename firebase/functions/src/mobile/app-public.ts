import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { verifyAuth } from "../auth/verifyAuth";

const db = () => admin.firestore();

/**
 * Mobile Home screen: active banners + announcements snippet.
 * Call on app launch / pull-to-refresh so admin banner changes appear on Home.
 */
export const getAppHomeData = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    verifyAuth(context);

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
        .catch(async () =>
          db()
            .collection("announcements")
            .where("active", "==", true)
            .limit(5)
            .get(),
        ),
    ]);

    const config = configSnap.data() ?? {};
    const featuresEnabled =
      (config.features_enabled as Record<string, unknown>) ?? {};

    return {
      banners: bannerSnap.docs.map((d) => ({ id: d.id, ...d.data() })),
      featuresEnabled,
      announcements: announcementSnap.docs.map((d) => ({
        id: d.id,
        ...d.data(),
      })),
      generatedAt: new Date().toISOString(),
    };
  });

/**
 * Feature flags for mobile tab visibility (cocoten, staff, affiliate, etc.).
 * Re-fetch after admin saves system settings (features_enabled).
 */
export const getAppFeatureFlags = functions
  .region("asia-northeast1")
  .https.onCall(async (_data, context) => {
    verifyAuth(context);

    const configSnap = await db().collection("system_config").doc("default").get();
    const config = configSnap.data() ?? {};
    const featuresEnabled =
      (config.features_enabled as Record<string, unknown>) ?? {};

    return {
      featuresEnabled: {
        cocoten: featuresEnabled.cocoten === true,
        staff: featuresEnabled.staff === true || featuresEnabled.staff_security === true,
        staff_shuttle: featuresEnabled.staff_shuttle === true,
        affiliate: featuresEnabled.affiliate === true,
      },
      settings: {
        chat_close_sec: (config.settings as Record<string, unknown>)?.chat_close_sec ?? null,
      },
      generatedAt: new Date().toISOString(),
    };
  });
