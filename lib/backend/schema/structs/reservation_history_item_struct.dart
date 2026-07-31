// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// Display-ready reservation fields for GuestUserdetailsPage's 予約履歴/決済履歴
/// tabs.
class ReservationHistoryItemStruct extends FFFirebaseStruct {
  ReservationHistoryItemStruct({
    /// ReservationHistoryItem.primary_cast_nickname
    String? primaryCastNickname,

    /// ReservationHistoryItem.status_label
    String? statusLabel,

    /// ReservationHistoryItem.total_amount_display
    String? totalAmountDisplay,

    /// ReservationHistoryItem.created_at
    String? createdAt,

    /// ReservationHistoryItem.created_at_time
    String? createdAtTime,

    /// ReservationHistoryItem.scheduled_at
    String? scheduledAt,

    /// ReservationHistoryItem.time_slot
    String? timeSlot,

    /// ReservationHistoryItem.time_range
    String? timeRange,

    /// ReservationHistoryItem.group_invite_label
    String? groupInviteLabel,

    /// ReservationHistoryItem.last_capture_at
    String? lastCaptureAt,

    /// ReservationHistoryItem.last_capture_at_time
    String? lastCaptureAtTime,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _primaryCastNickname = primaryCastNickname,
        _statusLabel = statusLabel,
        _totalAmountDisplay = totalAmountDisplay,
        _createdAt = createdAt,
        _createdAtTime = createdAtTime,
        _scheduledAt = scheduledAt,
        _timeSlot = timeSlot,
        _timeRange = timeRange,
        _groupInviteLabel = groupInviteLabel,
        _lastCaptureAt = lastCaptureAt,
        _lastCaptureAtTime = lastCaptureAtTime,
        super(firestoreUtilData);

  // "primary_cast_nickname" field.
  String? _primaryCastNickname;
  String get primaryCastNickname => _primaryCastNickname ?? '';
  set primaryCastNickname(String? val) => _primaryCastNickname = val;

  bool hasPrimaryCastNickname() => _primaryCastNickname != null;

  // "status_label" field.
  String? _statusLabel;
  String get statusLabel => _statusLabel ?? '';
  set statusLabel(String? val) => _statusLabel = val;

  bool hasStatusLabel() => _statusLabel != null;

  // "total_amount_display" field.
  String? _totalAmountDisplay;
  String get totalAmountDisplay => _totalAmountDisplay ?? '';
  set totalAmountDisplay(String? val) => _totalAmountDisplay = val;

  bool hasTotalAmountDisplay() => _totalAmountDisplay != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "created_at_time" field.
  String? _createdAtTime;
  String get createdAtTime => _createdAtTime ?? '';
  set createdAtTime(String? val) => _createdAtTime = val;

  bool hasCreatedAtTime() => _createdAtTime != null;

  // "scheduled_at" field.
  String? _scheduledAt;
  String get scheduledAt => _scheduledAt ?? '';
  set scheduledAt(String? val) => _scheduledAt = val;

  bool hasScheduledAt() => _scheduledAt != null;

  // "time_slot" field.
  String? _timeSlot;
  String get timeSlot => _timeSlot ?? '';
  set timeSlot(String? val) => _timeSlot = val;

  bool hasTimeSlot() => _timeSlot != null;

  // "time_range" field.
  String? _timeRange;
  String get timeRange => _timeRange ?? '';
  set timeRange(String? val) => _timeRange = val;

  bool hasTimeRange() => _timeRange != null;

  // "group_invite_label" field.
  String? _groupInviteLabel;
  String get groupInviteLabel => _groupInviteLabel ?? '';
  set groupInviteLabel(String? val) => _groupInviteLabel = val;

  bool hasGroupInviteLabel() => _groupInviteLabel != null;

  // "last_capture_at" field.
  String? _lastCaptureAt;
  String get lastCaptureAt => _lastCaptureAt ?? '';
  set lastCaptureAt(String? val) => _lastCaptureAt = val;

  bool hasLastCaptureAt() => _lastCaptureAt != null;

  // "last_capture_at_time" field.
  String? _lastCaptureAtTime;
  String get lastCaptureAtTime => _lastCaptureAtTime ?? '';
  set lastCaptureAtTime(String? val) => _lastCaptureAtTime = val;

  bool hasLastCaptureAtTime() => _lastCaptureAtTime != null;

  static ReservationHistoryItemStruct fromMap(Map<String, dynamic> data) =>
      ReservationHistoryItemStruct(
        primaryCastNickname: data['primary_cast_nickname'] as String?,
        statusLabel: data['status_label'] as String?,
        totalAmountDisplay: data['total_amount_display'] as String?,
        createdAt: data['created_at'] as String?,
        createdAtTime: data['created_at_time'] as String?,
        scheduledAt: data['scheduled_at'] as String?,
        timeSlot: data['time_slot'] as String?,
        timeRange: data['time_range'] as String?,
        groupInviteLabel: data['group_invite_label'] as String?,
        lastCaptureAt: data['last_capture_at'] as String?,
        lastCaptureAtTime: data['last_capture_at_time'] as String?,
      );

  static ReservationHistoryItemStruct? maybeFromMap(dynamic data) => data is Map
      ? ReservationHistoryItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'primary_cast_nickname': _primaryCastNickname,
        'status_label': _statusLabel,
        'total_amount_display': _totalAmountDisplay,
        'created_at': _createdAt,
        'created_at_time': _createdAtTime,
        'scheduled_at': _scheduledAt,
        'time_slot': _timeSlot,
        'time_range': _timeRange,
        'group_invite_label': _groupInviteLabel,
        'last_capture_at': _lastCaptureAt,
        'last_capture_at_time': _lastCaptureAtTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'primary_cast_nickname': serializeParam(
          _primaryCastNickname,
          ParamType.String,
        ),
        'status_label': serializeParam(
          _statusLabel,
          ParamType.String,
        ),
        'total_amount_display': serializeParam(
          _totalAmountDisplay,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'created_at_time': serializeParam(
          _createdAtTime,
          ParamType.String,
        ),
        'scheduled_at': serializeParam(
          _scheduledAt,
          ParamType.String,
        ),
        'time_slot': serializeParam(
          _timeSlot,
          ParamType.String,
        ),
        'time_range': serializeParam(
          _timeRange,
          ParamType.String,
        ),
        'group_invite_label': serializeParam(
          _groupInviteLabel,
          ParamType.String,
        ),
        'last_capture_at': serializeParam(
          _lastCaptureAt,
          ParamType.String,
        ),
        'last_capture_at_time': serializeParam(
          _lastCaptureAtTime,
          ParamType.String,
        ),
      }.withoutNulls;

  static ReservationHistoryItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ReservationHistoryItemStruct(
        primaryCastNickname: deserializeParam(
          data['primary_cast_nickname'],
          ParamType.String,
          false,
        ),
        statusLabel: deserializeParam(
          data['status_label'],
          ParamType.String,
          false,
        ),
        totalAmountDisplay: deserializeParam(
          data['total_amount_display'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        createdAtTime: deserializeParam(
          data['created_at_time'],
          ParamType.String,
          false,
        ),
        scheduledAt: deserializeParam(
          data['scheduled_at'],
          ParamType.String,
          false,
        ),
        timeSlot: deserializeParam(
          data['time_slot'],
          ParamType.String,
          false,
        ),
        timeRange: deserializeParam(
          data['time_range'],
          ParamType.String,
          false,
        ),
        groupInviteLabel: deserializeParam(
          data['group_invite_label'],
          ParamType.String,
          false,
        ),
        lastCaptureAt: deserializeParam(
          data['last_capture_at'],
          ParamType.String,
          false,
        ),
        lastCaptureAtTime: deserializeParam(
          data['last_capture_at_time'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ReservationHistoryItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ReservationHistoryItemStruct &&
        primaryCastNickname == other.primaryCastNickname &&
        statusLabel == other.statusLabel &&
        totalAmountDisplay == other.totalAmountDisplay &&
        createdAt == other.createdAt &&
        createdAtTime == other.createdAtTime &&
        scheduledAt == other.scheduledAt &&
        timeSlot == other.timeSlot &&
        timeRange == other.timeRange &&
        groupInviteLabel == other.groupInviteLabel &&
        lastCaptureAt == other.lastCaptureAt &&
        lastCaptureAtTime == other.lastCaptureAtTime;
  }

  @override
  int get hashCode => const ListEquality().hash([
        primaryCastNickname,
        statusLabel,
        totalAmountDisplay,
        createdAt,
        createdAtTime,
        scheduledAt,
        timeSlot,
        timeRange,
        groupInviteLabel,
        lastCaptureAt,
        lastCaptureAtTime
      ]);
}

ReservationHistoryItemStruct createReservationHistoryItemStruct({
  String? primaryCastNickname,
  String? statusLabel,
  String? totalAmountDisplay,
  String? createdAt,
  String? createdAtTime,
  String? scheduledAt,
  String? timeSlot,
  String? timeRange,
  String? groupInviteLabel,
  String? lastCaptureAt,
  String? lastCaptureAtTime,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ReservationHistoryItemStruct(
      primaryCastNickname: primaryCastNickname,
      statusLabel: statusLabel,
      totalAmountDisplay: totalAmountDisplay,
      createdAt: createdAt,
      createdAtTime: createdAtTime,
      scheduledAt: scheduledAt,
      timeSlot: timeSlot,
      timeRange: timeRange,
      groupInviteLabel: groupInviteLabel,
      lastCaptureAt: lastCaptureAt,
      lastCaptureAtTime: lastCaptureAtTime,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ReservationHistoryItemStruct? updateReservationHistoryItemStruct(
  ReservationHistoryItemStruct? reservationHistoryItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    reservationHistoryItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addReservationHistoryItemStructData(
  Map<String, dynamic> firestoreData,
  ReservationHistoryItemStruct? reservationHistoryItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (reservationHistoryItem == null) {
    return;
  }
  if (reservationHistoryItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      reservationHistoryItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final reservationHistoryItemData = getReservationHistoryItemFirestoreData(
      reservationHistoryItem, forFieldValue);
  final nestedData =
      reservationHistoryItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      reservationHistoryItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getReservationHistoryItemFirestoreData(
  ReservationHistoryItemStruct? reservationHistoryItem, [
  bool forFieldValue = false,
]) {
  if (reservationHistoryItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(reservationHistoryItem.toMap());

  // Add any Firestore field values
  mapToFirestore(reservationHistoryItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getReservationHistoryItemListFirestoreData(
  List<ReservationHistoryItemStruct>? reservationHistoryItems,
) =>
    reservationHistoryItems
        ?.map((e) => getReservationHistoryItemFirestoreData(e, true))
        .toList() ??
    [];
