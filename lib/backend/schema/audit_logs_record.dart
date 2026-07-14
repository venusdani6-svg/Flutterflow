import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AuditLogsRecord extends FirestoreRecord {
  AuditLogsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "admin_id" field.
  String? _adminId;
  String get adminId => _adminId ?? '';
  bool hasAdminId() => _adminId != null;

  // "action" field.
  String? _action;
  String get action => _action ?? '';
  bool hasAction() => _action != null;

  // "target_type" field.
  String? _targetType;
  String get targetType => _targetType ?? '';
  bool hasTargetType() => _targetType != null;

  // "target_id" field.
  String? _targetId;
  String get targetId => _targetId ?? '';
  bool hasTargetId() => _targetId != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  bool hasReason() => _reason != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _adminId = snapshotData['admin_id'] as String?;
    _action = snapshotData['action'] as String?;
    _targetType = snapshotData['target_type'] as String?;
    _targetId = snapshotData['target_id'] as String?;
    _reason = snapshotData['reason'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('audit_logs');

  static Stream<AuditLogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AuditLogsRecord.fromSnapshot(s));

  static Future<AuditLogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AuditLogsRecord.fromSnapshot(s));

  static AuditLogsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AuditLogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AuditLogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AuditLogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AuditLogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AuditLogsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAuditLogsRecordData({
  String? adminId,
  String? action,
  String? targetType,
  String? targetId,
  String? reason,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'admin_id': adminId,
      'action': action,
      'target_type': targetType,
      'target_id': targetId,
      'reason': reason,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class AuditLogsRecordDocumentEquality implements Equality<AuditLogsRecord> {
  const AuditLogsRecordDocumentEquality();

  @override
  bool equals(AuditLogsRecord? e1, AuditLogsRecord? e2) {
    return e1?.adminId == e2?.adminId &&
        e1?.action == e2?.action &&
        e1?.targetType == e2?.targetType &&
        e1?.targetId == e2?.targetId &&
        e1?.reason == e2?.reason &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(AuditLogsRecord? e) => const ListEquality().hash([
        e?.adminId,
        e?.action,
        e?.targetType,
        e?.targetId,
        e?.reason,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is AuditLogsRecord;
}
