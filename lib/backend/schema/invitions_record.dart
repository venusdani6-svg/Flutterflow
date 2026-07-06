import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvitionsRecord extends FirestoreRecord {
  InvitionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "token" field.
  String? _token;
  String get token => _token ?? '';
  bool hasToken() => _token != null;

  // "is_used" field.
  bool? _isUsed;
  bool get isUsed => _isUsed ?? false;
  bool hasIsUsed() => _isUsed != null;

  // "expires_at" field.
  DateTime? _expiresAt;
  DateTime? get expiresAt => _expiresAt;
  bool hasExpiresAt() => _expiresAt != null;

  // "role_admin" field.
  String? _roleAdmin;
  String get roleAdmin => _roleAdmin ?? '';
  bool hasRoleAdmin() => _roleAdmin != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _token = snapshotData['token'] as String?;
    _isUsed = snapshotData['is_used'] as bool?;
    _expiresAt = snapshotData['expires_at'] as DateTime?;
    _roleAdmin = snapshotData['role_admin'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('invitions');

  static Stream<InvitionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InvitionsRecord.fromSnapshot(s));

  static Future<InvitionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => InvitionsRecord.fromSnapshot(s));

  static InvitionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InvitionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InvitionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InvitionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InvitionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InvitionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInvitionsRecordData({
  String? email,
  String? token,
  bool? isUsed,
  DateTime? expiresAt,
  String? roleAdmin,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'token': token,
      'is_used': isUsed,
      'expires_at': expiresAt,
      'role_admin': roleAdmin,
    }.withoutNulls,
  );

  return firestoreData;
}

class InvitionsRecordDocumentEquality implements Equality<InvitionsRecord> {
  const InvitionsRecordDocumentEquality();

  @override
  bool equals(InvitionsRecord? e1, InvitionsRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.token == e2?.token &&
        e1?.isUsed == e2?.isUsed &&
        e1?.expiresAt == e2?.expiresAt &&
        e1?.roleAdmin == e2?.roleAdmin;
  }

  @override
  int hash(InvitionsRecord? e) => const ListEquality()
      .hash([e?.email, e?.token, e?.isUsed, e?.expiresAt, e?.roleAdmin]);

  @override
  bool isValidKey(Object? o) => o is InvitionsRecord;
}
