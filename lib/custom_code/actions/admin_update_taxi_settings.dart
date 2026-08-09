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

Future<dynamic> adminUpdateTaxiSettings(
  String transportFeeAmountText,
  String transportFeeThresholdSecText,
) async {
  try {
    final transportFeeAmount = int.tryParse(transportFeeAmountText.trim());
    final transportFeeThresholdSec =
        int.tryParse(transportFeeThresholdSecText.trim());
    if (transportFeeAmount == null || transportFeeThresholdSec == null) {
      return {
        'success': false,
        'error':
            '金額と閾値は数値で入力してください。（現在の入力: "$transportFeeAmountText" / "$transportFeeThresholdSecText"）',
      };
    }

    final settings = <String, dynamic>{
      'transport_fee_amount': transportFeeAmount,
      'transport_fee_threshold_sec': transportFeeThresholdSec,
    };
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateSystemConfig');
    final result = await callable.call({'settings': settings});
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
