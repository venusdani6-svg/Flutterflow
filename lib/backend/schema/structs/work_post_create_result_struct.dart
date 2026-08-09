// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// Typed result of adminCreateWorkPost, enabling a real success/failure
/// notification on the create-staff-job form instead of an unconditional
/// refetch+dismiss.
class WorkPostCreateResultStruct extends FFFirebaseStruct {
  WorkPostCreateResultStruct({
    /// WorkPostCreateResult.success
    bool? success,

    /// WorkPostCreateResult.error
    String? error,

    /// WorkPostCreateResult.postId
    String? postId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _success = success,
        _error = error,
        _postId = postId,
        super(firestoreUtilData);

  // "success" field.
  bool? _success;
  bool get success => _success ?? false;
  set success(bool? val) => _success = val;

  bool hasSuccess() => _success != null;

  // "error" field.
  String? _error;
  String get error => _error ?? '';
  set error(String? val) => _error = val;

  bool hasError() => _error != null;

  // "postId" field.
  String? _postId;
  String get postId => _postId ?? '';
  set postId(String? val) => _postId = val;

  bool hasPostId() => _postId != null;

  static WorkPostCreateResultStruct fromMap(Map<String, dynamic> data) =>
      WorkPostCreateResultStruct(
        success: data['success'] as bool?,
        error: data['error'] as String?,
        postId: data['postId'] as String?,
      );

  static WorkPostCreateResultStruct? maybeFromMap(dynamic data) => data is Map
      ? WorkPostCreateResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'error': _error,
        'postId': _postId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'success': serializeParam(
          _success,
          ParamType.bool,
        ),
        'error': serializeParam(
          _error,
          ParamType.String,
        ),
        'postId': serializeParam(
          _postId,
          ParamType.String,
        ),
      }.withoutNulls;

  static WorkPostCreateResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      WorkPostCreateResultStruct(
        success: deserializeParam(
          data['success'],
          ParamType.bool,
          false,
        ),
        error: deserializeParam(
          data['error'],
          ParamType.String,
          false,
        ),
        postId: deserializeParam(
          data['postId'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'WorkPostCreateResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WorkPostCreateResultStruct &&
        success == other.success &&
        error == other.error &&
        postId == other.postId;
  }

  @override
  int get hashCode => const ListEquality().hash([success, error, postId]);
}

WorkPostCreateResultStruct createWorkPostCreateResultStruct({
  bool? success,
  String? error,
  String? postId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    WorkPostCreateResultStruct(
      success: success,
      error: error,
      postId: postId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

WorkPostCreateResultStruct? updateWorkPostCreateResultStruct(
  WorkPostCreateResultStruct? workPostCreateResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    workPostCreateResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addWorkPostCreateResultStructData(
  Map<String, dynamic> firestoreData,
  WorkPostCreateResultStruct? workPostCreateResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (workPostCreateResult == null) {
    return;
  }
  if (workPostCreateResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && workPostCreateResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final workPostCreateResultData =
      getWorkPostCreateResultFirestoreData(workPostCreateResult, forFieldValue);
  final nestedData =
      workPostCreateResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      workPostCreateResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getWorkPostCreateResultFirestoreData(
  WorkPostCreateResultStruct? workPostCreateResult, [
  bool forFieldValue = false,
]) {
  if (workPostCreateResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(workPostCreateResult.toMap());

  // Add any Firestore field values
  mapToFirestore(workPostCreateResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getWorkPostCreateResultListFirestoreData(
  List<WorkPostCreateResultStruct>? workPostCreateResults,
) =>
    workPostCreateResults
        ?.map((e) => getWorkPostCreateResultFirestoreData(e, true))
        .toList() ??
    [];
