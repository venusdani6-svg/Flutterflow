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
/// - accountType (String?)
/// - approvalStatus (String?)
/// - isFrozen (bool?)
/// - limit (int?)
/// - offset (String?)
Future<dynamic> adminGetUsers(
  String? accountType,
  String? approvalStatus,
  bool? isFrozen,
  int? limit,
  String? offset,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetUsers');
    final result = await callable.call({
      'account_type': accountType,
      'approval_status': approvalStatus,
      'is_frozen': isFrozen,
      'limit': limit ?? 50,
      'offset': offset,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
