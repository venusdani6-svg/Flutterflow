import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LedgerRecord extends FirestoreRecord {
  LedgerRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

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
    _type = snapshotData['type'] as String?;
    _amount = castToType<int>(snapshotData['amount']);
    _status = snapshotData['status'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ledger');

  static Stream<LedgerRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LedgerRecord.fromSnapshot(s));

  static Future<LedgerRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LedgerRecord.fromSnapshot(s));

  static LedgerRecord fromSnapshot(DocumentSnapshot snapshot) => LedgerRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LedgerRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LedgerRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LedgerRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LedgerRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLedgerRecordData({
  String? userId,
  String? type,
  int? amount,
  String? status,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'type': type,
      'amount': amount,
      'status': status,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class LedgerRecordDocumentEquality implements Equality<LedgerRecord> {
  const LedgerRecordDocumentEquality();

  @override
  bool equals(LedgerRecord? e1, LedgerRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.type == e2?.type &&
        e1?.amount == e2?.amount &&
        e1?.status == e2?.status &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(LedgerRecord? e) => const ListEquality()
      .hash([e?.userId, e?.type, e?.amount, e?.status, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is LedgerRecord;
}
