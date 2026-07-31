// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// Per-category counts for UserManagementPage's 本日の新規登録 breakdown.
class TodaysRegistrationCountsStruct extends FFFirebaseStruct {
  TodaysRegistrationCountsStruct({
    /// TodaysRegistrationCounts.guest_count
    String? guestCount,

    /// TodaysRegistrationCounts.cast_count
    String? castCount,

    /// TodaysRegistrationCounts.staff_count
    String? staffCount,

    /// TodaysRegistrationCounts.admin_count
    String? adminCount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _guestCount = guestCount,
        _castCount = castCount,
        _staffCount = staffCount,
        _adminCount = adminCount,
        super(firestoreUtilData);

  // "guest_count" field.
  String? _guestCount;
  String get guestCount => _guestCount ?? '';
  set guestCount(String? val) => _guestCount = val;

  bool hasGuestCount() => _guestCount != null;

  // "cast_count" field.
  String? _castCount;
  String get castCount => _castCount ?? '';
  set castCount(String? val) => _castCount = val;

  bool hasCastCount() => _castCount != null;

  // "staff_count" field.
  String? _staffCount;
  String get staffCount => _staffCount ?? '';
  set staffCount(String? val) => _staffCount = val;

  bool hasStaffCount() => _staffCount != null;

  // "admin_count" field.
  String? _adminCount;
  String get adminCount => _adminCount ?? '';
  set adminCount(String? val) => _adminCount = val;

  bool hasAdminCount() => _adminCount != null;

  static TodaysRegistrationCountsStruct fromMap(Map<String, dynamic> data) =>
      TodaysRegistrationCountsStruct(
        guestCount: data['guest_count'] as String?,
        castCount: data['cast_count'] as String?,
        staffCount: data['staff_count'] as String?,
        adminCount: data['admin_count'] as String?,
      );

  static TodaysRegistrationCountsStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? TodaysRegistrationCountsStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'guest_count': _guestCount,
        'cast_count': _castCount,
        'staff_count': _staffCount,
        'admin_count': _adminCount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'guest_count': serializeParam(
          _guestCount,
          ParamType.String,
        ),
        'cast_count': serializeParam(
          _castCount,
          ParamType.String,
        ),
        'staff_count': serializeParam(
          _staffCount,
          ParamType.String,
        ),
        'admin_count': serializeParam(
          _adminCount,
          ParamType.String,
        ),
      }.withoutNulls;

  static TodaysRegistrationCountsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      TodaysRegistrationCountsStruct(
        guestCount: deserializeParam(
          data['guest_count'],
          ParamType.String,
          false,
        ),
        castCount: deserializeParam(
          data['cast_count'],
          ParamType.String,
          false,
        ),
        staffCount: deserializeParam(
          data['staff_count'],
          ParamType.String,
          false,
        ),
        adminCount: deserializeParam(
          data['admin_count'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TodaysRegistrationCountsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TodaysRegistrationCountsStruct &&
        guestCount == other.guestCount &&
        castCount == other.castCount &&
        staffCount == other.staffCount &&
        adminCount == other.adminCount;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([guestCount, castCount, staffCount, adminCount]);
}

TodaysRegistrationCountsStruct createTodaysRegistrationCountsStruct({
  String? guestCount,
  String? castCount,
  String? staffCount,
  String? adminCount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TodaysRegistrationCountsStruct(
      guestCount: guestCount,
      castCount: castCount,
      staffCount: staffCount,
      adminCount: adminCount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TodaysRegistrationCountsStruct? updateTodaysRegistrationCountsStruct(
  TodaysRegistrationCountsStruct? todaysRegistrationCounts, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    todaysRegistrationCounts
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTodaysRegistrationCountsStructData(
  Map<String, dynamic> firestoreData,
  TodaysRegistrationCountsStruct? todaysRegistrationCounts,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (todaysRegistrationCounts == null) {
    return;
  }
  if (todaysRegistrationCounts.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      todaysRegistrationCounts.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final todaysRegistrationCountsData = getTodaysRegistrationCountsFirestoreData(
      todaysRegistrationCounts, forFieldValue);
  final nestedData =
      todaysRegistrationCountsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      todaysRegistrationCounts.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTodaysRegistrationCountsFirestoreData(
  TodaysRegistrationCountsStruct? todaysRegistrationCounts, [
  bool forFieldValue = false,
]) {
  if (todaysRegistrationCounts == null) {
    return {};
  }
  final firestoreData = mapToFirestore(todaysRegistrationCounts.toMap());

  // Add any Firestore field values
  mapToFirestore(todaysRegistrationCounts.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTodaysRegistrationCountsListFirestoreData(
  List<TodaysRegistrationCountsStruct>? todaysRegistrationCountss,
) =>
    todaysRegistrationCountss
        ?.map((e) => getTodaysRegistrationCountsFirestoreData(e, true))
        .toList() ??
    [];
