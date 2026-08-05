// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// One cast's reward-ledger row for ReservationdetailsPage.
class CastRewardItemStruct extends FFFirebaseStruct {
  CastRewardItemStruct({
    /// CastRewardItem.cast_id
    String? castId,

    /// CastRewardItem.cast_nickname
    String? castNickname,

    /// CastRewardItem.amount_display
    String? amountDisplay,

    /// CastRewardItem.status_label
    String? statusLabel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _castId = castId,
        _castNickname = castNickname,
        _amountDisplay = amountDisplay,
        _statusLabel = statusLabel,
        super(firestoreUtilData);

  // "cast_id" field.
  String? _castId;
  String get castId => _castId ?? '';
  set castId(String? val) => _castId = val;

  bool hasCastId() => _castId != null;

  // "cast_nickname" field.
  String? _castNickname;
  String get castNickname => _castNickname ?? '';
  set castNickname(String? val) => _castNickname = val;

  bool hasCastNickname() => _castNickname != null;

  // "amount_display" field.
  String? _amountDisplay;
  String get amountDisplay => _amountDisplay ?? '';
  set amountDisplay(String? val) => _amountDisplay = val;

  bool hasAmountDisplay() => _amountDisplay != null;

  // "status_label" field.
  String? _statusLabel;
  String get statusLabel => _statusLabel ?? '';
  set statusLabel(String? val) => _statusLabel = val;

  bool hasStatusLabel() => _statusLabel != null;

  static CastRewardItemStruct fromMap(Map<String, dynamic> data) =>
      CastRewardItemStruct(
        castId: data['cast_id'] as String?,
        castNickname: data['cast_nickname'] as String?,
        amountDisplay: data['amount_display'] as String?,
        statusLabel: data['status_label'] as String?,
      );

  static CastRewardItemStruct? maybeFromMap(dynamic data) => data is Map
      ? CastRewardItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'cast_id': _castId,
        'cast_nickname': _castNickname,
        'amount_display': _amountDisplay,
        'status_label': _statusLabel,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'cast_id': serializeParam(
          _castId,
          ParamType.String,
        ),
        'cast_nickname': serializeParam(
          _castNickname,
          ParamType.String,
        ),
        'amount_display': serializeParam(
          _amountDisplay,
          ParamType.String,
        ),
        'status_label': serializeParam(
          _statusLabel,
          ParamType.String,
        ),
      }.withoutNulls;

  static CastRewardItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      CastRewardItemStruct(
        castId: deserializeParam(
          data['cast_id'],
          ParamType.String,
          false,
        ),
        castNickname: deserializeParam(
          data['cast_nickname'],
          ParamType.String,
          false,
        ),
        amountDisplay: deserializeParam(
          data['amount_display'],
          ParamType.String,
          false,
        ),
        statusLabel: deserializeParam(
          data['status_label'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CastRewardItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CastRewardItemStruct &&
        castId == other.castId &&
        castNickname == other.castNickname &&
        amountDisplay == other.amountDisplay &&
        statusLabel == other.statusLabel;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([castId, castNickname, amountDisplay, statusLabel]);
}

CastRewardItemStruct createCastRewardItemStruct({
  String? castId,
  String? castNickname,
  String? amountDisplay,
  String? statusLabel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CastRewardItemStruct(
      castId: castId,
      castNickname: castNickname,
      amountDisplay: amountDisplay,
      statusLabel: statusLabel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CastRewardItemStruct? updateCastRewardItemStruct(
  CastRewardItemStruct? castRewardItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    castRewardItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCastRewardItemStructData(
  Map<String, dynamic> firestoreData,
  CastRewardItemStruct? castRewardItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (castRewardItem == null) {
    return;
  }
  if (castRewardItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && castRewardItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final castRewardItemData =
      getCastRewardItemFirestoreData(castRewardItem, forFieldValue);
  final nestedData =
      castRewardItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = castRewardItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCastRewardItemFirestoreData(
  CastRewardItemStruct? castRewardItem, [
  bool forFieldValue = false,
]) {
  if (castRewardItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(castRewardItem.toMap());

  // Add any Firestore field values
  mapToFirestore(castRewardItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCastRewardItemListFirestoreData(
  List<CastRewardItemStruct>? castRewardItems,
) =>
    castRewardItems
        ?.map((e) => getCastRewardItemFirestoreData(e, true))
        .toList() ??
    [];
