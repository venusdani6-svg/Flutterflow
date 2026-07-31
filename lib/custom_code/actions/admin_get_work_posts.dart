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

Future<dynamic> adminGetWorkPosts(String? status) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetWorkPosts');
    final result = await callable.call({'status': status, 'limit': 100});
    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final postsRaw = data['posts'];
    if (postsRaw is! List) return <WorkPostItemStruct>[];
    return postsRaw
        .whereType<Map>()
        .map((p) => _toWorkPostItem(Map<String, dynamic>.from(p)))
        .toList();
  } catch (e) {
    return <WorkPostItemStruct>[];
  }
}

WorkPostItemStruct _toWorkPostItem(Map<String, dynamic> p) {
  final workDate = _parseWorkPostTimestamp(p['date']);
  final createdAt = _parseWorkPostTimestamp(p['created_at']);
  final applicants = p['applicants'];
  final applicantCount = applicants is List ? applicants.length : 0;
  final status = p['status']?.toString() ?? '';
  return WorkPostItemStruct.fromMap({
    'id': p['id']?.toString() ?? '',
    'poster_nickname': p['poster_nickname']?.toString() ?? '',
    'type_label': _workPostTypeLabel(p['type']),
    'description': p['description']?.toString() ?? '',
    'work_date': workDate != null ? _formatWorkPostDateTime(workDate) : '',
    'created_at': createdAt != null ? _formatWorkPostDateTime(createdAt) : '',
    'applicant_count': '$applicantCount',
    'status_label': _workPostStatusLabel(status),
    'status': status,
  });
}

DateTime? _parseWorkPostTimestamp(dynamic value) {
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

String _formatWorkPostDateTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  final hh = jst.hour.toString().padLeft(2, '0');
  final min = jst.minute.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd $hh:$min';
}

/// Values from schema.md §20 (WorkPosts), confirmed against the real
/// reservations.ts write ("partner_recruit" seen live).
String _workPostTypeLabel(dynamic type) {
  switch (type) {
    case 'partner_recruit':
      return 'グループお誘い';
    case 'security':
      return '警備';
    case 'transport':
      return '送迎';
    default:
      return type?.toString() ?? '不明';
  }
}

String _workPostStatusLabel(dynamic status) {
  switch (status) {
    case 'open':
      return '募集中';
    case 'filled':
      return '採用済み';
    case 'closed':
      return '終了';
    default:
      return status?.toString() ?? '不明';
  }
}
