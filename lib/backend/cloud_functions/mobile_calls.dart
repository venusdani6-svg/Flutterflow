import '/auth/firebase_auth/auth_util.dart';

Future<Map<String, dynamic>> _callMobile(
  String name, [
  Map<String, dynamic> data = const {},
]) async {
  final result = await adminFunctions.httpsCallable(name).call(data);
  return Map<String, dynamic>.from(result.data as Map);
}

/// Stripe Connect Express onboarding URL for cast users (mobile).
Future<Map<String, dynamic>?> createStripeConnectOnboardingLink({
  String? returnUrl,
  String? refreshUrl,
}) =>
    _callMobile('createStripeConnectOnboardingLink', {
      if (returnUrl != null) 'returnUrl': returnUrl,
      if (refreshUrl != null) 'refreshUrl': refreshUrl,
    });

/// Current Stripe Connect status for the signed-in cast user.
Future<Map<String, dynamic>?> getStripeConnectStatus() =>
    _callMobile('getStripeConnectStatus');

/// Home screen data: active banners, feature flags, recent announcements.
Future<Map<String, dynamic>?> getAppHomeData() =>
    _callMobile('getAppHomeData');

/// Feature flags for mobile tab visibility (refetch after admin saves settings).
Future<Map<String, dynamic>?> getAppFeatureFlags() =>
    _callMobile('getAppFeatureFlags');
