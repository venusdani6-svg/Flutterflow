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
    final data = result.data;
    if (data is Map && data['success'] == true) {
      return {
        ...Map<String, dynamic>.from(data),
        'updatedRateDisplay': '${(newRate * 100).round()}',
      };
    }
    return data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

double? _pct(String raw) {
  final digitsOnly = raw.replaceAll(RegExp(r'[^0-9.]'), '');
  final value = double.tryParse(digitsOnly);
  return value == null ? null : value / 100;
}
