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
/// - userIds (List<String>) required — the checked rows' ids (selectedIds)
/// - freeze (bool) required — true = bulk freeze, false = bulk unfreeze
///
/// FlutterFlow's Action Flow Editor here has no "for each list item" action,
/// so the loop happens in Dart instead: this calls the existing single-user
/// `adminToggleFreeze` callable once per id. No backend changes needed.
Future<dynamic> adminBulkToggleFreeze(
  List<String>? userIds,
  bool freeze,
) async {
  final ids = userIds ?? [];
  final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
  final callable = functions.httpsCallable('adminToggleFreeze');
  var successCount = 0;
  final errors = <String>[];

  for (final id in ids) {
    try {
      await callable.call({'user_id': id, 'freeze': freeze, 'reason': null});
      successCount++;
    } catch (e) {
      errors.add('$id: ${e.toString()}');
    }
  }

  return {
    'success': errors.isEmpty,
    'successCount': successCount,
    'totalCount': ids.length,
    'errors': errors,
  };
}
