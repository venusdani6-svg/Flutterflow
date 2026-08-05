// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

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
/// - userId (String?)
/// - type (String?)
/// - status (String?)
/// - limit (int?)
/// - resId (String?) - filters to ledger entries for one reservation
///   (added for the reservation-detail tip line; appended last so existing
///   callers bound by parameter name are unaffected - leave Unset where
///   not used, since it's nullable).
/// - createdAfter / createdBefore (String?) - ISO date strings; filters
///   on `created_at` (matches this collection's only timestamp field -
///   there's no separate "scheduled" concept for ledger entries).
Future<dynamic> adminGetLedger(
  String? userId,
  String? type,
  String? status,
  int? limit,
  String? resId,
  String? createdAfter,
  String? createdBefore,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetLedger');
    final result = await callable.call({
      'user_id': userId,
      'res_id': resId,
      'type': type,
      'status': status,
      'created_after': createdAfter,
      'created_before': createdBefore,
      'limit': limit ?? 100,
    });

    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final entriesRaw = data['entries'];
    if (entriesRaw is List) {
      data['entries'] = entriesRaw.map((e) {
        if (e is! Map) return e;
        try {
          return _normalizeLedgerEntry(Map<String, dynamic>.from(e));
        } catch (_) {
          return e;
        }
      }).toList();
    }
    // Client Checklist Implementation Plan.md P1 item 7: 決済総額/送金実額/
    // 運営利益, computed server-side (admin.ts's computeLedgerSummary) over
    // an unlimited pass across the same filters, not just this page's
    // capped row list - pre-formatted here the same way every other
    // display field on this page already is.
    data['gross_total_display'] = _formatLedgerYen(data['gross_total']);
    data['net_transfer_total_display'] =
        _formatLedgerYen(data['net_transfer_total']);
    data['platform_profit_total_display'] =
        _formatLedgerYen(data['platform_profit_total']);
    return data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

String _formatLedgerYen(dynamic value) {
  final n = value is num ? value.toInt() : 0;
  return '¥$n';
}

Map<String, dynamic> _normalizeLedgerEntry(Map<String, dynamic> entry) {
  entry['status_label'] = _ledgerStatusLabel(entry['status']);
  entry['type_label'] = _ledgerTypeLabel(entry['type']);
  final createdAt = _parseTimestamp(entry['created_at']);
  if (createdAt != null) {
    entry['created_at'] = _formatDateTime(createdAt);
  }
  return entry;
}

/// Same Timestamp-or-ISO-string handling as admin_get_reservations.dart's
/// _parseTimestamp - the callable returns raw Firestore Timestamp maps
/// ({_seconds, _nanoseconds}), not formatted strings.
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

/// "2026. 05. 22 15:36" style, JST - the row template shows date and time
/// together for 作成日時, unlike the reservations list which only needed
/// the date.
String _formatDateTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  final hh = jst.hour.toString().padLeft(2, '0');
  final min = jst.minute.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd $hh:$min';
}

/// Japanese labels for the `status` enum documented in
/// `firebase/firestore/schema.md`'s Ledger section. Falls back to the raw
/// value for anything unrecognized, same reasoning as
/// admin_get_reservations.dart's _statusLabel - surfaces a data-quality
/// issue instead of masking it.
String _ledgerStatusLabel(dynamic status) {
  switch (status) {
    case 'pending':
      return '保留中';
    case 'confirmed':
      return '確定';
    case 'failed':
      return '失敗';
    case 'retrying':
      return '再試行中';
    default:
      return status?.toString() ?? '不明';
  }
}

/// Japanese labels for the `type` enum documented in
/// `firebase/firestore/schema.md`'s Ledger section.
String _ledgerTypeLabel(dynamic type) {
  switch (type) {
    case 'reward':
      return '報酬';
    case 'staff_fee':
      return 'スタッフ費用';
    case 'refund':
      return '返金';
    case 'affiliate':
      return 'アフィリエイト報酬';
    case 'debt_offset':
      return '負債相殺';
    case 'tip':
      return 'チップ';
    default:
      return type?.toString() ?? '不明';
  }
}
