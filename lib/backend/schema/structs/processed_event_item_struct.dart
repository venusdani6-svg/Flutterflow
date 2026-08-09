// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// Display-ready row fields for ProcessedEventsListPage.
///
/// `id` is the Stripe event id itself (the idempotency key); `processed_at`
/// is JST-formatted client-side, same convention as AuditLogItem.
class ProcessedEventItemStruct extends FFFirebaseStruct {
  ProcessedEventItemStruct({
    /// ProcessedEventItem.id
    String? id,

    /// ProcessedEventItem.event_type
    String? eventType,

    /// ProcessedEventItem.processed_at
    String? processedAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _eventType = eventType,
        _processedAt = processedAt,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "event_type" field.
  String? _eventType;
  String get eventType => _eventType ?? '';
  set eventType(String? val) => _eventType = val;

  bool hasEventType() => _eventType != null;

  // "processed_at" field.
  String? _processedAt;
  String get processedAt => _processedAt ?? '';
  set processedAt(String? val) => _processedAt = val;

  bool hasProcessedAt() => _processedAt != null;

  static ProcessedEventItemStruct fromMap(Map<String, dynamic> data) =>
      ProcessedEventItemStruct(
        id: data['id'] as String?,
        eventType: data['event_type'] as String?,
        processedAt: data['processed_at'] as String?,
      );

  static ProcessedEventItemStruct? maybeFromMap(dynamic data) => data is Map
      ? ProcessedEventItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'event_type': _eventType,
        'processed_at': _processedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'event_type': serializeParam(
          _eventType,
          ParamType.String,
        ),
        'processed_at': serializeParam(
          _processedAt,
          ParamType.String,
        ),
      }.withoutNulls;

  static ProcessedEventItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ProcessedEventItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        eventType: deserializeParam(
          data['event_type'],
          ParamType.String,
          false,
        ),
        processedAt: deserializeParam(
          data['processed_at'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ProcessedEventItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProcessedEventItemStruct &&
        id == other.id &&
        eventType == other.eventType &&
        processedAt == other.processedAt;
  }

  @override
  int get hashCode => const ListEquality().hash([id, eventType, processedAt]);
}

ProcessedEventItemStruct createProcessedEventItemStruct({
  String? id,
  String? eventType,
  String? processedAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ProcessedEventItemStruct(
      id: id,
      eventType: eventType,
      processedAt: processedAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ProcessedEventItemStruct? updateProcessedEventItemStruct(
  ProcessedEventItemStruct? processedEventItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    processedEventItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addProcessedEventItemStructData(
  Map<String, dynamic> firestoreData,
  ProcessedEventItemStruct? processedEventItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (processedEventItem == null) {
    return;
  }
  if (processedEventItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && processedEventItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final processedEventItemData =
      getProcessedEventItemFirestoreData(processedEventItem, forFieldValue);
  final nestedData =
      processedEventItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      processedEventItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getProcessedEventItemFirestoreData(
  ProcessedEventItemStruct? processedEventItem, [
  bool forFieldValue = false,
]) {
  if (processedEventItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(processedEventItem.toMap());

  // Add any Firestore field values
  mapToFirestore(processedEventItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getProcessedEventItemListFirestoreData(
  List<ProcessedEventItemStruct>? processedEventItems,
) =>
    processedEventItems
        ?.map((e) => getProcessedEventItemFirestoreData(e, true))
        .toList() ??
    [];
