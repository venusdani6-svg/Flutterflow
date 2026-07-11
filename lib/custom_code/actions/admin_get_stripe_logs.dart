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
/// - resId (String?)
/// - eventType (String?)
/// - limit (int?)
/// - startDate (String?) ISO date — reserved for future backend support
/// - endDate (String?) ISO date — reserved for future backend support
Future<dynamic> adminGetStripeLogs(
  String? resId,
  String? eventType,
  int? limit,
  String? startDate,
  String? endDate,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetStripeLogs');
    final result = await callable.call({
      'res_id': resId,
      'event_type': eventType,
      'limit': limit ?? 50,
      'start_date': startDate,
      'end_date': endDate,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
