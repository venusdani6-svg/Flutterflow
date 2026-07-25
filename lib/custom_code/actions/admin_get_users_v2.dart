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

Future<dynamic> adminGetUsersV2(
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
  bool? ignoreFrozenFilter,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetUsers');
    final payload = <String, dynamic>{
      'account_type': accountType,
      'approval_status': approvalStatus,
      'kyc_status': kycStatus,
      'prefecture': prefecture,
      'created_after': createdAfter,
      'created_before': createdBefore,
      'nickname_prefix': nicknamePrefix,
      'limit': limit ?? 50,
      'offset': offset,
      'user_id': userId,
    };
    if (ignoreFrozenFilter != true) {
      payload['is_frozen'] = isFrozen;
    }
    final result = await callable.call(payload);

    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final usersRaw = data['users'];
    if (usersRaw is List) {
      data['users'] = usersRaw.map((u) {
        if (u is! Map) return u;
        try {
          return _normalizeUserV2(Map<String, dynamic>.from(u));
        } catch (_) {
          return u;
        }
      }).toList();
    }
    final userRaw = data['user'];
    if (userRaw is Map) {
      try {
        data['user'] = _normalizeUserV2(Map<String, dynamic>.from(userRaw));
      } catch (_) {}
    }
    return data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

Map<String, dynamic> _normalizeUserV2(Map<String, dynamic> user) {
  final createdAt = _parseTimestampV2(user['created_at']);
  final lastLoginAt = _parseTimestampV2(user['last_login_at']);
  final birthDate = _parseTimestampV2(user['birth_date']);
  final updatedAt = _parseTimestampV2(user['updated_at']);
  if (createdAt != null) {
    user['created_at'] = _formatDateV2(createdAt);
    user['created_at_time'] = _formatTimeV2(createdAt);
  }
  if (lastLoginAt != null) {
    user['last_login_at'] = _formatRelativeTimeV2(lastLoginAt);
  }
  if (updatedAt != null) {
    user['updated_at'] = _formatDateV2(updatedAt);
  }
  if (birthDate != null) {
    user['birth_date'] = _formatDateV2(birthDate);
    user['age'] = _calculateAgeV2(birthDate);
  }
  user['kyc_status'] = _kycStatusLabelV2(user['kyc_status']);
  user['is_active'] = (user['is_active'] == true) ? '有効' : '無効';
  final foodTags = user['favorite_food_tags'];
  if (foodTags is List) {
    user['favorite_food_tags'] = foodTags.join('、');
  }
  return user;
}

DateTime? _parseTimestampV2(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    final seconds = value['_seconds'] ?? value['seconds'];
    if (seconds is num) {
      return DateTime.fromMillisecondsSinceEpoch((seconds * 1000).round(),
          isUtc: true);
    }
  }
  if (value is String) return DateTime.tryParse(value);
  return null;
}

String _formatDateV2(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd';
}

String _formatRelativeTimeV2(DateTime utc) {
  final diff = DateTime.now().toUtc().difference(utc);
  if (diff.inMinutes < 1) return 'たった今';
  if (diff.inMinutes < 60) return '${diff.inMinutes}分前';
  if (diff.inHours < 24) return '${diff.inHours}時間前';
  if (diff.inDays < 30) return '${diff.inDays}日前';
  return '${diff.inDays ~/ 30}ヶ月前';
}

String _formatTimeV2(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final hh = jst.hour.toString().padLeft(2, '0');
  final mm = jst.minute.toString().padLeft(2, '0');
  return '$hh:$mm';
}

int _calculateAgeV2(DateTime utcBirthDate) {
  final birth = utcBirthDate.add(const Duration(hours: 9));
  final today = DateTime.now().toUtc().add(const Duration(hours: 9));
  var age = today.year - birth.year;
  if (today.month < birth.month ||
      (today.month == birth.month && today.day < birth.day)) {
    age--;
  }
  return age;
}

String _kycStatusLabelV2(dynamic status) {
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
