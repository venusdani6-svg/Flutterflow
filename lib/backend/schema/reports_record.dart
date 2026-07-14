import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReportsRecord extends FirestoreRecord {
  ReportsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "reporter_id" field.
  String? _reporterId;
  String get reporterId => _reporterId ?? '';
  bool hasReporterId() => _reporterId != null;

  // "reported_id" field.
  String? _reportedId;
  String get reportedId => _reportedId ?? '';
  bool hasReportedId() => _reportedId != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  bool hasReason() => _reason != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "admin_note" field.
  String? _adminNote;
  String get adminNote => _adminNote ?? '';
  bool hasAdminNote() => _adminNote != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _reporterId = snapshotData['reporter_id'] as String?;
    _reportedId = snapshotData['reported_id'] as String?;
    _reason = snapshotData['reason'] as String?;
    _status = snapshotData['status'] as String?;
    _adminNote = snapshotData['admin_note'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reports');

  static Stream<ReportsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReportsRecord.fromSnapshot(s));

  static Future<ReportsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReportsRecord.fromSnapshot(s));

  static ReportsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReportsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReportsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReportsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReportsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReportsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReportsRecordData({
  String? reporterId,
  String? reportedId,
  String? reason,
  String? status,
  String? adminNote,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'reporter_id': reporterId,
      'reported_id': reportedId,
      'reason': reason,
      'status': status,
      'admin_note': adminNote,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReportsRecordDocumentEquality implements Equality<ReportsRecord> {
  const ReportsRecordDocumentEquality();

  @override
  bool equals(ReportsRecord? e1, ReportsRecord? e2) {
    return e1?.reporterId == e2?.reporterId &&
        e1?.reportedId == e2?.reportedId &&
        e1?.reason == e2?.reason &&
        e1?.status == e2?.status &&
        e1?.adminNote == e2?.adminNote &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(ReportsRecord? e) => const ListEquality().hash([
        e?.reporterId,
        e?.reportedId,
        e?.reason,
        e?.status,
        e?.adminNote,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is ReportsRecord;
}
