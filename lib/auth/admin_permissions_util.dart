import '/backend/cloud_functions/admin_calls.dart';

/// Cached admin permissions from [adminGetMyPermissions].
class AdminPermissions {
  AdminPermissions._();

  static Map<String, dynamic>? _cache;

  static const permissionKeys = [
    'dashboard',
    'user_management',
    'reservations',
    'payment_ledger',
    'withdrawal',
    'kyc',
    'reports',
    'affiliate',
    'cocoten',
    'job_board',
    'banners',
    'system_settings',
    'audit_logs',
  ];

  static const permissionLabels = {
    'dashboard': 'ダッシュボード',
    'user_management': 'ユーザー管理',
    'reservations': '予約管理',
    'payment_ledger': '決済・台帳管理',
    'withdrawal': '出金申請管理',
    'kyc': 'KYC審査管理',
    'reports': '通報管理',
    'affiliate': 'アフィリエイト管理',
    'cocoten': 'ココ店管理',
    'job_board': 'お仕事掲示板管理',
    'banners': 'バナー広告管理',
    'system_settings': 'システム設定管理',
    'audit_logs': '監査ログ管理',
  };

  static bool get isLoaded => _cache != null;

  static bool get isSuperAdmin => _cache?['isSuperAdmin'] == true;

  static String get adminRole =>
      _cache?['adminRole'] as String? ?? 'super_admin';

  static List<String> get managedPrefectures => List<String>.from(
        _cache?['managedPrefectures'] as List? ?? [],
      );

  static Future<void> refresh() async {
    try {
      _cache = await adminGetMyPermissions();
    } catch (_) {
      _cache = {
        'isSuperAdmin': true,
        'permissions': {
          for (final key in permissionKeys) key: true,
        },
        'managedPrefectures': <String>[],
      };
    }
  }

  static void clear() {
    _cache = null;
  }

  static bool can(String permissionKey) {
    if (_cache == null || isSuperAdmin) {
      return true;
    }
    final permissions = Map<String, dynamic>.from(
      (_cache?['permissions'] as Map?) ?? {},
    );
    return permissions[permissionKey] == true;
  }

  static String? firstAllowedRouteName(Map<String, String> routeByPermission) {
    for (final entry in routeByPermission.entries) {
      if (can(entry.key)) {
        return entry.value;
      }
    }
    return null;
  }
}
