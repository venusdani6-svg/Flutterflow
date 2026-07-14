import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CocotenShopsRecord extends FirestoreRecord {
  CocotenShopsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "prefecture" field.
  String? _prefecture;
  String get prefecture => _prefecture ?? '';
  bool hasPrefecture() => _prefecture != null;

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  bool hasActive() => _active != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _prefecture = snapshotData['prefecture'] as String?;
    _active = snapshotData['active'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cocoten_shops');

  static Stream<CocotenShopsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CocotenShopsRecord.fromSnapshot(s));

  static Future<CocotenShopsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CocotenShopsRecord.fromSnapshot(s));

  static CocotenShopsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CocotenShopsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CocotenShopsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CocotenShopsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CocotenShopsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CocotenShopsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCocotenShopsRecordData({
  String? name,
  String? prefecture,
  bool? active,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'prefecture': prefecture,
      'active': active,
    }.withoutNulls,
  );

  return firestoreData;
}

class CocotenShopsRecordDocumentEquality
    implements Equality<CocotenShopsRecord> {
  const CocotenShopsRecordDocumentEquality();

  @override
  bool equals(CocotenShopsRecord? e1, CocotenShopsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.prefecture == e2?.prefecture &&
        e1?.active == e2?.active;
  }

  @override
  int hash(CocotenShopsRecord? e) =>
      const ListEquality().hash([e?.name, e?.prefecture, e?.active]);

  @override
  bool isValidKey(Object? o) => o is CocotenShopsRecord;
}
