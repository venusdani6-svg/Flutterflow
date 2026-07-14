import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StripeLogsRecord extends FirestoreRecord {
  StripeLogsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "res_id" field.
  String? _resId;
  String get resId => _resId ?? '';
  bool hasResId() => _resId != null;

  // "event_type" field.
  String? _eventType;
  String get eventType => _eventType ?? '';
  bool hasEventType() => _eventType != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _resId = snapshotData['res_id'] as String?;
    _eventType = snapshotData['event_type'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('stripe_logs');

  static Stream<StripeLogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StripeLogsRecord.fromSnapshot(s));

  static Future<StripeLogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StripeLogsRecord.fromSnapshot(s));

  static StripeLogsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      StripeLogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StripeLogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StripeLogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StripeLogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is StripeLogsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createStripeLogsRecordData({
  String? resId,
  String? eventType,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'res_id': resId,
      'event_type': eventType,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class StripeLogsRecordDocumentEquality implements Equality<StripeLogsRecord> {
  const StripeLogsRecordDocumentEquality();

  @override
  bool equals(StripeLogsRecord? e1, StripeLogsRecord? e2) {
    return e1?.resId == e2?.resId &&
        e1?.eventType == e2?.eventType &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(StripeLogsRecord? e) =>
      const ListEquality().hash([e?.resId, e?.eventType, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is StripeLogsRecord;
}
