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

/// FlutterFlow parameters (all optional):
/// - status (String?) - one of the 11 documented reservation statuses
///   (see `firebase/firestore/schema.md`): request_pending / authorized /
///   cast_pending / confirmed / waiting / in_progress / completion_pending /
///   review_pending / completed / cancelled / expired.
/// - scheduledAfter / scheduledBefore (String?) - ISO date strings; filters
///   on the reservation's actual `scheduled_at` date/time (not
///   `created_at` — this collection's live Firestore indexes are built
///   around `scheduled_at`, so filtering/sorting matches that).
/// - limit (int?)
/// - offset (String?) - cursor-based pagination; pass the last reservation
///   id from the previous page to continue.
/// - guestId (String?) - filters to one guest's own reservations (used by
///   GuestUserdetailsPage's 予約履歴/決済履歴 tabs). Only one of
///   status/guestId should be supplied per call - combining both would need
///   a status+guest_id+scheduled_at composite index that doesn't exist.
///
/// Normalizes each reservation so list-page JSON Path bindings get
/// display-ready values instead of raw Firestore Timestamp maps
/// ({_seconds, _nanoseconds}). Unlike adminGetUsers's kyc_status handling,
/// this keeps the raw `status` value intact and adds a separate
/// `status_label` field, since the list/modal UI may need the raw enum
/// value for conditional logic (e.g. hiding a "force cancel" action once
/// status is already `completed`/`cancelled`) in addition to the Japanese
/// display label.
///
/// Also adds `primary_cast_id`, the first entry of `cast_ids` (or null),
/// since the row template shows one cast per row and binding directly to
/// `cast_ids` renders the array's bracketed string form (e.g. "[abc123]").
/// `primary_cast_nickname`/`secondary_cast_nickname` are the equivalent
/// derived fields for the backend's `cast_nicknames` array (parallel to
/// `cast_ids`, added server-side in `admin.ts`).
Future<dynamic> adminGetReservations(
  String? status,
  String? scheduledAfter,
  String? scheduledBefore,
  int? limit,
  String? offset,
  String? guestId,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetReservations');
    final result = await callable.call({
      'status': status,
      'scheduled_after': scheduledAfter,
      'scheduled_before': scheduledBefore,
      'limit': limit ?? 50,
      'offset': offset,
      'guest_id': guestId,
    });

    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final reservationsRaw = data['reservations'];
    if (reservationsRaw is List) {
      data['reservations'] = reservationsRaw.map((r) {
        if (r is! Map) return r;
        try {
          return _normalizeReservation(Map<String, dynamic>.from(r));
        } catch (_) {
          return r;
        }
      }).toList();
    }
    return data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

Map<String, dynamic> _normalizeReservation(Map<String, dynamic> reservation) {
  final castIds = reservation['cast_ids'];
  reservation['primary_cast_id'] =
      (castIds is List && castIds.isNotEmpty) ? castIds.first.toString() : null;
  reservation['secondary_cast_id'] =
      (castIds is List && castIds.length > 1) ? castIds[1].toString() : null;
  final castNicknames = reservation['cast_nicknames'];
  reservation['primary_cast_nickname'] =
      (castNicknames is List && castNicknames.isNotEmpty)
          ? castNicknames.first.toString()
          : null;
  reservation['secondary_cast_nickname'] =
      (castNicknames is List && castNicknames.length > 1)
          ? castNicknames[1].toString()
          : null;
  final staffIds = reservation['staff_ids'];
  reservation['primary_staff_id'] = (staffIds is List && staffIds.isNotEmpty)
      ? staffIds.first.toString()
      : null;
  final totalHours = reservation['total_hours'];
  final durationMinutes = reservation['duration_minutes'];
  if (totalHours is num && durationMinutes is num) {
    reservation['extension_minutes'] =
        (totalHours * 60 - durationMinutes).round();
  }
  reservation['cancelled_by_label'] =
      _cancelledByLabel(reservation['cancelled_by']);
  reservation['group_invite_label'] =
      reservation['group_invite'] == true ? '有り' : '無し';
  reservation['thirty_min_rule_applied_label'] =
      reservation['thirty_min_rule_applied'] == true ? '有り' : '無し';
  final date = _parseTimestamp(reservation['date']);
  final scheduledAt = _parseTimestamp(reservation['scheduled_at']);
  final createdAt = _parseTimestamp(reservation['created_at']);
  final updatedAt = _parseTimestamp(reservation['updated_at']);
  final lastCaptureAt = _parseTimestamp(reservation['last_capture_at']);
  // Guest detail page's 予約履歴 tab shows a 時間帯 (time_slot, e.g. "1部")
  // alongside a derived clock-time range - there's no stored range field in
  // schema.md, so it's computed from `date` (the reservation's start
  // moment) + `duration_minutes`, both real stored fields.
  reservation['time_range'] = _formatTimeRange(date, durationMinutes);
  if (date != null) {
    reservation['date'] = _formatDate(date);
    reservation['date_time'] = _formatTime(date);
  }
  if (scheduledAt != null) {
    reservation['scheduled_at'] = _formatDate(scheduledAt);
    reservation['scheduled_at_time'] = _formatTime(scheduledAt);
  }
  if (createdAt != null) {
    reservation['created_at'] = _formatDate(createdAt);
    reservation['created_at_time'] = _formatTime(createdAt);
  }
  if (updatedAt != null) {
    reservation['updated_at'] = _formatDate(updatedAt);
  }
  if (lastCaptureAt != null) {
    reservation['last_capture_at'] = _formatDate(lastCaptureAt);
    reservation['last_capture_at_time'] = _formatTime(lastCaptureAt);
  }
  reservation['status_label'] = _statusLabel(reservation['status']);
  // Guest detail page's 決済履歴 tab shows a formatted "4,400円" style
  // amount; comma-grouped here rather than fought over in the FlutterFlow
  // builder's limited text-formatting options.
  reservation['total_amount_display'] =
      _formatCurrency(reservation['total_amount']);
  return reservation;
}

/// Accepts a Firestore Timestamp serialized as {_seconds, _nanoseconds}
/// (the shape actually returned by the callable Cloud Function) or an
/// ISO date string, and returns a DateTime in UTC.
DateTime? _parseTimestamp(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    final seconds = value['_seconds'] ?? value['seconds'];
    if (seconds is num) {
      return DateTime.fromMillisecondsSinceEpoch(
        (seconds * 1000).round(),
        isUtc: true,
      );
    }
  }
  if (value is String) {
    return DateTime.tryParse(value);
  }
  return null;
}

