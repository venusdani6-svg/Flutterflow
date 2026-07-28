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

/// FlutterFlow parameters:
/// - month (String?) optional — format YYYY-MM, defaults server-side to
///   the current month when omitted.
///
/// The deployed Cloud Function returns `summary` as a Map keyed by
/// affiliator uid (`{uid1: {total,pending,paid,forfeited,count}, ...}`),
/// which FlutterFlow's list-building can't iterate directly (no dynamic
/// keys). Reshaped here into a plain `rows` List, each entry carrying its
/// own `uid` field plus the 4 raw yen amounts and their `_display`
/// (`'1,234円'`) counterparts, sorted by `total` descending — same
/// precomputed-display-field convention as admin_get_system_config.dart.
/// This only reshapes the already-deployed function's response; it does
/// not call a different endpoint or change what's stored.
Future<dynamic> adminGetAffiliateOverview(String? month) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetAffiliateOverview');
    final result = await callable.call({
      'month': month,
    });
    final data = result.data;
    final summary = data is Map && data['summary'] is Map
        ? Map<String, dynamic>.from(data['summary'] as Map)
        : <String, dynamic>{};

    final rows = summary.entries.map((entry) {
      final stats = entry.value is Map
          ? Map<String, dynamic>.from(entry.value as Map)
          : <String, dynamic>{};
      final total = (stats['total'] as num?) ?? 0;
      final pending = (stats['pending'] as num?) ?? 0;
      final paid = (stats['paid'] as num?) ?? 0;
      final forfeited = (stats['forfeited'] as num?) ?? 0;
      final count = (stats['count'] as num?) ?? 0;
      return {
        'uid': entry.key,
        'total': total,
        'total_display': _fmtYen(total),
        'pending': pending,
        'pending_display': _fmtYen(pending),
        'paid': paid,
        'paid_display': _fmtYen(paid),
        'forfeited': forfeited,
        'forfeited_display': _fmtYen(forfeited),
        'count': count,
      };
    }).toList()
      ..sort((a, b) => (b['total'] as num).compareTo(a['total'] as num));

    return {
      'success': data is Map ? (data['success'] ?? true) : true,
      'month': data is Map ? data['month'] : month,
      'rows': rows,
    };
  } catch (e) {
    return {'success': false, 'error': e.toString(), 'rows': <dynamic>[]};
  }
}

String _fmtYen(num raw) {
  final s = raw.round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return '$buf円';
}
