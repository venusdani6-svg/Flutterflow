import '/backend/cloud_functions/mobile_calls.dart';

/// Parsed feature flags for mobile tab visibility.
class AppFeatureFlags {
  const AppFeatureFlags({
    required this.cocoten,
    required this.staff,
    required this.staffShuttle,
    required this.affiliate,
    this.chatCloseSec,
  });

  final bool cocoten;
  final bool staff;
  final bool staffShuttle;
  final bool affiliate;
  final int? chatCloseSec;

  factory AppFeatureFlags.fromMap(Map<String, dynamic>? map) {
    final flags =
        Map<String, dynamic>.from((map?['featuresEnabled'] as Map?) ?? {});
    final settings =
        Map<String, dynamic>.from((map?['settings'] as Map?) ?? {});
    return AppFeatureFlags(
      cocoten: flags['cocoten'] == true,
      staff: flags['staff'] == true,
      staffShuttle: flags['staff_shuttle'] == true,
      affiliate: flags['affiliate'] == true,
      chatCloseSec: (settings['chat_close_sec'] as num?)?.toInt(),
    );
  }
}

/// Home screen payload (banners + flags + announcements).
class AppHomeData {
  const AppHomeData({
    required this.banners,
    required this.featureFlags,
    required this.announcements,
    this.generatedAt,
  });

  final List<Map<String, dynamic>> banners;
  final AppFeatureFlags featureFlags;
  final List<Map<String, dynamic>> announcements;
  final String? generatedAt;

  factory AppHomeData.fromMap(Map<String, dynamic>? map) {
    final banners = (map?['banners'] as List?)
            ?.map((e) => Map<String, dynamic>.from(e as Map))
            .toList() ??
        [];
    final announcements = (map?['announcements'] as List?)
            ?.map((e) => Map<String, dynamic>.from(e as Map))
            .toList() ??
        [];
    final flagsMap = <String, dynamic>{
      'featuresEnabled': map?['featuresEnabled'],
      'settings': null,
    };
    return AppHomeData(
      banners: banners,
      featureFlags: AppFeatureFlags.fromMap(flagsMap),
      announcements: announcements,
      generatedAt: map?['generatedAt'] as String?,
    );
  }
}

/// Mobile app integration layer. Copy this file + [mobile_calls.dart] to the
/// consumer app project.
class MobileAppService {
  Future<AppHomeData> fetchHomeData() async {
    final raw = await getAppHomeData();
    return AppHomeData.fromMap(raw);
  }

  Future<AppFeatureFlags> fetchFeatureFlags() async {
    final raw = await getAppFeatureFlags();
    return AppFeatureFlags.fromMap(raw);
  }

  Future<Map<String, dynamic>?> fetchStripeConnectStatus() =>
      getStripeConnectStatus();

  Future<String?> openStripeConnectOnboarding({
    required String returnUrl,
    required String refreshUrl,
  }) async {
    final raw = await createStripeConnectOnboardingLink(
      returnUrl: returnUrl,
      refreshUrl: refreshUrl,
    );
    return raw?['url'] as String?;
  }
}
