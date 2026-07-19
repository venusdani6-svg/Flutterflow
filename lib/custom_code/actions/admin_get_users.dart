// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

/// FlutterFlow parameters (all optional):
/// - accountType (String?)
/// - approvalStatus (String?)
/// - isFrozen (bool?)
/// - kycStatus (String?) - "pending" / "submitted" / "approved" / "rejected"
/// - prefecture (String?) - matches Users.prefecture exactly (地域 filter)
/// - createdAfter / createdBefore (String?) - ISO date strings; registration
///   period filter (登録期間). Mutually exclusive with nicknamePrefix in a
///   single call — Firestore only allows one range-type filter per query,
///   so if both are set, the backend ignores this range and applies the
///   nickname search instead.
/// - nicknamePrefix (String?) - search box text; matches nicknames starting
///   with this value (Firestore can't do "contains"). When set, results are
///   sorted by nickname instead of registration date.
/// - limit (int?)
/// - offset (String?)
/// - userId (String?) - single-record lookup for detail pages. When set,
///   every filter above is ignored server-side and the response's `user`
///   key holds that one record (also present as the sole entry in `users`
///   for compatibility with the list-page normalization below).
///
/// Normalizes each user in the response so list/detail-page JSON Path
/// bindings ($.created_at, $.last_login_at, $.kyc_status, $.is_active, …)
/// get display-ready values instead of raw Firestore Timestamp maps
/// ({_seconds, _nanoseconds}) and raw enum/boolean values. The single-record
/// `user` object additionally gets `age` (computed from birth_date) and
/// `created_at_time` (the detail-page mockup shows registration date and
/// time as two separate widgets). `birth_date` is formatted the same plain
/// Gregorian way as created_at, not the Japanese-era style ("昭和57年...")
/// the mockup shows — flag to the client if era formatting is actually
/// wanted, since that's a display choice this code doesn't make.
Future<dynamic> adminGetUsers(
  String? accountType,
  String? approvalStatus,
  bool? isFrozen,
  String? kycStatus,
  String? prefecture,
  String? createdAfter,
  String? createdBefore,
  String? nicknamePrefix,
  int? limit,
  String? offset,
  String? userId,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetUsers');
    final result = await callable.call({
      'account_type': accountType,
      'approval_status': approvalStatus,
      'is_frozen': isFrozen,
      'kyc_status': kycStatus,
      'prefecture': prefecture,
      'created_after': createdAfter,
      'created_before': createdBefore,
      'nickname_prefix': nicknamePrefix,
      'limit': limit ?? 50,
      'offset': offset,
      'user_id': userId,
    });

    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final usersRaw = data['users'];
    if (usersRaw is List) {
      data['users'] = usersRaw.map((u) {
        if (u is! Map) return u;
        try {
          return _normalizeUser(Map<String, dynamic>.from(u));
        } catch (_) {
          return u;
        }
      }).toList();
    }
    final userRaw = data['user'];
    if (userRaw is Map) {
      try {
        data['user'] = _normalizeUser(Map<String, dynamic>.from(userRaw));
      } catch (_) {
        // leave as-is; page shows whatever raw fields did resolve
      }
    }
    return data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

/// Shared by both the list (`users`) and single-record (`user`) response
/// shapes — same fields, same raw-Firestore-value quirks either way.
Map<String, dynamic> _normalizeUser(Map<String, dynamic> user) {
  final createdAt = _parseTimestamp(user['created_at']);
  final lastLoginAt = _parseTimestamp(user['last_login_at']);
  final birthDate = _parseTimestamp(user['birth_date']);
  if (createdAt != null) {
    user['created_at'] = _formatDate(createdAt);
    user['created_at_time'] = _formatTime(createdAt);
  }
  if (lastLoginAt != null) {
    user['last_login_at'] = _formatRelativeTime(lastLoginAt);
  }
  if (birthDate != null) {
    user['birth_date'] = _formatDate(birthDate);
    user['age'] = _calculateAge(birthDate);
  }
  user['kyc_status'] = _kycStatusLabel(user['kyc_status']);
  user['is_active'] = (user['is_active'] == true) ? '有効' : '無効';
  final foodTags = user['favorite_food_tags'];
  if (foodTags is List) {
    user['favorite_food_tags'] = foodTags.join('、');
  }
  return user;
}

/// Accepts a Firestore Timestamp serialized as {_seconds, _nanoseconds}
/// (the shape actually returned by the callable Cloud Function) or an
/// ISO date string, and returns a DateTime in UTC.
DateTime? _parseTimestamp(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    final seconds = value['_seconds'] ?? value['seconds'];
    if (seconds is num) {
      return DateTime.fromMillisecondsSinceEpoch(
        (seconds * 1000).round(),
        isUtc: true,
      );
    }
  }
  if (value is String) {
    return DateTime.tryParse(value);
  }
  return null;
}

/// "2026. 07. 17" style, matching the page's original mockup format.
/// Shifted to JST since this is a Japan-only business.
String _formatDate(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd';
}

/// "15分前" style relative time. Duration math is timezone-agnostic.
String _formatRelativeTime(DateTime utc) {
  final diff = DateTime.now().toUtc().difference(utc);
  if (diff.inMinutes < 1) return 'たった今';
  if (diff.inMinutes < 60) return '${diff.inMinutes}分前';
  if (diff.inHours < 24) return '${diff.inHours}時間前';
  if (diff.inDays < 30) return '${diff.inDays}日前';
  return '${diff.inDays ~/ 30}ヶ月前';
}

/// "15:16" style, JST.
String _formatTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final hh = jst.hour.toString().padLeft(2, '0');
  final mm = jst.minute.toString().padLeft(2, '0');
  return '$hh:$mm';
}

/// Whole years between birth_date and today, both taken as JST calendar
/// dates so the boundary doesn't shift a day depending on server TZ.
int _calculateAge(DateTime utcBirthDate) {
  final birth = utcBirthDate.add(const Duration(hours: 9));
  final today = DateTime.now().toUtc().add(const Duration(hours: 9));
  var age = today.year - birth.year;
  if (today.month < birth.month ||
      (today.month == birth.month && today.day < birth.day)) {
    age--;
  }
  return age;
}

String _kycStatusLabel(dynamic status) {
  switch (status) {
    case 'approved':
      return '承認済';
    case 'submitted':
      return '提出済み';
    case 'rejected':
      return '却下';
    case 'pending':
    default:
      return '審査中';
  }
}
