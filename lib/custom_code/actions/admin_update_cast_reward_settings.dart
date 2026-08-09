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

Future<dynamic> adminUpdateCastRewardSettings(
  String defaultCastRateOption,
  String securityStaffFeeOption,
  String transportStaffFeeOption,
  String cancelGeneralRateOption,
) async {
  try {
    final settings = <String, dynamic>{
      'default_cast_rate': _pct(defaultCastRateOption),
      'security_staff_fee': _yen(securityStaffFeeOption),
      'transport_staff_fee': _yen(transportStaffFeeOption),
      'cancel_fee_rates': {
        'cast_reward_rate': _pct(cancelGeneralRateOption),
      },
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

int? _yen(String raw) {
  final cleaned = raw.trim().replaceAll('円', '').replaceAll(',', '').trim();
  return int.tryParse(cleaned);
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
