import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatRoomsRecord extends FirestoreRecord {
  ChatRoomsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "res_id" field.
  String? _resId;
  String get resId => _resId ?? '';
  bool hasResId() => _resId != null;

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  bool hasActive() => _active != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _resId = snapshotData['res_id'] as String?;
    _active = snapshotData['active'] as bool?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chat_rooms');

  static Stream<ChatRoomsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatRoomsRecord.fromSnapshot(s));

  static Future<ChatRoomsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatRoomsRecord.fromSnapshot(s));

  static ChatRoomsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatRoomsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatRoomsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatRoomsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatRoomsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatRoomsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatRoomsRecordData({
  String? resId,
  bool? active,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'res_id': resId,
      'active': active,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatRoomsRecordDocumentEquality implements Equality<ChatRoomsRecord> {
  const ChatRoomsRecordDocumentEquality();

  @override
  bool equals(ChatRoomsRecord? e1, ChatRoomsRecord? e2) {
    return e1?.resId == e2?.resId &&
        e1?.active == e2?.active &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(ChatRoomsRecord? e) =>
      const ListEquality().hash([e?.resId, e?.active, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is ChatRoomsRecord;
}
