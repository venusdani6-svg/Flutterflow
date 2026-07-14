import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AffiliateRewardsRecord extends FirestoreRecord {
  AffiliateRewardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "affiliator_uid" field.
  String? _affiliatorUid;
  String get affiliatorUid => _affiliatorUid ?? '';
  bool hasAffiliatorUid() => _affiliatorUid != null;

  // "month" field.
  String? _month;
  String get month => _month ?? '';
  bool hasMonth() => _month != null;

  // "reward_amount" field.
  int? _rewardAmount;
  int get rewardAmount => _rewardAmount ?? 0;
  bool hasRewardAmount() => _rewardAmount != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  void _initializeFields() {
    _affiliatorUid = snapshotData['affiliator_uid'] as String?;
    _month = snapshotData['month'] as String?;
    _rewardAmount = castToType<int>(snapshotData['reward_amount']);
    _status = snapshotData['status'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('affiliate_rewards');

  static Stream<AffiliateRewardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AffiliateRewardsRecord.fromSnapshot(s));

  static Future<AffiliateRewardsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AffiliateRewardsRecord.fromSnapshot(s));

  static AffiliateRewardsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AffiliateRewardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AffiliateRewardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AffiliateRewardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AffiliateRewardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AffiliateRewardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAffiliateRewardsRecordData({
  String? affiliatorUid,
  String? month,
  int? rewardAmount,
  String? status,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'affiliator_uid': affiliatorUid,
      'month': month,
      'reward_amount': rewardAmount,
      'status': status,
    }.withoutNulls,
  );

  return firestoreData;
}

class AffiliateRewardsRecordDocumentEquality
    implements Equality<AffiliateRewardsRecord> {
  const AffiliateRewardsRecordDocumentEquality();

  @override
  bool equals(AffiliateRewardsRecord? e1, AffiliateRewardsRecord? e2) {
    return e1?.affiliatorUid == e2?.affiliatorUid &&
        e1?.month == e2?.month &&
        e1?.rewardAmount == e2?.rewardAmount &&
        e1?.status == e2?.status;
  }

  @override
  int hash(AffiliateRewardsRecord? e) => const ListEquality()
      .hash([e?.affiliatorUid, e?.month, e?.rewardAmount, e?.status]);

  @override
  bool isValidKey(Object? o) => o is AffiliateRewardsRecord;
}
