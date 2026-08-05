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

import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';

/// FlutterFlow parameters (all optional):
/// - resId (String?)
/// - eventType (String?)
/// - limit (int?)
/// - startDate (String?) ISO date — now backend-supported (created_after)
/// - endDate (String?) ISO date — now backend-supported (created_before)
Future<dynamic> adminGetStripeLogs(
  String? resId,
  String? eventType,
  int? limit,
  String? startDate,
  String? endDate,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetStripeLogs');
    final result = await callable.call({
      'res_id': resId,
      'event_type': eventType,
      'limit': limit ?? 50,
      'start_date': startDate,
      'end_date': endDate,
    });

    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final logsRaw = data['logs'];
    if (logsRaw is List) {
      data['logs'] = logsRaw.map((l) {
        if (l is! Map) return l;
        try {
          return _normalizeStripeLog(Map<String, dynamic>.from(l));
        } catch (_) {
          return l;
        }
      }).toList();
    }
    return data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

Map<String, dynamic> _normalizeStripeLog(Map<String, dynamic> log) {
  final createdAt = _parseTimestamp(log['created_at']);
  if (createdAt != null) {
    log['created_at'] = _formatDateTime(createdAt);
  }
  // Client Checklist Implementation Plan.md P1 item 8: raw_data is already
  // delivered untouched by admin.ts - pretty-print it here the same way
  // every other display field on this page is pre-formatted server-
  // response-side, rather than fighting JSON formatting in the builder.
  final rawData = log['raw_data'];
  if (rawData != null) {
    try {
      log['raw_data_display'] =
          const JsonEncoder.withIndent('  ').convert(rawData);
    } catch (_) {
      log['raw_data_display'] = rawData.toString();
    }
  } else {
    log['raw_data_display'] = '(raw_dataなし)';
  }
  return log;
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
/// 作成日時, since 受信日時 here shows the same date+time granularity.
String _formatDateTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  final hh = jst.hour.toString().padLeft(2, '0');
  final min = jst.minute.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd $hh:$min';
}
