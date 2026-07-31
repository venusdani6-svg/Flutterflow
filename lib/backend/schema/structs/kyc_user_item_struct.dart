// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// Display-ready KYC submission fields for KYCReviewListPage's row template.
class KycUserItemStruct extends FFFirebaseStruct {
  KycUserItemStruct({
    /// KycUserItem.id
    String? id,

    /// KycUserItem.nickname
    String? nickname,

    /// KycUserItem.kyc_status
    String? kycStatus,

    /// KycUserItem.kyc_doc_url
    String? kycDocUrl,

    /// KycUserItem.kyc_selfie_url
    String? kycSelfieUrl,

    /// KycUserItem.updated_at
    String? updatedAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _nickname = nickname,
        _kycStatus = kycStatus,
        _kycDocUrl = kycDocUrl,
        _kycSelfieUrl = kycSelfieUrl,
        _updatedAt = updatedAt,
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

  // "kyc_status" field.
  String? _kycStatus;
  String get kycStatus => _kycStatus ?? '';
  set kycStatus(String? val) => _kycStatus = val;

  bool hasKycStatus() => _kycStatus != null;

  // "kyc_doc_url" field.
  String? _kycDocUrl;
  String get kycDocUrl => _kycDocUrl ?? '';
  set kycDocUrl(String? val) => _kycDocUrl = val;

  bool hasKycDocUrl() => _kycDocUrl != null;

  // "kyc_selfie_url" field.
  String? _kycSelfieUrl;
  String get kycSelfieUrl => _kycSelfieUrl ?? '';
  set kycSelfieUrl(String? val) => _kycSelfieUrl = val;

  bool hasKycSelfieUrl() => _kycSelfieUrl != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  static KycUserItemStruct fromMap(Map<String, dynamic> data) =>
      KycUserItemStruct(
        id: data['id'] as String?,
        nickname: data['nickname'] as String?,
        kycStatus: data['kyc_status'] as String?,
        kycDocUrl: data['kyc_doc_url'] as String?,
        kycSelfieUrl: data['kyc_selfie_url'] as String?,
        updatedAt: data['updated_at'] as String?,
      );

  static KycUserItemStruct? maybeFromMap(dynamic data) => data is Map
      ? KycUserItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'nickname': _nickname,
        'kyc_status': _kycStatus,
        'kyc_doc_url': _kycDocUrl,
        'kyc_selfie_url': _kycSelfieUrl,
        'updated_at': _updatedAt,
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
        'kyc_status': serializeParam(
          _kycStatus,
          ParamType.String,
        ),
        'kyc_doc_url': serializeParam(
          _kycDocUrl,
          ParamType.String,
        ),
        'kyc_selfie_url': serializeParam(
          _kycSelfieUrl,
          ParamType.String,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
      }.withoutNulls;

  static KycUserItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      KycUserItemStruct(
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
        kycStatus: deserializeParam(
          data['kyc_status'],
          ParamType.String,
          false,
        ),
        kycDocUrl: deserializeParam(
          data['kyc_doc_url'],
          ParamType.String,
          false,
        ),
        kycSelfieUrl: deserializeParam(
          data['kyc_selfie_url'],
          ParamType.String,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'KycUserItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is KycUserItemStruct &&
        id == other.id &&
        nickname == other.nickname &&
        kycStatus == other.kycStatus &&
        kycDocUrl == other.kycDocUrl &&
        kycSelfieUrl == other.kycSelfieUrl &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, nickname, kycStatus, kycDocUrl, kycSelfieUrl, updatedAt]);
}

KycUserItemStruct createKycUserItemStruct({
  String? id,
  String? nickname,
  String? kycStatus,
  String? kycDocUrl,
  String? kycSelfieUrl,
  String? updatedAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    KycUserItemStruct(
      id: id,
      nickname: nickname,
      kycStatus: kycStatus,
      kycDocUrl: kycDocUrl,
      kycSelfieUrl: kycSelfieUrl,
      updatedAt: updatedAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

KycUserItemStruct? updateKycUserItemStruct(
  KycUserItemStruct? kycUserItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    kycUserItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addKycUserItemStructData(
  Map<String, dynamic> firestoreData,
  KycUserItemStruct? kycUserItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (kycUserItem == null) {
    return;
  }
  if (kycUserItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && kycUserItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final kycUserItemData =
      getKycUserItemFirestoreData(kycUserItem, forFieldValue);
  final nestedData =
      kycUserItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = kycUserItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getKycUserItemFirestoreData(
  KycUserItemStruct? kycUserItem, [
  bool forFieldValue = false,
]) {
  if (kycUserItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(kycUserItem.toMap());

  // Add any Firestore field values
  mapToFirestore(kycUserItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getKycUserItemListFirestoreData(
  List<KycUserItemStruct>? kycUserItems,
) =>
    kycUserItems?.map((e) => getKycUserItemFirestoreData(e, true)).toList() ??
    [];
