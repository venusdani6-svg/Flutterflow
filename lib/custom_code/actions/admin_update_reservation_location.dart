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

/// FlutterFlow parameters:
/// - resId (String) - the reservation's `id`.
/// - meetingPointAddress (String?) - pass null to leave unchanged.
/// - locationAddress (String?) - pass null to leave unchanged.
///
/// Lets admin staff manually record an address for the meeting point
/// and/or interaction location, since there's no guest-facing input for
/// either today (see `firebase/firestore/schema.md`'s Reservations
/// section).
Future<dynamic> adminUpdateReservationLocation(
  String resId,
  String? meetingPointAddress,
  String? locationAddress,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateReservationLocation');
    final result = await callable.call({
      'res_id': resId,
      'meeting_point_address': meetingPointAddress,
      'location_address': locationAddress,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
