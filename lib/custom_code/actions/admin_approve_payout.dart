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
/// - userId (String) required
/// - action (String?) optional — e.g. approve / on_hold / rejected (future)
Future<dynamic> adminApprovePayout(
  String userId,
  String? action,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminApprovePayout');
    final result = await callable.call({
      'user_id': userId,
      'action': action ?? 'approve',
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
