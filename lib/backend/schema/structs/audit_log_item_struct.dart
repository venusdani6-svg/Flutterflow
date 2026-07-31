// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// Display-ready row fields for AuditLogListPage.
///
/// reason_display is `reason` when non-empty, else a flattened rendering of
/// the `details` map (most log entries only populate one of the two).
class AuditLogItemStruct extends FFFirebaseStruct {
  AuditLogItemStruct({
    /// AuditLogItem.id
    String? id,

    /// AuditLogItem.admin_nickname
    String? adminNickname,

    /// AuditLogItem.action_label
    String? actionLabel,

    /// AuditLogItem.target_type_label
    String? targetTypeLabel,

    /// AuditLogItem.target_id
    String? targetId,

    /// AuditLogItem.created_at
    String? createdAt,

    /// AuditLogItem.reason_display
    String? reasonDisplay,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _adminNickname = adminNickname,
        _actionLabel = actionLabel,
        _targetTypeLabel = targetTypeLabel,
        _targetId = targetId,
        _createdAt = createdAt,
        _reasonDisplay = reasonDisplay,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "admin_nickname" field.
  String? _adminNickname;
  String get adminNickname => _adminNickname ?? '';
  set adminNickname(String? val) => _adminNickname = val;

  bool hasAdminNickname() => _adminNickname != null;

  // "action_label" field.
  String? _actionLabel;
  String get actionLabel => _actionLabel ?? '';
  set actionLabel(String? val) => _actionLabel = val;

  bool hasActionLabel() => _actionLabel != null;

  // "target_type_label" field.
  String? _targetTypeLabel;
  String get targetTypeLabel => _targetTypeLabel ?? '';
  set targetTypeLabel(String? val) => _targetTypeLabel = val;

  bool hasTargetTypeLabel() => _targetTypeLabel != null;

  // "target_id" field.
  String? _targetId;
  String get targetId => _targetId ?? '';
  set targetId(String? val) => _targetId = val;

  bool hasTargetId() => _targetId != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "reason_display" field.
  String? _reasonDisplay;
  String get reasonDisplay => _reasonDisplay ?? '';
  set reasonDisplay(String? val) => _reasonDisplay = val;

  bool hasReasonDisplay() => _reasonDisplay != null;

  static AuditLogItemStruct fromMap(Map<String, dynamic> data) =>
      AuditLogItemStruct(
        id: data['id'] as String?,
        adminNickname: data['admin_nickname'] as String?,
        actionLabel: data['action_label'] as String?,
        targetTypeLabel: data['target_type_label'] as String?,
        targetId: data['target_id'] as String?,
        createdAt: data['created_at'] as String?,
        reasonDisplay: data['reason_display'] as String?,
      );

  static AuditLogItemStruct? maybeFromMap(dynamic data) => data is Map
      ? AuditLogItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'admin_nickname': _adminNickname,
        'action_label': _actionLabel,
        'target_type_label': _targetTypeLabel,
        'target_id': _targetId,
        'created_at': _createdAt,
        'reason_display': _reasonDisplay,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'admin_nickname': serializeParam(
          _adminNickname,
          ParamType.String,
        ),
        'action_label': serializeParam(
          _actionLabel,
          ParamType.String,
        ),
        'target_type_label': serializeParam(
          _targetTypeLabel,
          ParamType.String,
        ),
        'target_id': serializeParam(
          _targetId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'reason_display': serializeParam(
          _reasonDisplay,
          ParamType.String,
        ),
      }.withoutNulls;

  static AuditLogItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      AuditLogItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        adminNickname: deserializeParam(
          data['admin_nickname'],
          ParamType.String,
          false,
        ),
        actionLabel: deserializeParam(
          data['action_label'],
          ParamType.String,
          false,
        ),
        targetTypeLabel: deserializeParam(
          data['target_type_label'],
          ParamType.String,
          false,
        ),
        targetId: deserializeParam(
          data['target_id'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        reasonDisplay: deserializeParam(
          data['reason_display'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AuditLogItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AuditLogItemStruct &&
        id == other.id &&
        adminNickname == other.adminNickname &&
        actionLabel == other.actionLabel &&
        targetTypeLabel == other.targetTypeLabel &&
        targetId == other.targetId &&
        createdAt == other.createdAt &&
        reasonDisplay == other.reasonDisplay;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        adminNickname,
        actionLabel,
        targetTypeLabel,
        targetId,
        createdAt,
        reasonDisplay
      ]);
}

AuditLogItemStruct createAuditLogItemStruct({
  String? id,
  String? adminNickname,
  String? actionLabel,
  String? targetTypeLabel,
  String? targetId,
  String? createdAt,
  String? reasonDisplay,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AuditLogItemStruct(
      id: id,
      adminNickname: adminNickname,
      actionLabel: actionLabel,
      targetTypeLabel: targetTypeLabel,
      targetId: targetId,
      createdAt: createdAt,
      reasonDisplay: reasonDisplay,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AuditLogItemStruct? updateAuditLogItemStruct(
  AuditLogItemStruct? auditLogItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    auditLogItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAuditLogItemStructData(
  Map<String, dynamic> firestoreData,
  AuditLogItemStruct? auditLogItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (auditLogItem == null) {
    return;
  }
  if (auditLogItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && auditLogItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final auditLogItemData =
      getAuditLogItemFirestoreData(auditLogItem, forFieldValue);
  final nestedData =
      auditLogItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = auditLogItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAuditLogItemFirestoreData(
  AuditLogItemStruct? auditLogItem, [
  bool forFieldValue = false,
]) {
  if (auditLogItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(auditLogItem.toMap());

  // Add any Firestore field values
  mapToFirestore(auditLogItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAuditLogItemListFirestoreData(
  List<AuditLogItemStruct>? auditLogItems,
) =>
    auditLogItems?.map((e) => getAuditLogItemFirestoreData(e, true)).toList() ??
    [];
