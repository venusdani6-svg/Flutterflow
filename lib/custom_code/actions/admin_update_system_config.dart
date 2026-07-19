// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';

/// FlutterFlow parameters:
/// - settingsJson (String) required
///   Pass a JSON object string for one settings tab, e.g.
///   {"tax_rate":0.1,"features_enabled":{"cocoten":false}}
Future<dynamic> adminUpdateSystemConfig(String settingsJson) async {
  try {
    final decoded = jsonDecode(settingsJson);
    if (decoded is! Map) {
      return {
        'success': false,
        'error': 'settingsJson must be a JSON object string',
      };
    }
    final settings = Map<String, dynamic>.from(decoded);

    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateSystemConfig');
    final result = await callable.call({
      'settings': settings,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
