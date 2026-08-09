// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

/// FlutterFlow parameters (all optional):
/// - status (String?) - one of the 4 statuses: pending / approved /
///   on_hold / rejected.
/// - limit (int?)
///
/// `stripe_balance` (live Stripe balance, JPY) and `debt_total` (summed
/// `debt_history`) are joined in server-side per request, since neither is
/// stored on the `payout_requests` document itself.
Future<dynamic> adminGetPayoutRequests(
  String? status,
  int? limit,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetPayoutRequests');
    final result = await callable.call({
      'status': status,
      'limit': limit ?? 50,
    });

    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final requestsRaw = data['requests'];
    if (requestsRaw is List) {
      data['requests'] = requestsRaw.map((r) {
        if (r is! Map) return r;
        try {
          return _normalizePayoutRequest(Map<String, dynamic>.from(r));
        } catch (_) {
          return r;
        }
      }).toList();
    }
    return data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

Map<String, dynamic> _normalizePayoutRequest(Map<String, dynamic> request) {
  request['status_label'] = _payoutStatusLabel(request['status']);
  final createdAt = _parseTimestamp(request['created_at']);
  if (createdAt != null) {
    request['created_at'] = _formatDateTime(createdAt);
  }
  return request;
}

/// Same Timestamp-or-ISO-string handling as admin_get_ledger.dart's
/// _parseTimestamp.
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

/// "2026. 05. 22 15:36" style, JST - same format as admin_get_ledger.dart's
/// 作成日時.
String _formatDateTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  final hh = jst.hour.toString().padLeft(2, '0');
  final min = jst.minute.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd $hh:$min';
}

/// Japanese labels matching filter_w_a_dialog_comp's existing 4 category
/// options (申請中/承認済/保留中/否認), so the dropdown and the row's
/// displayed status use the exact same wording.
String _payoutStatusLabel(dynamic status) {
  switch (status) {
    case 'pending':
      return '申請中';
    case 'approved':
      return '承認済';
    case 'on_hold':
      return '保留中';
    case 'rejected':
      return '否認';
    default:
      return status?.toString() ?? '不明';
  }
}
