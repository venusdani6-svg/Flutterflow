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

Future<dynamic> adminGetAffiliateOverview(String? month) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetAffiliateOverview');
    final result = await callable.call({
      'month': month,
    });
    final data = result.data;
    if (data is! Map || data['success'] != true) {
      return {
        'success': false,
        'error':
            data is Map ? (data['error'] ?? 'unknown error') : 'unknown error',
        'rewards': <dynamic>[],
        'affiliators': <dynamic>[],
      };
    }

    final rewardsRaw = data['rewards'] is List ? data['rewards'] as List : [];
    final affiliatorsRaw =
        data['affiliators'] is List ? data['affiliators'] as List : [];

    final rewards = rewardsRaw.map((raw) {
      final r = Map<String, dynamic>.from(raw as Map);
      final amount = (r['reward_amount'] as num?) ?? 0;
      return {
        ...r,
        'reward_amount_display': _fmtYen(amount),
        'paid_at_display': _fmtDate(r['paid_at'] as String?),
      };
    }).toList();

    final affiliators = affiliatorsRaw.map((raw) {
      final a = Map<String, dynamic>.from(raw as Map);
      final currentMonth = (a['current_month_reward'] as num?) ?? 0;
      final cumulative = (a['cumulative_paid'] as num?) ?? 0;
      final rate = (a['affiliate_rate'] as num?) ?? 0;
      return {
        ...a,
        'current_month_reward_display': _fmtYen(currentMonth),
        'cumulative_paid_display': _fmtYen(cumulative),
        'affiliate_rate_display': '${(rate * 100).round()}',
        'created_at_display': _fmtDate(a['created_at'] as String?),
      };
    }).toList();

    return {
      'success': true,
      'month': data['month'],
      'rewards': rewards,
      'affiliators': affiliators,
    };
  } catch (e) {
    return {
      'success': false,
      'error': e.toString(),
      'rewards': <dynamic>[],
      'affiliators': <dynamic>[],
    };
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

String _fmtDate(String? iso) {
  if (iso == null) return 'なし';
  final dt = DateTime.tryParse(iso);
  if (dt == null) return 'なし';
  final local = dt.toLocal();
  final mm = local.month.toString().padLeft(2, '0');
  final dd = local.day.toString().padLeft(2, '0');
  final hh = local.hour.toString().padLeft(2, '0');
  final min = local.minute.toString().padLeft(2, '0');
  return '${local.year}. $mm. $dd $hh:$min';
}
