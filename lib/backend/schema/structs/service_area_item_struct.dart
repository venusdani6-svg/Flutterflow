// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// One row of the dynamic 提供都道府県一覧 list on 提供エリア設定 - all 47 prefectures, not
/// just the tab's original hardcoded 11.
///
/// `activeLabel` (有効/無効) reuses the same string vocabulary as
/// `activeStatusDotColorFn` (§18.78, already used across this project for
/// every other 有効/無効 status dot) so no new color function was needed.
class ServiceAreaItemStruct extends FFFirebaseStruct {
  ServiceAreaItemStruct({
    /// ServiceAreaItem.prefecture
    String? prefecture,

    /// ServiceAreaItem.active
    bool? active,

    /// ServiceAreaItem.activeLabel
    String? activeLabel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _prefecture = prefecture,
        _active = active,
        _activeLabel = activeLabel,
        super(firestoreUtilData);

  // "prefecture" field.
  String? _prefecture;
  String get prefecture => _prefecture ?? '';
  set prefecture(String? val) => _prefecture = val;

  bool hasPrefecture() => _prefecture != null;

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  set active(bool? val) => _active = val;

  bool hasActive() => _active != null;

  // "activeLabel" field.
  String? _activeLabel;
  String get activeLabel => _activeLabel ?? '';
  set activeLabel(String? val) => _activeLabel = val;

  bool hasActiveLabel() => _activeLabel != null;

  static ServiceAreaItemStruct fromMap(Map<String, dynamic> data) =>
      ServiceAreaItemStruct(
        prefecture: data['prefecture'] as String?,
        active: data['active'] as bool?,
        activeLabel: data['activeLabel'] as String?,
      );

  static ServiceAreaItemStruct? maybeFromMap(dynamic data) => data is Map
      ? ServiceAreaItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'prefecture': _prefecture,
        'active': _active,
        'activeLabel': _activeLabel,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'prefecture': serializeParam(
          _prefecture,
          ParamType.String,
        ),
        'active': serializeParam(
          _active,
          ParamType.bool,
        ),
        'activeLabel': serializeParam(
          _activeLabel,
          ParamType.String,
        ),
      }.withoutNulls;

  static ServiceAreaItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      ServiceAreaItemStruct(
        prefecture: deserializeParam(
          data['prefecture'],
          ParamType.String,
          false,
        ),
        active: deserializeParam(
          data['active'],
          ParamType.bool,
          false,
        ),
        activeLabel: deserializeParam(
          data['activeLabel'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ServiceAreaItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ServiceAreaItemStruct &&
        prefecture == other.prefecture &&
        active == other.active &&
        activeLabel == other.activeLabel;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([prefecture, active, activeLabel]);
}

ServiceAreaItemStruct createServiceAreaItemStruct({
  String? prefecture,
  bool? active,
  String? activeLabel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ServiceAreaItemStruct(
      prefecture: prefecture,
      active: active,
      activeLabel: activeLabel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ServiceAreaItemStruct? updateServiceAreaItemStruct(
  ServiceAreaItemStruct? serviceAreaItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    serviceAreaItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addServiceAreaItemStructData(
  Map<String, dynamic> firestoreData,
  ServiceAreaItemStruct? serviceAreaItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (serviceAreaItem == null) {
    return;
  }
  if (serviceAreaItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && serviceAreaItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final serviceAreaItemData =
      getServiceAreaItemFirestoreData(serviceAreaItem, forFieldValue);
  final nestedData =
      serviceAreaItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = serviceAreaItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getServiceAreaItemFirestoreData(
  ServiceAreaItemStruct? serviceAreaItem, [
  bool forFieldValue = false,
]) {
  if (serviceAreaItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(serviceAreaItem.toMap());

  // Add any Firestore field values
  mapToFirestore(serviceAreaItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getServiceAreaItemListFirestoreData(
  List<ServiceAreaItemStruct>? serviceAreaItems,
) =>
    serviceAreaItems
        ?.map((e) => getServiceAreaItemFirestoreData(e, true))
        .toList() ??
    [];
