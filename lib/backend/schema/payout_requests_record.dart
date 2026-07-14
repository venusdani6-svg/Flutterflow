import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PayoutRequestsRecord extends FirestoreRecord {
  PayoutRequestsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "amount" field.
  int? _amount;
  int get amount => _amount ?? 0;
  bool hasAmount() => _amount != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _userId = snapshotData['user_id'] as String?;
    _amount = castToType<int>(snapshotData['amount']);
    _status = snapshotData['status'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('payout_requests');

  static Stream<PayoutRequestsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PayoutRequestsRecord.fromSnapshot(s));

  static Future<PayoutRequestsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PayoutRequestsRecord.fromSnapshot(s));

  static PayoutRequestsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PayoutRequestsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PayoutRequestsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PayoutRequestsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PayoutRequestsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PayoutRequestsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPayoutRequestsRecordData({
  String? userId,
  int? amount,
  String? status,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'amount': amount,
      'status': status,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class PayoutRequestsRecordDocumentEquality
    implements Equality<PayoutRequestsRecord> {
  const PayoutRequestsRecordDocumentEquality();

  @override
  bool equals(PayoutRequestsRecord? e1, PayoutRequestsRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.amount == e2?.amount &&
        e1?.status == e2?.status &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(PayoutRequestsRecord? e) => const ListEquality()
      .hash([e?.userId, e?.amount, e?.status, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is PayoutRequestsRecord;
}
