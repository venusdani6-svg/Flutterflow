// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

/// FlutterFlow parameters:
/// - userId (String) required
/// - reason (String?) optional
Future<dynamic> adminForceDeleteUser(
  String userId,
  String? reason,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminForceDeleteUser');
    final result = await callable.call({
      'user_id': userId,
      'reason': reason,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
