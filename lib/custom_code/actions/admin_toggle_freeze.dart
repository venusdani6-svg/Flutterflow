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
/// - freeze (bool) required
/// - reason (String?) optional
Future<dynamic> adminToggleFreeze(
  String userId,
  bool freeze,
  String? reason,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminToggleFreeze');
    final result = await callable.call({
      'user_id': userId,
      'freeze': freeze,
      'reason': reason,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
