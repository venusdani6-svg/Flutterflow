// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

/// FlutterFlow parameters (all optional):
/// - userId (String?)
/// - type (String?)
/// - status (String?)
/// - limit (int?)
Future<dynamic> adminGetLedger(
  String? userId,
  String? type,
  String? status,
  int? limit,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetLedger');
    final result = await callable.call({
      'user_id': userId,
      'type': type,
      'status': status,
      'limit': limit ?? 100,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
