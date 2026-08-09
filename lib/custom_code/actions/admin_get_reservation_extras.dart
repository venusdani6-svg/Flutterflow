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

Future<dynamic> adminGetReservationExtras(String resId) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetReservationExtras');
    final result = await callable.call({'res_id': resId});
    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final extensionsRaw = data['extensions'];
    final rewardsRaw = data['rewards'];
    return ReservationExtrasResultStruct.fromMap({
      'extensions': (extensionsRaw is List ? extensionsRaw : [])
          .whereType<Map>()
          .map((e) => _toExtensionPaymentItem(Map<String, dynamic>.from(e)))
          .toList(),
      'rewards': (rewardsRaw is List ? rewardsRaw : [])
          .whereType<Map>()
          .map((r) => _toCastRewardItem(Map<String, dynamic>.from(r)))
          .toList(),
    });
  } catch (e) {
    return ReservationExtrasResultStruct.fromMap({
      'extensions': <ExtensionPaymentItemStruct>[],
      'rewards': <CastRewardItemStruct>[],
    });
  }
}

ExtensionPaymentItemStruct _toExtensionPaymentItem(Map<String, dynamic> e) {
  const statusLabels = {
    'authorized': '与信確保済み',
    'captured': '確定済み',
    'cancelled': 'キャンセル済み',
  };
  final status = e['status']?.toString() ?? '';
  final amount = e['amount'] is num ? (e['amount'] as num).toInt() : 0;
  final minutes =
      e['duration_minutes'] is num ? (e['duration_minutes'] as num).toInt() : 0;
  final createdAt = _parseReservationExtrasTimestamp(e['created_at']);
  return ExtensionPaymentItemStruct.fromMap({
    'id': e['id']?.toString() ?? '',
    'amount_display': '¥$amount',
    'duration_minutes_display': '$minutes分',
    'status_label': statusLabels[status] ?? status,
    'created_at_display':
        createdAt != null ? _formatReservationExtrasDateTime(createdAt) : '',
  });
}

CastRewardItemStruct _toCastRewardItem(Map<String, dynamic> r) {
  const statusLabels = {
    'pending': '処理中',
    'confirmed': '送金済み',
    'retrying': '再試行中',
    'failed': '失敗',
  };
  final status = r['status']?.toString() ?? '';
  final netTransfer =
      r['net_transfer'] is num ? (r['net_transfer'] as num).toInt() : 0;
  return CastRewardItemStruct.fromMap({
    'cast_id': r['user_id']?.toString() ?? '',
    'cast_nickname': r['cast_nickname']?.toString() ?? '',
    'amount_display': '¥$netTransfer',
    'status_label': statusLabels[status] ?? status,
  });
}

DateTime? _parseReservationExtrasTimestamp(dynamic value) {
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

String _formatReservationExtrasDateTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  final hh = jst.hour.toString().padLeft(2, '0');
  final min = jst.minute.toString().padLeft(2, '0');
  return '${jst.year}/$mm/$dd $hh:$min';
}