/// "2026. 07. 17" style, matching the same format used across the admin
/// list pages. Shifted to JST since this is a Japan-only business.
String _formatDate(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final mm = jst.month.toString().padLeft(2, '0');
  final dd = jst.day.toString().padLeft(2, '0');
  return '${jst.year}. $mm. $dd';
}

/// "15:16" style, JST.
String _formatTime(DateTime utc) {
  final jst = utc.add(const Duration(hours: 9));
  final hh = jst.hour.toString().padLeft(2, '0');
  final mm = jst.minute.toString().padLeft(2, '0');
  return '$hh:$mm';
}

/// "17:00 ~ 20:00" style, JST. Derived from the reservation's start moment
/// plus its planned duration - there's no separate stored end-time field.
String? _formatTimeRange(DateTime? utcStart, dynamic durationMinutes) {
  if (utcStart == null || durationMinutes is! num) return null;
  final startJst = utcStart.add(const Duration(hours: 9));
  final endJst = startJst.add(Duration(minutes: durationMinutes.round()));
  String fmt(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  return '${fmt(startJst)} ~ ${fmt(endJst)}';
}

/// "4,400円" style. Returns null (rather than "0円") when the amount is
/// missing/non-numeric so the UI can fall back to its own placeholder.
String? _formatCurrency(dynamic amount) {
  if (amount is! num) return null;
  final intAmount = amount.round();
  final digits = intAmount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  final sign = intAmount < 0 ? '-' : '';
  return '$sign${buffer.toString()}円';
}

/// Japanese labels for the 11 statuses documented in
/// `firebase/firestore/schema.md`. Falls back to the raw value itself for
/// anything unrecognized (e.g. seed/test data using a placeholder status
/// not in the documented enum) rather than a generic "unknown" label, so a
/// data quality issue stays visible instead of being silently masked.
String _statusLabel(dynamic status) {
  switch (status) {
    case 'request_pending':
      return 'リクエスト中';
    case 'authorized':
      return '与信確保済み';
    case 'cast_pending':
      return 'キャスト承諾待ち';
    case 'confirmed':
      return '確定決済済';
    case 'waiting':
      return '合流待ち';
    case 'in_progress':
      return '交流中';
    case 'completion_pending':
      return '完了報告待ち';
    case 'review_pending':
      return '評価待ち';
    case 'completed':
      return '完了';
    case 'cancelled':
      return 'キャンセル';
    case 'expired':
      return '期限切れ';
    default:
      return status?.toString() ?? '不明';
  }
}

/// Japanese labels for the `cancelled_by` enum documented in
/// `firebase/firestore/schema.md` ("guest" / "cast" / "admin"). Returns null
/// when there's no cancellation, so the details page can leave the field
/// blank instead of showing a placeholder label.
String? _cancelledByLabel(dynamic cancelledBy) {
  switch (cancelledBy) {
    case 'guest':
      return 'ゲスト';
    case 'cast':
      return 'キャスト';
    case 'admin':
      return '管理者';
    default:
      return null;
  }
}
