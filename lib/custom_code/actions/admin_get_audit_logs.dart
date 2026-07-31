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

Future<dynamic> adminGetAuditLogs(
  String? action,
  String? createdAfter,
  String? createdBefore,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetAuditLogs');
    final result = await callable.call({
      'action': action,
      'created_after': createdAfter,
      'created_before': createdBefore,
      'limit': 100,
    });
    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final logsRaw = data['logs'];
    if (logsRaw is! List) return <AuditLogItemStruct>[];
    return logsRaw
        .whereType<Map>()
        .map((l) => _toAuditLogItem(Map<String, dynamic>.from(l)))
        .toList();
  } catch (e) {
    return <AuditLogItemStruct>[];
  }
}

AuditLogItemStruct _toAuditLogItem(Map<String, dynamic> log) {
  final createdAt = _parseAuditTimestamp(log['created_at']);
  final reason = (log['reason'] ?? '').toString().trim();
  var reasonDisplay = reason;
  if (reasonDisplay.isEmpty) {
    final details = log['details'];
    if (details is Map && details.isNotEmpty) {
      reasonDisplay =
          details.entries.map((e) => '${e.key}: ${e.value}').join('、');
    }
  }
  return AuditLogItemStruct.fromMap({
    'id': log['id']?.toString() ?? '',
    'admin_nickname': log['admin_nickname']?.toString() ?? '',
    'action_label': _auditActionLabel(log['action']),
    'target_type_label': _auditTargetTypeLabel(log['target_type']),
    'target_id': log['target_id']?.toString() ?? '',
    'created_at': createdAt != null ? _formatAuditDateTime(createdAt) : '',
    'reason_display': reasonDisplay,
  });
}

DateTime? _parseAuditTimestamp(dynamic value) {
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

String _formatAuditDateTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  final hh = jst.hour.toString().padLeft(2, '0');
  final min = jst.minute.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd $hh:$min';
}

/// Every value taken directly from a real `createAuditLog(...)` call site
/// in admin.ts (grepped, not guessed) - falls back to the raw value for
/// anything unrecognized rather than masking a future new action type.
String _auditActionLabel(dynamic action) {
  switch (action) {
    case 'approve_kyc':
      return 'KYC承認';
    case 'reject_kyc':
      return 'KYC却下';
    case 'freeze_account':
      return 'アカウント凍結';
    case 'unfreeze_account':
      return 'アカウント凍結解除';
    case 'force_delete':
      return '強制退会';
    case 'force_cancel':
      return '予約強制キャンセル';
    case 'update_reservation_location':
      return '予約場所変更';
    case 'update_affiliate_rate':
      return 'アフィリエイト料率変更';
    case 'delete_banner':
      return 'バナー削除';
    case 'update_system_config':
      return 'システム設定変更';
    case 'resolve_report':
      return '通報対応';
    case 'payout_on_hold':
      return '出金保留';
    case 'payout_rejected':
      return '出金否認';
    case 'approve_payout':
      return '出金承認';
    default:
      return action?.toString() ?? '不明';
  }
}

String _auditTargetTypeLabel(dynamic type) {
  switch (type) {
    case 'user':
      return 'ユーザー';
    case 'reservation':
      return '予約';
    case 'banner':
      return 'バナー';
    case 'system':
      return 'システム';
    case 'report':
      return '通報';
    case 'payout_request':
      return '出金申請';
    default:
      return type?.toString() ?? '不明';
  }
}
