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

Future<dynamic> adminGetReportChatLog(String reportId) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetReportChatLog');
    final result = await callable.call({'report_id': reportId});
    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final messagesRaw = data['messages'];
    return ReportChatLogResultStruct.fromMap({
      'messages': (messagesRaw is List ? messagesRaw : [])
          .whereType<Map>()
          .map((m) => _toChatMessageItem(Map<String, dynamic>.from(m)))
          .toList(),
      'noChatReason': data['no_chat_reason']?.toString() ?? '',
    });
  } catch (e) {
    return ReportChatLogResultStruct.fromMap({
      'messages': <ChatMessageItemStruct>[],
      'noChatReason': 'チャットログの取得に失敗しました。',
    });
  }
}

ChatMessageItemStruct _toChatMessageItem(Map<String, dynamic> m) {
  final createdAt = _parseChatLogTimestamp(m['created_at']);
  return ChatMessageItemStruct.fromMap({
    'sender_nickname': m['sender_nickname']?.toString() ?? '',
    'text': m['text']?.toString() ?? '',
    'created_at_display':
        createdAt != null ? _formatChatLogDateTime(createdAt) : '',
  });
}

DateTime? _parseChatLogTimestamp(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    final seconds = value['_seconds'] ?? value['seconds'];
    if (seconds is num) {
      return DateTime.fromMillisecondsSinceEpoch((seconds * 1000).round(),
          isUtc: true);
    }
  }
  if (value is String) return DateTime.tryParse(value);
  return null;
}

String _formatChatLogDateTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  final hh = jst.hour.toString().padLeft(2, '0');
  final min = jst.minute.toString().padLeft(2, '0');
  return '${jst.year}/$mm/$dd $hh:$min';
}
