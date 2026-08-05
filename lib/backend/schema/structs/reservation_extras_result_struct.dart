// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Combined result of adminGetReservationExtras.
class ReservationExtrasResultStruct extends FFFirebaseStruct {
  ReservationExtrasResultStruct({
    /// ReservationExtrasResult.extensions
    List<ExtensionPaymentItemStruct>? extensions,

    /// ReservationExtrasResult.rewards
    List<CastRewardItemStruct>? rewards,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _extensions = extensions,
        _rewards = rewards,
        super(firestoreUtilData);

  // "extensions" field.
  List<ExtensionPaymentItemStruct>? _extensions;
  List<ExtensionPaymentItemStruct> get extensions => _extensions ?? const [];
  set extensions(List<ExtensionPaymentItemStruct>? val) => _extensions = val;

  void updateExtensions(Function(List<ExtensionPaymentItemStruct>) updateFn) {
    updateFn(_extensions ??= []);
  }

  bool hasExtensions() => _extensions != null;

  // "rewards" field.
  List<CastRewardItemStruct>? _rewards;
  List<CastRewardItemStruct> get rewards => _rewards ?? const [];
  set rewards(List<CastRewardItemStruct>? val) => _rewards = val;

  void updateRewards(Function(List<CastRewardItemStruct>) updateFn) {
    updateFn(_rewards ??= []);
  }

  bool hasRewards() => _rewards != null;

  static ReservationExtrasResultStruct fromMap(Map<String, dynamic> data) =>
      ReservationExtrasResultStruct(
        extensions: getStructList(
          data['extensions'],
          ExtensionPaymentItemStruct.fromMap,
        ),
        rewards: getStructList(
          data['rewards'],
          CastRewardItemStruct.fromMap,
        ),
      );

  static ReservationExtrasResultStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? ReservationExtrasResultStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'extensions': _extensions?.map((e) => e.toMap()).toList(),
        'rewards': _rewards?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'extensions': serializeParam(
          _extensions,
          ParamType.DataStruct,
          isList: true,
        ),
        'rewards': serializeParam(
          _rewards,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ReservationExtrasResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ReservationExtrasResultStruct(
        extensions: deserializeStructParam<ExtensionPaymentItemStruct>(
          data['extensions'],
          ParamType.DataStruct,
          true,
          structBuilder: ExtensionPaymentItemStruct.fromSerializableMap,
        ),
        rewards: deserializeStructParam<CastRewardItemStruct>(
          data['rewards'],
          ParamType.DataStruct,
          true,
          structBuilder: CastRewardItemStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ReservationExtrasResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ReservationExtrasResultStruct &&
        listEquality.equals(extensions, other.extensions) &&
        listEquality.equals(rewards, other.rewards);
  }

  @override
  int get hashCode => const ListEquality().hash([extensions, rewards]);
}

ReservationExtrasResultStruct createReservationExtrasResultStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ReservationExtrasResultStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ReservationExtrasResultStruct? updateReservationExtrasResultStruct(
  ReservationExtrasResultStruct? reservationExtrasResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    reservationExtrasResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addReservationExtrasResultStructData(
  Map<String, dynamic> firestoreData,
  ReservationExtrasResultStruct? reservationExtrasResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (reservationExtrasResult == null) {
    return;
  }
  if (reservationExtrasResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      reservationExtrasResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final reservationExtrasResultData = getReservationExtrasResultFirestoreData(
      reservationExtrasResult, forFieldValue);
  final nestedData =
      reservationExtrasResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      reservationExtrasResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getReservationExtrasResultFirestoreData(
  ReservationExtrasResultStruct? reservationExtrasResult, [
  bool forFieldValue = false,
]) {
  if (reservationExtrasResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(reservationExtrasResult.toMap());

  // Add any Firestore field values
  mapToFirestore(reservationExtrasResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getReservationExtrasResultListFirestoreData(
  List<ReservationExtrasResultStruct>? reservationExtrasResults,
) =>
    reservationExtrasResults
        ?.map((e) => getReservationExtrasResultFirestoreData(e, true))
        .toList() ??
    [];
