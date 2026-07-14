import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "role" field.
  int? _role;
  int get role => _role ?? 0;
  bool hasRole() => _role != null;

  // "is_active" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "base_hourly_rate" field.
  int? _baseHourlyRate;
  int get baseHourlyRate => _baseHourlyRate ?? 0;
  bool hasBaseHourlyRate() => _baseHourlyRate != null;

  // "transport_config" field.
  int? _transportConfig;
  int get transportConfig => _transportConfig ?? 0;
  bool hasTransportConfig() => _transportConfig != null;

  // "average_rating" field.
  double? _averageRating;
  double get averageRating => _averageRating ?? 0.0;
  bool hasAverageRating() => _averageRating != null;

  // "prefile_image" field.
  String? _prefileImage;
  String get prefileImage => _prefileImage ?? '';
  bool hasPrefileImage() => _prefileImage != null;

  // "role_admin" field.
  String? _roleAdmin;
  String get roleAdmin => _roleAdmin ?? '';
  bool hasRoleAdmin() => _roleAdmin != null;

  // "account_type" field.
  String? _accountType;
  String get accountType => _accountType ?? '';
  bool hasAccountType() => _accountType != null;

  // "approval_status" field.
  String? _approvalStatus;
  String get approvalStatus => _approvalStatus ?? '';
  bool hasApprovalStatus() => _approvalStatus != null;

  // "kyc_status" field.
  String? _kycStatus;
  String get kycStatus => _kycStatus ?? '';
  bool hasKycStatus() => _kycStatus != null;

  // "kyc_doc_url" field.
  String? _kycDocUrl;
  String get kycDocUrl => _kycDocUrl ?? '';
  bool hasKycDocUrl() => _kycDocUrl != null;

  // "kyc_selfie_url" field.
  String? _kycSelfieUrl;
  String get kycSelfieUrl => _kycSelfieUrl ?? '';
  bool hasKycSelfieUrl() => _kycSelfieUrl != null;

  // "is_verified" field.
  bool? _isVerified;
  bool get isVerified => _isVerified ?? false;
  bool hasIsVerified() => _isVerified != null;

  // "is_frozen" field.
  bool? _isFrozen;
  bool get isFrozen => _isFrozen ?? false;
  bool hasIsFrozen() => _isFrozen != null;

  // "affiliate_rate" field.
  double? _affiliateRate;
  double get affiliateRate => _affiliateRate ?? 0.0;
  bool hasAffiliateRate() => _affiliateRate != null;

  // "stripe_account_id" field.
  String? _stripeAccountId;
  String get stripeAccountId => _stripeAccountId ?? '';
  bool hasStripeAccountId() => _stripeAccountId != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _role = castToType<int>(snapshotData['role']);
    _isActive = snapshotData['is_active'] as bool?;
    _baseHourlyRate = castToType<int>(snapshotData['base_hourly_rate']);
    _transportConfig = castToType<int>(snapshotData['transport_config']);
    _averageRating = castToType<double>(snapshotData['average_rating']);
    _prefileImage = snapshotData['prefile_image'] as String?;
    _roleAdmin = snapshotData['role_admin'] as String?;
    _accountType = snapshotData['account_type'] as String?;
    _approvalStatus = snapshotData['approval_status'] as String?;
    _kycStatus = snapshotData['kyc_status'] as String?;
    _kycDocUrl = snapshotData['kyc_doc_url'] as String?;
    _kycSelfieUrl = snapshotData['kyc_selfie_url'] as String?;
    _isVerified = snapshotData['is_verified'] as bool?;
    _isFrozen = snapshotData['is_frozen'] as bool?;
    _affiliateRate = castToType<double>(snapshotData['affiliate_rate']);
    _stripeAccountId = snapshotData['stripe_account_id'] as String?;
    _updatedAt = snapshotData['updated_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  int? role,
  bool? isActive,
  int? baseHourlyRate,
  int? transportConfig,
  double? averageRating,
  String? prefileImage,
  String? roleAdmin,
  String? accountType,
  String? approvalStatus,
  String? kycStatus,
  String? kycDocUrl,
  String? kycSelfieUrl,
  bool? isVerified,
  bool? isFrozen,
  double? affiliateRate,
  String? stripeAccountId,
  DateTime? updatedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'role': role,
      'is_active': isActive,
      'base_hourly_rate': baseHourlyRate,
      'transport_config': transportConfig,
      'average_rating': averageRating,
      'prefile_image': prefileImage,
      'role_admin': roleAdmin,
      'account_type': accountType,
      'approval_status': approvalStatus,
      'kyc_status': kycStatus,
      'kyc_doc_url': kycDocUrl,
      'kyc_selfie_url': kycSelfieUrl,
      'is_verified': isVerified,
      'is_frozen': isFrozen,
      'affiliate_rate': affiliateRate,
      'stripe_account_id': stripeAccountId,
      'updated_at': updatedAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.role == e2?.role &&
        e1?.isActive == e2?.isActive &&
        e1?.baseHourlyRate == e2?.baseHourlyRate &&
        e1?.transportConfig == e2?.transportConfig &&
        e1?.averageRating == e2?.averageRating &&
        e1?.prefileImage == e2?.prefileImage &&
        e1?.roleAdmin == e2?.roleAdmin &&
        e1?.accountType == e2?.accountType &&
        e1?.approvalStatus == e2?.approvalStatus &&
        e1?.kycStatus == e2?.kycStatus &&
        e1?.kycDocUrl == e2?.kycDocUrl &&
        e1?.kycSelfieUrl == e2?.kycSelfieUrl &&
        e1?.isVerified == e2?.isVerified &&
        e1?.isFrozen == e2?.isFrozen &&
        e1?.affiliateRate == e2?.affiliateRate &&
        e1?.stripeAccountId == e2?.stripeAccountId &&
        e1?.updatedAt == e2?.updatedAt;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.role,
        e?.isActive,
        e?.baseHourlyRate,
        e?.transportConfig,
        e?.averageRating,
        e?.prefileImage,
        e?.roleAdmin,
        e?.accountType,
        e?.approvalStatus,
        e?.kycStatus,
        e?.kycDocUrl,
        e?.kycSelfieUrl,
        e?.isVerified,
        e?.isFrozen,
        e?.affiliateRate,
        e?.stripeAccountId,
        e?.updatedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
