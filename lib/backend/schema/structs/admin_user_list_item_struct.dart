// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// Display-ready row fields shared by CastUserListPage, StaffUserListPage and
/// AdministratorListPage.
///
/// extra_value carries whichever fourth field each role shows (logical debt
/// for cast, online status for staff, unused for admin) - the label for that
/// field is a compile-time constant per page, not part of the struct.
class AdminUserListItemStruct extends FFFirebaseStruct {
  AdminUserListItemStruct({
    /// AdminUserListItem.id
    String? id,

    /// AdminUserListItem.nickname
    String? nickname,

    /// AdminUserListItem.account_type_label
    String? accountTypeLabel,

    /// AdminUserListItem.created_at
    String? createdAt,

    /// AdminUserListItem.kyc_status
    String? kycStatus,

    /// AdminUserListItem.is_active
    String? isActive,

    /// AdminUserListItem.last_login_at
    String? lastLoginAt,

    /// AdminUserListItem.extra_value
    String? extraValue,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _nickname = nickname,
        _accountTypeLabel = accountTypeLabel,
        _createdAt = createdAt,
        _kycStatus = kycStatus,
        _isActive = isActive,
        _lastLoginAt = lastLoginAt,
        _extraValue = extraValue,
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

  // "account_type_label" field.
  String? _accountTypeLabel;
  String get accountTypeLabel => _accountTypeLabel ?? '';
  set accountTypeLabel(String? val) => _accountTypeLabel = val;

  bool hasAccountTypeLabel() => _accountTypeLabel != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "kyc_status" field.
  String? _kycStatus;
  String get kycStatus => _kycStatus ?? '';
  set kycStatus(String? val) => _kycStatus = val;

  bool hasKycStatus() => _kycStatus != null;

  // "is_active" field.
  String? _isActive;
  String get isActive => _isActive ?? '';
  set isActive(String? val) => _isActive = val;

  bool hasIsActive() => _isActive != null;

  // "last_login_at" field.
  String? _lastLoginAt;
  String get lastLoginAt => _lastLoginAt ?? '';
  set lastLoginAt(String? val) => _lastLoginAt = val;

  bool hasLastLoginAt() => _lastLoginAt != null;

  // "extra_value" field.
  String? _extraValue;
  String get extraValue => _extraValue ?? '';
  set extraValue(String? val) => _extraValue = val;

  bool hasExtraValue() => _extraValue != null;

  static AdminUserListItemStruct fromMap(Map<String, dynamic> data) =>
      AdminUserListItemStruct(
        id: data['id'] as String?,
        nickname: data['nickname'] as String?,
        accountTypeLabel: data['account_type_label'] as String?,
        createdAt: data['created_at'] as String?,
        kycStatus: data['kyc_status'] as String?,
        isActive: data['is_active'] as String?,
        lastLoginAt: data['last_login_at'] as String?,
        extraValue: data['extra_value'] as String?,
      );

  static AdminUserListItemStruct? maybeFromMap(dynamic data) => data is Map
      ? AdminUserListItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'nickname': _nickname,
        'account_type_label': _accountTypeLabel,
        'created_at': _createdAt,
        'kyc_status': _kycStatus,
        'is_active': _isActive,
        'last_login_at': _lastLoginAt,
        'extra_value': _extraValue,
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
        'account_type_label': serializeParam(
          _accountTypeLabel,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'kyc_status': serializeParam(
          _kycStatus,
          ParamType.String,
        ),
        'is_active': serializeParam(
          _isActive,
          ParamType.String,
        ),
        'last_login_at': serializeParam(
          _lastLoginAt,
          ParamType.String,
        ),
        'extra_value': serializeParam(
          _extraValue,
          ParamType.String,
        ),
      }.withoutNulls;

  static AdminUserListItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      AdminUserListItemStruct(
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
        accountTypeLabel: deserializeParam(
          data['account_type_label'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        kycStatus: deserializeParam(
          data['kyc_status'],
          ParamType.String,
          false,
        ),
        isActive: deserializeParam(
          data['is_active'],
          ParamType.String,
          false,
        ),
        lastLoginAt: deserializeParam(
          data['last_login_at'],
          ParamType.String,
          false,
        ),
        extraValue: deserializeParam(
          data['extra_value'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AdminUserListItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AdminUserListItemStruct &&
        id == other.id &&
        nickname == other.nickname &&
        accountTypeLabel == other.accountTypeLabel &&
        createdAt == other.createdAt &&
        kycStatus == other.kycStatus &&
        isActive == other.isActive &&
        lastLoginAt == other.lastLoginAt &&
        extraValue == other.extraValue;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        nickname,
        accountTypeLabel,
        createdAt,
        kycStatus,
        isActive,
        lastLoginAt,
        extraValue
      ]);
}

AdminUserListItemStruct createAdminUserListItemStruct({
  String? id,
  String? nickname,
  String? accountTypeLabel,
  String? createdAt,
  String? kycStatus,
  String? isActive,
  String? lastLoginAt,
  String? extraValue,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AdminUserListItemStruct(
      id: id,
      nickname: nickname,
      accountTypeLabel: accountTypeLabel,
      createdAt: createdAt,
      kycStatus: kycStatus,
      isActive: isActive,
      lastLoginAt: lastLoginAt,
      extraValue: extraValue,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AdminUserListItemStruct? updateAdminUserListItemStruct(
  AdminUserListItemStruct? adminUserListItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    adminUserListItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAdminUserListItemStructData(
  Map<String, dynamic> firestoreData,
  AdminUserListItemStruct? adminUserListItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (adminUserListItem == null) {
    return;
  }
  if (adminUserListItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && adminUserListItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final adminUserListItemData =
      getAdminUserListItemFirestoreData(adminUserListItem, forFieldValue);
  final nestedData =
      adminUserListItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = adminUserListItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAdminUserListItemFirestoreData(
  AdminUserListItemStruct? adminUserListItem, [
  bool forFieldValue = false,
]) {
  if (adminUserListItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(adminUserListItem.toMap());

  // Add any Firestore field values
  mapToFirestore(adminUserListItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAdminUserListItemListFirestoreData(
  List<AdminUserListItemStruct>? adminUserListItems,
) =>
    adminUserListItems
        ?.map((e) => getAdminUserListItemFirestoreData(e, true))
        .toList() ??
    [];
