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
Future<dynamic> adminGetReservations(
  String? status,
  String? scheduledAfter,
  String? scheduledBefore,
  int? limit,
  String? offset,
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
  }
  if (updatedAt != null) {
    reservation['updated_at'] = _formatDate(updatedAt);
  }
  if (lastCaptureAt != null) {
    reservation['last_capture_at'] = _formatDate(lastCaptureAt);
  }
  reservation['status_label'] = _statusLabel(reservation['status']);
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
