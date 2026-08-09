// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Display-ready row fields for JobBoardListPage.
class WorkPostItemStruct extends FFFirebaseStruct {
  WorkPostItemStruct({
    /// WorkPostItem.id
    String? id,

    /// WorkPostItem.poster_nickname
    String? posterNickname,

    /// WorkPostItem.type_label
    String? typeLabel,

    /// WorkPostItem.description
    String? description,

    /// WorkPostItem.work_date
    String? workDate,

    /// WorkPostItem.created_at
    String? createdAt,

    /// WorkPostItem.applicant_count
    String? applicantCount,

    /// WorkPostItem.status_label
    String? statusLabel,

    /// WorkPostItem.status
    String? status,

    /// Raw type value (partner_recruit/security/transport).
    String? type,

    /// Resolved (id, nickname) applicants for this post.
    List<WorkPostApplicantStruct>? applicants,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _posterNickname = posterNickname,
        _typeLabel = typeLabel,
        _description = description,
        _workDate = workDate,
        _createdAt = createdAt,
        _applicantCount = applicantCount,
        _statusLabel = statusLabel,
        _status = status,
        _type = type,
        _applicants = applicants,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "poster_nickname" field.
  String? _posterNickname;
  String get posterNickname => _posterNickname ?? '';
  set posterNickname(String? val) => _posterNickname = val;

  bool hasPosterNickname() => _posterNickname != null;

  // "type_label" field.
  String? _typeLabel;
  String get typeLabel => _typeLabel ?? '';
  set typeLabel(String? val) => _typeLabel = val;

  bool hasTypeLabel() => _typeLabel != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "work_date" field.
  String? _workDate;
  String get workDate => _workDate ?? '';
  set workDate(String? val) => _workDate = val;

  bool hasWorkDate() => _workDate != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "applicant_count" field.
  String? _applicantCount;
  String get applicantCount => _applicantCount ?? '';
  set applicantCount(String? val) => _applicantCount = val;

  bool hasApplicantCount() => _applicantCount != null;

  // "status_label" field.
  String? _statusLabel;
  String get statusLabel => _statusLabel ?? '';
  set statusLabel(String? val) => _statusLabel = val;

  bool hasStatusLabel() => _statusLabel != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "applicants" field.
  List<WorkPostApplicantStruct>? _applicants;
  List<WorkPostApplicantStruct> get applicants => _applicants ?? const [];
  set applicants(List<WorkPostApplicantStruct>? val) => _applicants = val;

  void updateApplicants(Function(List<WorkPostApplicantStruct>) updateFn) {
    updateFn(_applicants ??= []);
  }

  bool hasApplicants() => _applicants != null;

  static WorkPostItemStruct fromMap(Map<String, dynamic> data) =>
      WorkPostItemStruct(
        id: data['id'] as String?,
        posterNickname: data['poster_nickname'] as String?,
        typeLabel: data['type_label'] as String?,
        description: data['description'] as String?,
        workDate: data['work_date'] as String?,
        createdAt: data['created_at'] as String?,
        applicantCount: data['applicant_count'] as String?,
        statusLabel: data['status_label'] as String?,
        status: data['status'] as String?,
        type: data['type'] as String?,
        applicants: getStructList(
          data['applicants'],
          WorkPostApplicantStruct.fromMap,
        ),
      );

  static WorkPostItemStruct? maybeFromMap(dynamic data) => data is Map
      ? WorkPostItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'poster_nickname': _posterNickname,
        'type_label': _typeLabel,
        'description': _description,
        'work_date': _workDate,
        'created_at': _createdAt,
        'applicant_count': _applicantCount,
        'status_label': _statusLabel,
        'status': _status,
        'type': _type,
        'applicants': _applicants?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'poster_nickname': serializeParam(
          _posterNickname,
          ParamType.String,
        ),
        'type_label': serializeParam(
          _typeLabel,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'work_date': serializeParam(
          _workDate,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'applicant_count': serializeParam(
          _applicantCount,
          ParamType.String,
        ),
        'status_label': serializeParam(
          _statusLabel,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'applicants': serializeParam(
          _applicants,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static WorkPostItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      WorkPostItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        posterNickname: deserializeParam(
          data['poster_nickname'],
          ParamType.String,
          false,
        ),
        typeLabel: deserializeParam(
          data['type_label'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        workDate: deserializeParam(
          data['work_date'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        applicantCount: deserializeParam(
          data['applicant_count'],
          ParamType.String,
          false,
        ),
        statusLabel: deserializeParam(
          data['status_label'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        applicants: deserializeStructParam<WorkPostApplicantStruct>(
          data['applicants'],
          ParamType.DataStruct,
          true,
          structBuilder: WorkPostApplicantStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'WorkPostItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is WorkPostItemStruct &&
        id == other.id &&
        posterNickname == other.posterNickname &&
        typeLabel == other.typeLabel &&
        description == other.description &&
        workDate == other.workDate &&
        createdAt == other.createdAt &&
        applicantCount == other.applicantCount &&
        statusLabel == other.statusLabel &&
        status == other.status &&
        type == other.type &&
        listEquality.equals(applicants, other.applicants);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        posterNickname,
        typeLabel,
        description,
        workDate,
        createdAt,
        applicantCount,
        statusLabel,
        status,
        type,
        applicants
      ]);
}

WorkPostItemStruct createWorkPostItemStruct({
  String? id,
  String? posterNickname,
  String? typeLabel,
  String? description,
  String? workDate,
  String? createdAt,
  String? applicantCount,
  String? statusLabel,
  String? status,
  String? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    WorkPostItemStruct(
      id: id,
      posterNickname: posterNickname,
      typeLabel: typeLabel,
      description: description,
      workDate: workDate,
      createdAt: createdAt,
      applicantCount: applicantCount,
      statusLabel: statusLabel,
      status: status,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

WorkPostItemStruct? updateWorkPostItemStruct(
  WorkPostItemStruct? workPostItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    workPostItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addWorkPostItemStructData(
  Map<String, dynamic> firestoreData,
  WorkPostItemStruct? workPostItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (workPostItem == null) {
    return;
  }
  if (workPostItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && workPostItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final workPostItemData =
      getWorkPostItemFirestoreData(workPostItem, forFieldValue);
  final nestedData =
      workPostItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = workPostItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getWorkPostItemFirestoreData(
  WorkPostItemStruct? workPostItem, [
  bool forFieldValue = false,
]) {
  if (workPostItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(workPostItem.toMap());

  // Add any Firestore field values
  mapToFirestore(workPostItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getWorkPostItemListFirestoreData(
  List<WorkPostItemStruct>? workPostItems,
) =>
    workPostItems?.map((e) => getWorkPostItemFirestoreData(e, true)).toList() ??
    [];
