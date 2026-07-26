// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> adminGetSystemConfig() async {
  try {
    final snap = await FirebaseFirestore.instance
        .collection('system_config')
        .doc('settings')
        .get();

    if (!snap.exists || snap.data() == null) {
      return {'success': false, 'error': 'system_config/settings not found'};
    }

    final data = snap.data()!;
    final nightSlots = data['night_time_slots'] is List
        ? List<String>.from(data['night_time_slots'] as List)
        : <String>[];
    final cancelFeeRates = data['cancel_fee_rates'] is Map
        ? Map<String, dynamic>.from(data['cancel_fee_rates'] as Map)
        : <String, dynamic>{};

    return {
      'success': true,
      ...data,
      'night_slot_1': nightSlots.contains('1部'),
      'night_slot_2': nightSlots.contains('2部'),
      'night_slot_3': nightSlots.contains('3部'),
      'night_slot_4': nightSlots.contains('4部'),
      'default_cast_rate_display': _fmtPct(data['default_cast_rate']),
      'security_staff_fee_display': _fmtYen(data['security_staff_fee']),
      'transport_staff_fee_display': _fmtYen(data['transport_staff_fee']),
      'cancel_general_rate_display':
          _fmtPct(cancelFeeRates['cast_reward_rate']),
    };
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

String? _fmtPct(dynamic raw) {
  if (raw is! num) return null;
  return '${(raw * 100).round()} %';
}

String? _fmtYen(dynamic raw) {
  if (raw is! num) return null;
  final s = raw.round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return '$buf円';
}
