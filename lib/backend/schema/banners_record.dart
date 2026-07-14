import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BannersRecord extends FirestoreRecord {
  BannersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "link_url" field.
  String? _linkUrl;
  String get linkUrl => _linkUrl ?? '';
  bool hasLinkUrl() => _linkUrl != null;

  // "page" field.
  String? _page;
  String get page => _page ?? '';
  bool hasPage() => _page != null;

  // "display_order" field.
  int? _displayOrder;
  int get displayOrder => _displayOrder ?? 0;
  bool hasDisplayOrder() => _displayOrder != null;

  // "active" field.
  bool? _active;
  bool get active => _active ?? false;
  bool hasActive() => _active != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _imageUrl = snapshotData['image_url'] as String?;
    _linkUrl = snapshotData['link_url'] as String?;
    _page = snapshotData['page'] as String?;
    _displayOrder = castToType<int>(snapshotData['display_order']);
    _active = snapshotData['active'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('banners');

  static Stream<BannersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BannersRecord.fromSnapshot(s));

  static Future<BannersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BannersRecord.fromSnapshot(s));

  static BannersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BannersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BannersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BannersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BannersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BannersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBannersRecordData({
  String? title,
  String? imageUrl,
  String? linkUrl,
  String? page,
  int? displayOrder,
  bool? active,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'image_url': imageUrl,
      'link_url': linkUrl,
      'page': page,
      'display_order': displayOrder,
      'active': active,
    }.withoutNulls,
  );

  return firestoreData;
}

class BannersRecordDocumentEquality implements Equality<BannersRecord> {
  const BannersRecordDocumentEquality();

  @override
  bool equals(BannersRecord? e1, BannersRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.linkUrl == e2?.linkUrl &&
        e1?.page == e2?.page &&
        e1?.displayOrder == e2?.displayOrder &&
        e1?.active == e2?.active;
  }

  @override
  int hash(BannersRecord? e) => const ListEquality().hash(
      [e?.title, e?.imageUrl, e?.linkUrl, e?.page, e?.displayOrder, e?.active]);

  @override
  bool isValidKey(Object? o) => o is BannersRecord;
}
