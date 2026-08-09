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

Future<List<AdminActivityLogItemStruct>> adminGetUserActivityLog(
  String targetUserId,
) async {
  final logs = await adminGetAuditLogs(null, null, null);
  if (logs is! List) return [];
  return logs
      .whereType<AuditLogItemStruct>()
      .where((l) => l.targetId == targetUserId)
      .map((l) => AdminActivityLogItemStruct.fromMap({
            'actionLabel': l.actionLabel,
            'reasonDisplay': l.reasonDisplay,
            'createdAt': l.createdAt,
          }))
      .toList();
}
