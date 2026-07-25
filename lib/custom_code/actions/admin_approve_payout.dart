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
/// - requestId (String) required — the payout_requests document id.
/// - action (String?) — 'approve' (default, pays out via Stripe and marks
///   the request approved) / 'on_hold' / 'rejected' (both just update the
///   request's status, no money moves).
Future<dynamic> adminApprovePayout(
  String requestId,
  String? action,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminApprovePayout');
    final result = await callable.call({
      'requestId': requestId,
      'action': action ?? 'approve',
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
