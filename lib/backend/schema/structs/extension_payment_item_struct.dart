// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// One extension payment row for ReservationdetailsPage.
class ExtensionPaymentItemStruct extends FFFirebaseStruct {
  ExtensionPaymentItemStruct({
    /// ExtensionPaymentItem.id
    String? id,

    /// ExtensionPaymentItem.amount_display
    String? amountDisplay,

    /// ExtensionPaymentItem.duration_minutes_display
    String? durationMinutesDisplay,

    /// ExtensionPaymentItem.status_label
    String? statusLabel,

    /// ExtensionPaymentItem.created_at_display
    String? createdAtDisplay,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _amountDisplay = amountDisplay,
        _durationMinutesDisplay = durationMinutesDisplay,
        _statusLabel = statusLabel,
        _createdAtDisplay = createdAtDisplay,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "amount_display" field.
  String? _amountDisplay;
  String get amountDisplay => _amountDisplay ?? '';
  set amountDisplay(String? val) => _amountDisplay = val;

  bool hasAmountDisplay() => _amountDisplay != null;

  // "duration_minutes_display" field.
  String? _durationMinutesDisplay;
  String get durationMinutesDisplay => _durationMinutesDisplay ?? '';
  set durationMinutesDisplay(String? val) => _durationMinutesDisplay = val;

  bool hasDurationMinutesDisplay() => _durationMinutesDisplay != null;

  // "status_label" field.
  String? _statusLabel;
  String get statusLabel => _statusLabel ?? '';
  set statusLabel(String? val) => _statusLabel = val;

  bool hasStatusLabel() => _statusLabel != null;

  // "created_at_display" field.
  String? _createdAtDisplay;
  String get createdAtDisplay => _createdAtDisplay ?? '';
  set createdAtDisplay(String? val) => _createdAtDisplay = val;

  bool hasCreatedAtDisplay() => _createdAtDisplay != null;

  static ExtensionPaymentItemStruct fromMap(Map<String, dynamic> data) =>
      ExtensionPaymentItemStruct(
        id: data['id'] as String?,
        amountDisplay: data['amount_display'] as String?,
        durationMinutesDisplay: data['duration_minutes_display'] as String?,
        statusLabel: data['status_label'] as String?,
        createdAtDisplay: data['created_at_display'] as String?,
      );

  static ExtensionPaymentItemStruct? maybeFromMap(dynamic data) => data is Map
      ? ExtensionPaymentItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'amount_display': _amountDisplay,
        'duration_minutes_display': _durationMinutesDisplay,
        'status_label': _statusLabel,
        'created_at_display': _createdAtDisplay,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'amount_display': serializeParam(
          _amountDisplay,
          ParamType.String,
        ),
        'duration_minutes_display': serializeParam(
          _durationMinutesDisplay,
          ParamType.String,
        ),
        'status_label': serializeParam(
          _statusLabel,
          ParamType.String,
        ),
        'created_at_display': serializeParam(
          _createdAtDisplay,
          ParamType.String,
        ),
      }.withoutNulls;

  static ExtensionPaymentItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ExtensionPaymentItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        amountDisplay: deserializeParam(
          data['amount_display'],
          ParamType.String,
          false,
        ),
        durationMinutesDisplay: deserializeParam(
          data['duration_minutes_display'],
          ParamType.String,
          false,
        ),
        statusLabel: deserializeParam(
          data['status_label'],
          ParamType.String,
          false,
        ),
        createdAtDisplay: deserializeParam(
          data['created_at_display'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ExtensionPaymentItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ExtensionPaymentItemStruct &&
        id == other.id &&
        amountDisplay == other.amountDisplay &&
        durationMinutesDisplay == other.durationMinutesDisplay &&
        statusLabel == other.statusLabel &&
        createdAtDisplay == other.createdAtDisplay;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        amountDisplay,
        durationMinutesDisplay,
        statusLabel,
        createdAtDisplay
      ]);
}

ExtensionPaymentItemStruct createExtensionPaymentItemStruct({
  String? id,
  String? amountDisplay,
  String? durationMinutesDisplay,
  String? statusLabel,
  String? createdAtDisplay,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ExtensionPaymentItemStruct(
      id: id,
      amountDisplay: amountDisplay,
      durationMinutesDisplay: durationMinutesDisplay,
      statusLabel: statusLabel,
      createdAtDisplay: createdAtDisplay,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ExtensionPaymentItemStruct? updateExtensionPaymentItemStruct(
  ExtensionPaymentItemStruct? extensionPaymentItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    extensionPaymentItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addExtensionPaymentItemStructData(
  Map<String, dynamic> firestoreData,
  ExtensionPaymentItemStruct? extensionPaymentItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (extensionPaymentItem == null) {
    return;
  }
  if (extensionPaymentItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && extensionPaymentItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final extensionPaymentItemData =
      getExtensionPaymentItemFirestoreData(extensionPaymentItem, forFieldValue);
  final nestedData =
      extensionPaymentItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      extensionPaymentItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getExtensionPaymentItemFirestoreData(
  ExtensionPaymentItemStruct? extensionPaymentItem, [
  bool forFieldValue = false,
]) {
  if (extensionPaymentItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(extensionPaymentItem.toMap());

  // Add any Firestore field values
  mapToFirestore(extensionPaymentItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getExtensionPaymentItemListFirestoreData(
  List<ExtensionPaymentItemStruct>? extensionPaymentItems,
) =>
    extensionPaymentItems
        ?.map((e) => getExtensionPaymentItemFirestoreData(e, true))
        .toList() ??
    [];
