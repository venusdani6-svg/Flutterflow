// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// Display-ready row fields for CocomiseListPage.
class CocotenShopItemStruct extends FFFirebaseStruct {
  CocotenShopItemStruct({
    /// CocotenShopItem.id
    String? id,

    /// CocotenShopItem.name
    String? name,

    /// CocotenShopItem.genre
    String? genre,

    /// CocotenShopItem.prefecture
    String? prefecture,

    /// CocotenShopItem.city
    String? city,

    /// CocotenShopItem.town_block
    String? townBlock,

    /// CocotenShopItem.building
    String? building,

    /// CocotenShopItem.active
    bool? active,

    /// CocotenShopItem.active_label
    String? activeLabel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _genre = genre,
        _prefecture = prefecture,
        _city = city,
        _townBlock = townBlock,
        _building = building,
        _active = active,
        _activeLabel = activeLabel,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "genre" field.
  String? _genre;
  String get genre => _genre ?? '';
  set genre(String? val) => _genre = val;

  bool hasGenre() => _genre != null;

  // "prefecture" field.
  String? _prefecture;
  String get prefecture => _prefecture ?? '';
  set prefecture(String? val) => _prefecture = val;

  bool hasPrefecture() => _prefecture != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "town_block" field.
  String? _townBlock;
  String get townBlock => _townBlock ?? '';
  set townBlock(String? val) => _townBlock = val;

  bool hasTownBlock() => _townBlock != null;

  // "building" field.
  String? _building;
  String get building => _building ?? '';
  set building(String? val) => _building = val;

  bool hasBuilding() => _building != null;

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  set active(bool? val) => _active = val;

  bool hasActive() => _active != null;

  // "active_label" field.
  String? _activeLabel;
  String get activeLabel => _activeLabel ?? '';
  set activeLabel(String? val) => _activeLabel = val;

  bool hasActiveLabel() => _activeLabel != null;

  static CocotenShopItemStruct fromMap(Map<String, dynamic> data) =>
      CocotenShopItemStruct(
        id: data['id'] as String?,
        name: data['name'] as String?,
        genre: data['genre'] as String?,
        prefecture: data['prefecture'] as String?,
        city: data['city'] as String?,
        townBlock: data['town_block'] as String?,
        building: data['building'] as String?,
        active: data['active'] as bool?,
        activeLabel: data['active_label'] as String?,
      );

  static CocotenShopItemStruct? maybeFromMap(dynamic data) => data is Map
      ? CocotenShopItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'genre': _genre,
        'prefecture': _prefecture,
        'city': _city,
        'town_block': _townBlock,
        'building': _building,
        'active': _active,
        'active_label': _activeLabel,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'genre': serializeParam(
          _genre,
          ParamType.String,
        ),
        'prefecture': serializeParam(
          _prefecture,
          ParamType.String,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'town_block': serializeParam(
          _townBlock,
          ParamType.String,
        ),
        'building': serializeParam(
          _building,
          ParamType.String,
        ),
        'active': serializeParam(
          _active,
          ParamType.bool,
        ),
        'active_label': serializeParam(
          _activeLabel,
          ParamType.String,
        ),
      }.withoutNulls;

  static CocotenShopItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      CocotenShopItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        genre: deserializeParam(
          data['genre'],
          ParamType.String,
          false,
        ),
        prefecture: deserializeParam(
          data['prefecture'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        townBlock: deserializeParam(
          data['town_block'],
          ParamType.String,
          false,
        ),
        building: deserializeParam(
          data['building'],
          ParamType.String,
          false,
        ),
        active: deserializeParam(
          data['active'],
          ParamType.bool,
          false,
        ),
        activeLabel: deserializeParam(
          data['active_label'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CocotenShopItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CocotenShopItemStruct &&
        id == other.id &&
        name == other.name &&
        genre == other.genre &&
        prefecture == other.prefecture &&
        city == other.city &&
        townBlock == other.townBlock &&
        building == other.building &&
        active == other.active &&
        activeLabel == other.activeLabel;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        name,
        genre,
        prefecture,
        city,
        townBlock,
        building,
        active,
        activeLabel
      ]);
}

CocotenShopItemStruct createCocotenShopItemStruct({
  String? id,
  String? name,
  String? genre,
  String? prefecture,
  String? city,
  String? townBlock,
  String? building,
  bool? active,
  String? activeLabel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CocotenShopItemStruct(
      id: id,
      name: name,
      genre: genre,
      prefecture: prefecture,
      city: city,
      townBlock: townBlock,
      building: building,
      active: active,
      activeLabel: activeLabel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CocotenShopItemStruct? updateCocotenShopItemStruct(
  CocotenShopItemStruct? cocotenShopItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cocotenShopItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCocotenShopItemStructData(
  Map<String, dynamic> firestoreData,
  CocotenShopItemStruct? cocotenShopItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cocotenShopItem == null) {
    return;
  }
  if (cocotenShopItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && cocotenShopItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cocotenShopItemData =
      getCocotenShopItemFirestoreData(cocotenShopItem, forFieldValue);
  final nestedData =
      cocotenShopItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = cocotenShopItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCocotenShopItemFirestoreData(
  CocotenShopItemStruct? cocotenShopItem, [
  bool forFieldValue = false,
]) {
  if (cocotenShopItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cocotenShopItem.toMap());

  // Add any Firestore field values
  mapToFirestore(cocotenShopItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCocotenShopItemListFirestoreData(
  List<CocotenShopItemStruct>? cocotenShopItems,
) =>
    cocotenShopItems
        ?.map((e) => getCocotenShopItemFirestoreData(e, true))
        .toList() ??
    [];
