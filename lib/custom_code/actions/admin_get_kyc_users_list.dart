// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
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
    return list
        .whereType<Map>()
        .map((u) => KycUserItemStruct.fromMap(Map<String, dynamic>.from(u)))
        .toList();
  } catch (e) {
    return <KycUserItemStruct>[];
  }
}
