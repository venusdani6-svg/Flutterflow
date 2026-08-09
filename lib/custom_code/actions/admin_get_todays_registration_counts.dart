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

Future<dynamic> adminGetTodaysRegistrationCounts() async {
  try {
    final nowUtc = DateTime.now().toUtc();
    final nowJst = nowUtc.add(const Duration(hours: 9));
    final todayJstMidnightFields =
        DateTime.utc(nowJst.year, nowJst.month, nowJst.day);
    final todayStartUtc =
        todayJstMidnightFields.subtract(const Duration(hours: 9));
    final createdAfter = todayStartUtc.toIso8601String();

    final result = await adminGetUsers(
      '',
      '',
      false,
      '',
      '',
      createdAfter,
      '',
      '',
      500,
      '',
      '',
      true,
    );
    final data =
        result is Map ? Map<String, dynamic>.from(result) : <String, dynamic>{};
    final usersRaw = data['users'];
    final users = usersRaw is List
        ? usersRaw
            .whereType<Map>()
            .map((u) => Map<String, dynamic>.from(u))
            .toList()
        : <Map<String, dynamic>>[];

    var guestCount = 0;
    var castCount = 0;
    var staffCount = 0;
    var adminCount = 0;
    for (final u in users) {
      final role = u['role']?.toString() ?? '';
      final accountType = u['account_type']?.toString() ?? '';
      if (role == 'admin') {
        adminCount++;
      } else if (accountType == 'guest') {
        guestCount++;
      } else if (accountType == 'cast') {
        if (_isStaffTypeForRegCounts(u['staff_type'])) {
          staffCount++;
        } else {
          castCount++;
        }
      }
    }

    return TodaysRegistrationCountsStruct.fromMap({
      'guest_count': '$guestCount',
      'cast_count': '$castCount',
      'staff_count': '$staffCount',
      'admin_count': '$adminCount',
    });
  } catch (e) {
    return TodaysRegistrationCountsStruct.fromMap({
      'guest_count': '0',
      'cast_count': '0',
      'staff_count': '0',
      'admin_count': '0',
    });
  }
}

bool _isStaffTypeForRegCounts(dynamic value) {
  final s = value?.toString() ?? '';
  return s.isNotEmpty && s != 'none';
}
