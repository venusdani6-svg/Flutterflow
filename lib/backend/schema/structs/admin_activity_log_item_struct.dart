// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// One row of the "info" modal's recent-admin-activity list - the
/// display-ready fields of one AuditLogItemStruct entry, scoped to a single
/// target user.
class AdminActivityLogItemStruct extends FFFirebaseStruct {
  AdminActivityLogItemStruct({
    /// AdminActivityLogItem.actionLabel
    String? actionLabel,

    /// AdminActivityLogItem.reasonDisplay
    String? reasonDisplay,

    /// AdminActivityLogItem.createdAt
    String? createdAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _actionLabel = actionLabel,
        _reasonDisplay = reasonDisplay,
        _createdAt = createdAt,
        super(firestoreUtilData);

  // "actionLabel" field.
  String? _actionLabel;
  String get actionLabel => _actionLabel ?? '';
  set actionLabel(String? val) => _actionLabel = val;

  bool hasActionLabel() => _actionLabel != null;

  // "reasonDisplay" field.
  String? _reasonDisplay;
  String get reasonDisplay => _reasonDisplay ?? '';
  set reasonDisplay(String? val) => _reasonDisplay = val;

  bool hasReasonDisplay() => _reasonDisplay != null;

  // "createdAt" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static AdminActivityLogItemStruct fromMap(Map<String, dynamic> data) =>
      AdminActivityLogItemStruct(
        actionLabel: data['actionLabel'] as String?,
        reasonDisplay: data['reasonDisplay'] as String?,
        createdAt: data['createdAt'] as String?,
      );

  static AdminActivityLogItemStruct? maybeFromMap(dynamic data) => data is Map
      ? AdminActivityLogItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'actionLabel': _actionLabel,
        'reasonDisplay': _reasonDisplay,
        'createdAt': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'actionLabel': serializeParam(
          _actionLabel,
          ParamType.String,
        ),
        'reasonDisplay': serializeParam(
          _reasonDisplay,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.String,
        ),
      }.withoutNulls;

  static AdminActivityLogItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      AdminActivityLogItemStruct(
        actionLabel: deserializeParam(
          data['actionLabel'],
          ParamType.String,
          false,
        ),
        reasonDisplay: deserializeParam(
          data['reasonDisplay'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AdminActivityLogItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AdminActivityLogItemStruct &&
        actionLabel == other.actionLabel &&
        reasonDisplay == other.reasonDisplay &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([actionLabel, reasonDisplay, createdAt]);
}

AdminActivityLogItemStruct createAdminActivityLogItemStruct({
  String? actionLabel,
  String? reasonDisplay,
  String? createdAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AdminActivityLogItemStruct(
      actionLabel: actionLabel,
      reasonDisplay: reasonDisplay,
      createdAt: createdAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AdminActivityLogItemStruct? updateAdminActivityLogItemStruct(
  AdminActivityLogItemStruct? adminActivityLogItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    adminActivityLogItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAdminActivityLogItemStructData(
  Map<String, dynamic> firestoreData,
  AdminActivityLogItemStruct? adminActivityLogItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (adminActivityLogItem == null) {
    return;
  }
  if (adminActivityLogItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && adminActivityLogItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final adminActivityLogItemData =
      getAdminActivityLogItemFirestoreData(adminActivityLogItem, forFieldValue);
  final nestedData =
      adminActivityLogItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      adminActivityLogItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAdminActivityLogItemFirestoreData(
  AdminActivityLogItemStruct? adminActivityLogItem, [
  bool forFieldValue = false,
]) {
  if (adminActivityLogItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(adminActivityLogItem.toMap());

  // Add any Firestore field values
  mapToFirestore(adminActivityLogItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAdminActivityLogItemListFirestoreData(
  List<AdminActivityLogItemStruct>? adminActivityLogItems,
) =>
    adminActivityLogItems
        ?.map((e) => getAdminActivityLogItemFirestoreData(e, true))
        .toList() ??
    [];
