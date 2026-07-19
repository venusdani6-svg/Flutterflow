// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FeaturesEnabledStruct extends FFFirebaseStruct {
  FeaturesEnabledStruct({
    bool? affiliate,
    bool? staff,
    bool? cocoten,
    bool? workBoard,
    bool? gps,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _affiliate = affiliate,
        _staff = staff,
        _cocoten = cocoten,
        _workBoard = workBoard,
        _gps = gps,
        super(firestoreUtilData);

  // "affiliate" field.
  bool? _affiliate;
  bool get affiliate => _affiliate ?? false;
  set affiliate(bool? val) => _affiliate = val;

  bool hasAffiliate() => _affiliate != null;

  // "staff" field.
  bool? _staff;
  bool get staff => _staff ?? false;
  set staff(bool? val) => _staff = val;

  bool hasStaff() => _staff != null;

  // "cocoten" field.
  bool? _cocoten;
  bool get cocoten => _cocoten ?? false;
  set cocoten(bool? val) => _cocoten = val;

  bool hasCocoten() => _cocoten != null;

  // "work_board" field.
  bool? _workBoard;
  bool get workBoard => _workBoard ?? false;
  set workBoard(bool? val) => _workBoard = val;

  bool hasWorkBoard() => _workBoard != null;

  // "gps" field.
  bool? _gps;
  bool get gps => _gps ?? false;
  set gps(bool? val) => _gps = val;

  bool hasGps() => _gps != null;

  static FeaturesEnabledStruct fromMap(Map<String, dynamic> data) =>
      FeaturesEnabledStruct(
        affiliate: data['affiliate'] as bool?,
        staff: data['staff'] as bool?,
        cocoten: data['cocoten'] as bool?,
        workBoard: data['work_board'] as bool?,
        gps: data['gps'] as bool?,
      );

  static FeaturesEnabledStruct? maybeFromMap(dynamic data) => data is Map
      ? FeaturesEnabledStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'affiliate': _affiliate,
        'staff': _staff,
        'cocoten': _cocoten,
        'work_board': _workBoard,
        'gps': _gps,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'affiliate': serializeParam(
          _affiliate,
          ParamType.bool,
        ),
        'staff': serializeParam(
          _staff,
          ParamType.bool,
        ),
        'cocoten': serializeParam(
          _cocoten,
          ParamType.bool,
        ),
        'work_board': serializeParam(
          _workBoard,
          ParamType.bool,
        ),
        'gps': serializeParam(
          _gps,
          ParamType.bool,
        ),
      }.withoutNulls;

  static FeaturesEnabledStruct fromSerializableMap(Map<String, dynamic> data) =>
      FeaturesEnabledStruct(
        affiliate: deserializeParam(
          data['affiliate'],
          ParamType.bool,
          false,
        ),
        staff: deserializeParam(
          data['staff'],
          ParamType.bool,
          false,
        ),
        cocoten: deserializeParam(
          data['cocoten'],
          ParamType.bool,
          false,
        ),
        workBoard: deserializeParam(
          data['work_board'],
          ParamType.bool,
          false,
        ),
        gps: deserializeParam(
          data['gps'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'FeaturesEnabledStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FeaturesEnabledStruct &&
        affiliate == other.affiliate &&
        staff == other.staff &&
        cocoten == other.cocoten &&
        workBoard == other.workBoard &&
        gps == other.gps;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([affiliate, staff, cocoten, workBoard, gps]);
}

FeaturesEnabledStruct createFeaturesEnabledStruct({
  bool? affiliate,
  bool? staff,
  bool? cocoten,
  bool? workBoard,
  bool? gps,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FeaturesEnabledStruct(
      affiliate: affiliate,
      staff: staff,
      cocoten: cocoten,
      workBoard: workBoard,
      gps: gps,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FeaturesEnabledStruct? updateFeaturesEnabledStruct(
  FeaturesEnabledStruct? featuresEnabled, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    featuresEnabled
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFeaturesEnabledStructData(
  Map<String, dynamic> firestoreData,
  FeaturesEnabledStruct? featuresEnabled,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (featuresEnabled == null) {
    return;
  }
  if (featuresEnabled.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && featuresEnabled.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final featuresEnabledData =
      getFeaturesEnabledFirestoreData(featuresEnabled, forFieldValue);
  final nestedData =
      featuresEnabledData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = featuresEnabled.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFeaturesEnabledFirestoreData(
  FeaturesEnabledStruct? featuresEnabled, [
  bool forFieldValue = false,
]) {
  if (featuresEnabled == null) {
    return {};
  }
  final firestoreData = mapToFirestore(featuresEnabled.toMap());

  // Add any Firestore field values
  mapToFirestore(featuresEnabled.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFeaturesEnabledListFirestoreData(
  List<FeaturesEnabledStruct>? featuresEnableds,
) =>
    featuresEnableds
        ?.map((e) => getFeaturesEnabledFirestoreData(e, true))
        .toList() ??
    [];
