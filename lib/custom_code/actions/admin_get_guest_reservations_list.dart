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

/// Thin wrapper around `adminGetReservations` for GuestUserdetailsPage's
/// 予約履歴/決済履歴 tabs: returns a List<ReservationHistoryItemStruct>
/// directly (not wrapped in `{success, reservations, count}`, and not a raw
/// List<Map> - the generated call site does a plain `.cast<...>()` on this
/// return value, which only re-checks an already-correct runtime type, it
/// does not itself parse Maps into struct instances) so it binds straight
/// to a ListView source. Reuses `adminGetReservations`'s own Cloud Function
/// call (one network round-trip, not two).
Future<dynamic> adminGetGuestReservationsList(String? guestId) async {
  try {
    final result =
        await adminGetReservations(null, null, null, 50, null, guestId);
    final data =
        result is Map ? Map<String, dynamic>.from(result) : <String, dynamic>{};
    final list = data['reservations'];
    if (list is! List) return <ReservationHistoryItemStruct>[];
    return list
        .whereType<Map>()
        .map((r) =>
            ReservationHistoryItemStruct.fromMap(Map<String, dynamic>.from(r)))
        .toList();
  } catch (e) {
    return <ReservationHistoryItemStruct>[];
  }
}
