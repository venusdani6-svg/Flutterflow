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
/// - userId (String) required — the affiliator's uid, from 報酬率設定 tab's
///   selected-affiliator Page State (set by tapping a row on アフィリエイター一覧).
/// - newRateOption (String) required — the raw dropdown option text, e.g.
///   '5　％' (note: full-width space + full-width '％', not '%' — this
///   project's タクシー代設定/基本設定 tabs already established the pattern of
///   parsing raw field text in the Dart action rather than trusting
///   FlutterFlow's implicit cast; same reasoning here, plus the full-width
///   characters wouldn't survive a naive `.replaceAll('%', '')` anyway).
/// Validates both before calling — an empty userId (nothing selected on the
/// picker tab) or an unparseable rate returns a clean error instead of
/// either crashing or silently calling the Cloud Function with bad data;
/// the Cloud Function itself re-validates the 5%-30%-in-5%-steps range
/// server-side regardless.
Future<dynamic> adminUpdateAffiliateRate(
  String userId,
  String newRateOption,
) async {
  try {
    if (userId.trim().isEmpty) {
      return {
        'success': false,
        'error': 'アフィリエイターが選択されていません。アフィリエイター一覧タブで対象を選択してください。',
      };
    }
    final newRate = _pct(newRateOption);
    if (newRate == null) {
      return {
        'success': false,
        'error': '報酬率を選択してください。（現在の入力: "$newRateOption"）',
      };
    }

    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateAffiliateRate');
    final result = await callable.call({
      'user_id': userId,
      'new_rate': newRate,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

double? _pct(String raw) {
  final digitsOnly = raw.replaceAll(RegExp(r'[^0-9.]'), '');
  final value = double.tryParse(digitsOnly);
  return value == null ? null : value / 100;
}
