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

/// Reads `system_config/settings` directly (no Cloud Function — this
/// collection has an open `read: true` Firestore rule, see
/// firebase/firestore.rules) and returns it as raw JSON.
///
/// This bypasses `SystemConfigRecord` (lib/backend/schema/
/// system_config_record.dart) on purpose: that generated class only
/// models 4 of the ~16 real fields on this document, and types
/// `features_enabled` as a String when the live data is a Map — binding
/// this page directly to a native Firestore document query would silently
/// drop most fields and throw on that one. Use `$.` JSON paths against
/// this action's output instead (matching every other read on this page's
/// sibling admin pages), e.g. `$.tax_rate`, `$.chat_close_sec`,
/// `$.features_enabled.affiliate`, `$.cancel_fee_rates.guest_cancel.before`,
/// `$.service_areas[0].active`.
///
/// `night_time_slots` (e.g. `["3部","4部"]`) is pre-expanded into 4 plain
/// booleans (`night_slot_1`..`night_slot_4`) instead of being left as an
/// array: FlutterFlow's Conditional Value editor has no "list contains a
/// value" comparison (its value-editor popup only offers "To Data Type" /
/// "No Further Changes"), so checking array membership isn't buildable
/// there. Doing the `.contains(...)` check here means each of the 4
/// checkboxes on 基本設定 can just use a plain JSON Path binding
/// (`$.night_slot_1`, etc.) — the same simple pattern as every other field
/// on that tab, no Conditional Value needed.
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

    return {
      'success': true,
      ...data,
      'night_slot_1': nightSlots.contains('1部'),
      'night_slot_2': nightSlots.contains('2部'),
      'night_slot_3': nightSlots.contains('3部'),
      'night_slot_4': nightSlots.contains('4部'),
    };
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
