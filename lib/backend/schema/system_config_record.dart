import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SystemConfigRecord extends FirestoreRecord {
  SystemConfigRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "tax_rate" field.
  double? _taxRate;
  double get taxRate => _taxRate ?? 0.0;
  bool hasTaxRate() => _taxRate != null;

  // "default_affiliate_rate" field.
  double? _defaultAffiliateRate;
  double get defaultAffiliateRate => _defaultAffiliateRate ?? 0.0;
  bool hasDefaultAffiliateRate() => _defaultAffiliateRate != null;

  // "features_enabled" field.
  FeaturesEnabledStruct? _featuresEnabled;
  FeaturesEnabledStruct get featuresEnabled =>
      _featuresEnabled ?? FeaturesEnabledStruct();
  bool hasFeaturesEnabled() => _featuresEnabled != null;

  // "updated_at" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  bool hasUpdatedAt() => _updatedAt != null;

  void _initializeFields() {
    _taxRate = castToType<double>(snapshotData['tax_rate']);
    _defaultAffiliateRate =
        castToType<double>(snapshotData['default_affiliate_rate']);
    _featuresEnabled = snapshotData['features_enabled'] is FeaturesEnabledStruct
        ? snapshotData['features_enabled']
        : FeaturesEnabledStruct.maybeFromMap(snapshotData['features_enabled']);
    _updatedAt = snapshotData['updated_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('system_config');

  static Stream<SystemConfigRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SystemConfigRecord.fromSnapshot(s));

  static Future<SystemConfigRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SystemConfigRecord.fromSnapshot(s));

  static SystemConfigRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SystemConfigRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SystemConfigRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SystemConfigRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SystemConfigRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SystemConfigRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSystemConfigRecordData({
  double? taxRate,
  double? defaultAffiliateRate,
  FeaturesEnabledStruct? featuresEnabled,
  DateTime? updatedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'tax_rate': taxRate,
      'default_affiliate_rate': defaultAffiliateRate,
      'features_enabled': FeaturesEnabledStruct().toMap(),
      'updated_at': updatedAt,
    }.withoutNulls,
  );

  // Handle nested data for "features_enabled" field.
  addFeaturesEnabledStructData(
      firestoreData, featuresEnabled, 'features_enabled');

  return firestoreData;
}

class SystemConfigRecordDocumentEquality
    implements Equality<SystemConfigRecord> {
  const SystemConfigRecordDocumentEquality();

  @override
  bool equals(SystemConfigRecord? e1, SystemConfigRecord? e2) {
    return e1?.taxRate == e2?.taxRate &&
        e1?.defaultAffiliateRate == e2?.defaultAffiliateRate &&
        e1?.featuresEnabled == e2?.featuresEnabled &&
        e1?.updatedAt == e2?.updatedAt;
  }

  @override
  int hash(SystemConfigRecord? e) => const ListEquality().hash(
      [e?.taxRate, e?.defaultAffiliateRate, e?.featuresEnabled, e?.updatedAt]);

  @override
  bool isValidKey(Object? o) => o is SystemConfigRecord;
}
