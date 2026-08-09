// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// One resolved (id, nickname) applicant entry on a work_posts doc, for
/// HireApplicantDialogComp's picker list.
class WorkPostApplicantStruct extends FFFirebaseStruct {
  WorkPostApplicantStruct({
    /// WorkPostApplicant.id
    String? id,

    /// WorkPostApplicant.nickname
    String? nickname,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _nickname = nickname,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "nickname" field.
  String? _nickname;
  String get nickname => _nickname ?? '';
  set nickname(String? val) => _nickname = val;

  bool hasNickname() => _nickname != null;

  static WorkPostApplicantStruct fromMap(Map<String, dynamic> data) =>
      WorkPostApplicantStruct(
        id: data['id'] as String?,
        nickname: data['nickname'] as String?,
      );

  static WorkPostApplicantStruct? maybeFromMap(dynamic data) => data is Map
      ? WorkPostApplicantStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'nickname': _nickname,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'nickname': serializeParam(
          _nickname,
          ParamType.String,
        ),
      }.withoutNulls;

  static WorkPostApplicantStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      WorkPostApplicantStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        nickname: deserializeParam(
          data['nickname'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'WorkPostApplicantStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WorkPostApplicantStruct &&
        id == other.id &&
        nickname == other.nickname;
  }

  @override
  int get hashCode => const ListEquality().hash([id, nickname]);
}

WorkPostApplicantStruct createWorkPostApplicantStruct({
  String? id,
  String? nickname,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    WorkPostApplicantStruct(
      id: id,
      nickname: nickname,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

WorkPostApplicantStruct? updateWorkPostApplicantStruct(
  WorkPostApplicantStruct? workPostApplicant, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    workPostApplicant
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addWorkPostApplicantStructData(
  Map<String, dynamic> firestoreData,
  WorkPostApplicantStruct? workPostApplicant,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (workPostApplicant == null) {
    return;
  }
  if (workPostApplicant.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && workPostApplicant.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final workPostApplicantData =
      getWorkPostApplicantFirestoreData(workPostApplicant, forFieldValue);
  final nestedData =
      workPostApplicantData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = workPostApplicant.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getWorkPostApplicantFirestoreData(
  WorkPostApplicantStruct? workPostApplicant, [
  bool forFieldValue = false,
]) {
  if (workPostApplicant == null) {
    return {};
  }
  final firestoreData = mapToFirestore(workPostApplicant.toMap());

  // Add any Firestore field values
  mapToFirestore(workPostApplicant.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getWorkPostApplicantListFirestoreData(
  List<WorkPostApplicantStruct>? workPostApplicants,
) =>
    workPostApplicants
        ?.map((e) => getWorkPostApplicantFirestoreData(e, true))
        .toList() ??
    [];
