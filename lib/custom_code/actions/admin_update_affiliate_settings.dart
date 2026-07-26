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

Future<dynamic> adminUpdateAffiliateSettings(
  String defaultAffiliateRateOption,
  String affiliateMinDaysOption,
  String affiliatePaymentDayOption,
) async {
  try {
    final settings = <String, dynamic>{
      'default_affiliate_rate': _pct(defaultAffiliateRateOption),
      'affiliate_min_days': _day(affiliateMinDaysOption),
      'affiliate_payment_day': _day(affiliatePaymentDayOption),
    };
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateSystemConfig');
    final result = await callable.call({'settings': settings});
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

double? _pct(String raw) {
  final cleaned = raw.trim().replaceAll('%', '').trim();
  final value = double.tryParse(cleaned);
  return value == null ? null : value / 100;
}

int? _day(String raw) {
  final cleaned = raw.trim().replaceAll('日', '').trim();
  return int.tryParse(cleaned);
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
