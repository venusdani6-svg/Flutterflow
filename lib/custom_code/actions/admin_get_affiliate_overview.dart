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
/// - month (String?) optional — format YYYY-MM
Future<dynamic> adminGetAffiliateOverview(String? month) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetAffiliateOverview');
    final result = await callable.call({
      'month': month,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
