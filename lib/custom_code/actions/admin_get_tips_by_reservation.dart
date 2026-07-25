// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// FlutterFlow parameters:
/// - resId (String) - the reservation's `id`, used to filter `ledger`
///   entries where `res_id == resId` and `type == "tip"`.
///
/// Wraps `adminGetLedger` (rather than calling the Cloud Function directly)
/// so the res_id/type filtering and composite index stay defined in one
/// place. Sums `amount` across all matching entries (normally 0 or 1, but
/// summed defensively in case of multiple tip line items) and returns a
/// ready-to-bind shape for the reservation-detail page's チップ有無/
/// チップ総額 fields, per project_rules.md's requirement that reservation
/// detail must show a tip line.
Future<dynamic> adminGetTipsByReservation(String resId) async {
  try {
    final ledgerResult =
        await adminGetLedger(null, 'tip', null, 100, resId, null, null);
    final data = ledgerResult is Map
        ? Map<String, dynamic>.from(ledgerResult as Map)
        : <String, dynamic>{};
    final entriesRaw = data['entries'];
    final entries = entriesRaw is List ? entriesRaw : const [];

    num tipTotal = 0;
    for (final entry in entries) {
      if (entry is Map && entry['amount'] is num) {
        tipTotal += entry['amount'] as num;
      }
    }

    return {
      'success': true,
      'hasTip': tipTotal > 0,
      'tipTotal': tipTotal,
      'tipPresenceLabel': tipTotal > 0 ? '有り' : '無し',
    };
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
