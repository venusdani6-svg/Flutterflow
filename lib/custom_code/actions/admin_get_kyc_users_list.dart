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

Future<dynamic> adminGetKycUsersList(String? kycStatus) async {
  try {
    final result = await adminGetUsers(
      '',
      '',
      false,
      kycStatus ?? 'submitted',
      '',
      '',
      '',
      '',
      50,
      '',
      '',
      true,
    );
    final data =
        result is Map ? Map<String, dynamic>.from(result) : <String, dynamic>{};
    final list = data['users'];
    if (list is! List) return <KycUserItemStruct>[];
    // Undoes adminGetUsers's own online-first partition for this one
    // caller - see the client-feedback note above that action's own
    // updateCustomAction call. `created_at` is already the normalized
    // "YYYY. MM. DD" display string at this point, which sorts correctly
    // as plain text (zero-padded, most-significant field first).
    final sorted = list.whereType<Map>().toList()
      ..sort((a, b) {
        final aDate = a['created_at']?.toString() ?? '';
        final bDate = b['created_at']?.toString() ?? '';
        return bDate.compareTo(aDate);
      });
    return sorted
        .map((u) => KycUserItemStruct.fromMap(Map<String, dynamic>.from(u)))
        .toList();
  } catch (e) {
    return <KycUserItemStruct>[];
  }
}
