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
/// - status (String?)
/// - limit (int?)
///
/// The deployed Cloud Function returns raw report docs (reporter_id,
/// reported_id, report_type, reason, status, admin_note, seeded) with
/// created_at/updated_at as raw Firestore Timestamps — which the client
/// SDK serializes as {_seconds, _nanoseconds}, not an ISO string (unlike
/// admin_get_affiliate_overview.dart's endpoint). Adds status_label and
/// created_at_display here so 通報一覧 doesn't need to parse either shape
/// itself. reporter_id/reported_id are passed through raw (uid, not
/// nickname) — same scoping decision already used for the reservations
/// list (no nickname join in this pass).
Future<dynamic> adminGetReports(
  String? status,
  int? limit,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetReports');
    final result = await callable.call({
      'status': status,
      'limit': limit ?? 50,
    });
    final data = result.data;
    if (data is! Map || data['success'] != true) {
      return {
        'success': false,
        'error':
            data is Map ? (data['error'] ?? 'unknown error') : 'unknown error',
        'reports': <dynamic>[],
      };
    }

    final reportsRaw = data['reports'] is List ? data['reports'] as List : [];
    final reports = reportsRaw.map((raw) {
      final r = Map<String, dynamic>.from(raw as Map);
      return {
        ...r,
        'status_label': _statusLabel(r['status'] as String?),
        'created_at_display': _fmtTimestamp(r['created_at']),
      };
    }).toList();

    return {
      'success': true,
      'reports': reports,
    };
  } catch (e) {
    return {'success': false, 'error': e.toString(), 'reports': <dynamic>[]};
  }
}

String _statusLabel(String? status) {
  switch (status) {
    case 'pending':
      return '未対応';
    case 'resolved':
      return '解決済';
    case 'rejected':
      return '却下';
    default:
      return status ?? '不明';
  }
}

String _fmtTimestamp(dynamic raw) {
  if (raw is! Map || raw['_seconds'] == null) return 'なし';
  final seconds = (raw['_seconds'] as num).toInt();
  final dt = DateTime.fromMillisecondsSinceEpoch(seconds * 1000).toLocal();
  final mm = dt.month.toString().padLeft(2, '0');
  final dd = dt.day.toString().padLeft(2, '0');
  final hh = dt.hour.toString().padLeft(2, '0');
  final min = dt.minute.toString().padLeft(2, '0');
  return '${dt.year}. $mm. $dd $hh:$min';
}
