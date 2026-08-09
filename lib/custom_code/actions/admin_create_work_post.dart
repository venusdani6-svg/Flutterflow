// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

Future<dynamic> adminCreateWorkPost(
  String? type,
  String? description,
  String? location,
  String? fee,
) async {
  try {
    final typeValue = switch (type) {
      '警備' => 'security',
      '送迎' => 'transport',
      _ => type,
    };
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminCreateWorkPost');
    final result = await callable.call({
      'type': typeValue,
      'description': description,
      'location': location,
      'fee': int.tryParse(fee ?? '') ?? 0,
    });
    final data = result.data is Map
        ? Map<String, dynamic>.from(result.data)
        : <String, dynamic>{};
    return WorkPostCreateResultStruct.fromMap({
      'success': data['success'] == true,
      'error': '',
      'postId': (data['post_id'] ?? '').toString(),
    });
  } catch (e) {
    return WorkPostCreateResultStruct.fromMap({
      'success': false,
      'error': e.toString(),
      'postId': '',
    });
  }
}
