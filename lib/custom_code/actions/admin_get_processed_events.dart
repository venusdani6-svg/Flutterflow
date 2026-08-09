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

Future<dynamic> adminGetProcessedEvents(String? eventType) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetProcessedEvents');
    final result = await callable.call({
      'eventType': eventType,
      'limit': 100,
    });
    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final eventsRaw = data['events'];
    if (eventsRaw is! List) return <ProcessedEventItemStruct>[];
    return eventsRaw
        .whereType<Map>()
        .map((e) => _toProcessedEventItem(Map<String, dynamic>.from(e)))
        .toList();
  } catch (e) {
    return <ProcessedEventItemStruct>[];
  }
}

ProcessedEventItemStruct _toProcessedEventItem(Map<String, dynamic> event) {
  final processedAt = _parseProcessedEventTimestamp(event['processed_at']);
  return ProcessedEventItemStruct.fromMap({
    'id': event['id']?.toString() ?? '',
    'event_type': event['event_type']?.toString() ?? '',
    'processed_at':
        processedAt != null ? _formatProcessedEventDateTime(processedAt) : '',
  });
}

DateTime? _parseProcessedEventTimestamp(dynamic value) {
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

String _formatProcessedEventDateTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  final hh = jst.hour.toString().padLeft(2, '0');
  final min = jst.minute.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd $hh:$min';
}
