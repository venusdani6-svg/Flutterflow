import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _navIndex = '0';
  String get navIndex => _navIndex;
  set navIndex(String value) {
    _navIndex = value;
  }

  List<dynamic> _guestUserList = [];
  List<dynamic> get guestUserList => _guestUserList;
  set guestUserList(List<dynamic> value) {
    _guestUserList = value;
  }

  void addToGuestUserList(dynamic value) {
    guestUserList.add(value);
  }

  void removeFromGuestUserList(dynamic value) {
    guestUserList.remove(value);
  }

  void removeAtIndexFromGuestUserList(int index) {
    guestUserList.removeAt(index);
  }

  void updateGuestUserListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    guestUserList[index] = updateFn(_guestUserList[index]);
  }

  void insertAtIndexInGuestUserList(int index, dynamic value) {
    guestUserList.insert(index, value);
  }

  /// 2026.01.01
  DateTime? _filterCreatedAfter =
      DateTime.fromMillisecondsSinceEpoch(1784208540000);
  DateTime? get filterCreatedAfter => _filterCreatedAfter;
  set filterCreatedAfter(DateTime? value) {
    _filterCreatedAfter = value;
  }

  DateTime? _filterCreatedBefore =
      DateTime.fromMillisecondsSinceEpoch(1784294940000);
  DateTime? get filterCreatedBefore => _filterCreatedBefore;
  set filterCreatedBefore(DateTime? value) {
    _filterCreatedBefore = value;
  }

  List<String> _guestUserListCursors = [];
  List<String> get guestUserListCursors => _guestUserListCursors;
  set guestUserListCursors(List<String> value) {
    _guestUserListCursors = value;
  }

  void addToGuestUserListCursors(String value) {
    guestUserListCursors.add(value);
  }

  void removeFromGuestUserListCursors(String value) {
    guestUserListCursors.remove(value);
  }

  void removeAtIndexFromGuestUserListCursors(int index) {
    guestUserListCursors.removeAt(index);
  }

  void updateGuestUserListCursorsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    guestUserListCursors[index] = updateFn(_guestUserListCursors[index]);
  }

  void insertAtIndexInGuestUserListCursors(int index, String value) {
    guestUserListCursors.insert(index, value);
  }

  String _activeAccountType = '';
  String get activeAccountType => _activeAccountType;
  set activeAccountType(String value) {
    _activeAccountType = value;
  }

  bool _activeIsFrozen = false;
  bool get activeIsFrozen => _activeIsFrozen;
  set activeIsFrozen(bool value) {
    _activeIsFrozen = value;
  }

  String _activeKycStatus = '';
  String get activeKycStatus => _activeKycStatus;
  set activeKycStatus(String value) {
    _activeKycStatus = value;
  }

  String _activePrefecture = '';
  String get activePrefecture => _activePrefecture;
  set activePrefecture(String value) {
    _activePrefecture = value;
  }

  String _activeCreatedAfter = '';
  String get activeCreatedAfter => _activeCreatedAfter;
  set activeCreatedAfter(String value) {
    _activeCreatedAfter = value;
  }

  String _activeCreatedBefore = '';
  String get activeCreatedBefore => _activeCreatedBefore;
  set activeCreatedBefore(String value) {
    _activeCreatedBefore = value;
  }

  String _currentOffset = '';
  String get currentOffset => _currentOffset;
  set currentOffset(String value) {
    _currentOffset = value;
  }

  String _activeNicknamePrefix = '';
  String get activeNicknamePrefix => _activeNicknamePrefix;
  set activeNicknamePrefix(String value) {
    _activeNicknamePrefix = value;
  }

  List<dynamic> _kycUserList = [];
  List<dynamic> get kycUserList => _kycUserList;
  set kycUserList(List<dynamic> value) {
    _kycUserList = value;
  }

  void addToKycUserList(dynamic value) {
    kycUserList.add(value);
  }

  void removeFromKycUserList(dynamic value) {
    kycUserList.remove(value);
  }

  void removeAtIndexFromKycUserList(int index) {
    kycUserList.removeAt(index);
  }

  void updateKycUserListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    kycUserList[index] = updateFn(_kycUserList[index]);
  }

  void insertAtIndexInKycUserList(int index, dynamic value) {
    kycUserList.insert(index, value);
  }

  String _kycReviewActiveStatus = 'submitted';
  String get kycReviewActiveStatus => _kycReviewActiveStatus;
  set kycReviewActiveStatus(String value) {
    _kycReviewActiveStatus = value;
  }

  List<String> _kycUserListCursors = [];
  List<String> get kycUserListCursors => _kycUserListCursors;
  set kycUserListCursors(List<String> value) {
    _kycUserListCursors = value;
  }

  void addToKycUserListCursors(String value) {
    kycUserListCursors.add(value);
  }

  void removeFromKycUserListCursors(String value) {
    kycUserListCursors.remove(value);
  }

  void removeAtIndexFromKycUserListCursors(int index) {
    kycUserListCursors.removeAt(index);
  }

  void updateKycUserListCursorsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    kycUserListCursors[index] = updateFn(_kycUserListCursors[index]);
  }

  void insertAtIndexInKycUserListCursors(int index, String value) {
    kycUserListCursors.insert(index, value);
  }

  String _kycCurrentOffset = '';
  String get kycCurrentOffset => _kycCurrentOffset;
  set kycCurrentOffset(String value) {
    _kycCurrentOffset = value;
  }

  String _debugKycRaw = '';
  String get debugKycRaw => _debugKycRaw;
  set debugKycRaw(String value) {
    _debugKycRaw = value;
  }

  String _activeReservationStatusFilter = '';
  String get activeReservationStatusFilter => _activeReservationStatusFilter;
  set activeReservationStatusFilter(String value) {
    _activeReservationStatusFilter = value;
  }

  String _activeReservationScheduledAfter = '';
  String get activeReservationScheduledAfter =>
      _activeReservationScheduledAfter;
  set activeReservationScheduledAfter(String value) {
    _activeReservationScheduledAfter = value;
  }

  String _activeReservationScheduledBefore = '';
  String get activeReservationScheduledBefore =>
      _activeReservationScheduledBefore;
  set activeReservationScheduledBefore(String value) {
    _activeReservationScheduledBefore = value;
  }

  List<dynamic> _reservationList = [];
  List<dynamic> get reservationList => _reservationList;
  set reservationList(List<dynamic> value) {
    _reservationList = value;
  }

  void addToReservationList(dynamic value) {
    reservationList.add(value);
  }

  void removeFromReservationList(dynamic value) {
    reservationList.remove(value);
  }

  void removeAtIndexFromReservationList(int index) {
    reservationList.removeAt(index);
  }

  void updateReservationListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    reservationList[index] = updateFn(_reservationList[index]);
  }

  void insertAtIndexInReservationList(int index, dynamic value) {
    reservationList.insert(index, value);
  }

  List<String> _reservationListCursors = [];
  List<String> get reservationListCursors => _reservationListCursors;
  set reservationListCursors(List<String> value) {
    _reservationListCursors = value;
  }

  void addToReservationListCursors(String value) {
    reservationListCursors.add(value);
  }

  void removeFromReservationListCursors(String value) {
    reservationListCursors.remove(value);
  }

  void removeAtIndexFromReservationListCursors(int index) {
    reservationListCursors.removeAt(index);
  }

  void updateReservationListCursorsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    reservationListCursors[index] = updateFn(_reservationListCursors[index]);
  }

  void insertAtIndexInReservationListCursors(int index, String value) {
    reservationListCursors.insert(index, value);
  }

  String _reservationCurrentOffset = '';
  String get reservationCurrentOffset => _reservationCurrentOffset;
  set reservationCurrentOffset(String value) {
    _reservationCurrentOffset = value;
  }

  List<dynamic> _ledgerList = [];
  List<dynamic> get ledgerList => _ledgerList;
  set ledgerList(List<dynamic> value) {
    _ledgerList = value;
  }

  void addToLedgerList(dynamic value) {
    ledgerList.add(value);
  }

  void removeFromLedgerList(dynamic value) {
    ledgerList.remove(value);
  }

  void removeAtIndexFromLedgerList(int index) {
    ledgerList.removeAt(index);
  }

  void updateLedgerListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    ledgerList[index] = updateFn(_ledgerList[index]);
  }

  void insertAtIndexInLedgerList(int index, dynamic value) {
    ledgerList.insert(index, value);
  }

  String _activeLedgerTypeFilter = '';
  String get activeLedgerTypeFilter => _activeLedgerTypeFilter;
  set activeLedgerTypeFilter(String value) {
    _activeLedgerTypeFilter = value;
  }

  String _activeLedgerStatusFilter = '';
  String get activeLedgerStatusFilter => _activeLedgerStatusFilter;
  set activeLedgerStatusFilter(String value) {
    _activeLedgerStatusFilter = value;
  }

  String _activeLedgerCreatedAfter = '';
  String get activeLedgerCreatedAfter => _activeLedgerCreatedAfter;
  set activeLedgerCreatedAfter(String value) {
    _activeLedgerCreatedAfter = value;
  }

  String _activeLedgerCreatedBefore = '';
  String get activeLedgerCreatedBefore => _activeLedgerCreatedBefore;
  set activeLedgerCreatedBefore(String value) {
    _activeLedgerCreatedBefore = value;
  }

  List<dynamic> _paymentList = [];
  List<dynamic> get paymentList => _paymentList;
  set paymentList(List<dynamic> value) {
    _paymentList = value;
  }

  void addToPaymentList(dynamic value) {
    paymentList.add(value);
  }

  void removeFromPaymentList(dynamic value) {
    paymentList.remove(value);
  }

  void removeAtIndexFromPaymentList(int index) {
    paymentList.removeAt(index);
  }

  void updatePaymentListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    paymentList[index] = updateFn(_paymentList[index]);
  }

  void insertAtIndexInPaymentList(int index, dynamic value) {
    paymentList.insert(index, value);
  }

  List<dynamic> _stripeLogList = [];
  List<dynamic> get stripeLogList => _stripeLogList;
  set stripeLogList(List<dynamic> value) {
    _stripeLogList = value;
  }

  void addToStripeLogList(dynamic value) {
    stripeLogList.add(value);
  }

  void removeFromStripeLogList(dynamic value) {
    stripeLogList.remove(value);
  }

  void removeAtIndexFromStripeLogList(int index) {
    stripeLogList.removeAt(index);
  }

  void updateStripeLogListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    stripeLogList[index] = updateFn(_stripeLogList[index]);
  }

  void insertAtIndexInStripeLogList(int index, dynamic value) {
    stripeLogList.insert(index, value);
  }

  String _activeStripeLogEventTypeFilter = '';
  String get activeStripeLogEventTypeFilter => _activeStripeLogEventTypeFilter;
  set activeStripeLogEventTypeFilter(String value) {
    _activeStripeLogEventTypeFilter = value;
  }

  String _activeStripeLogResIdFilter = '';
  String get activeStripeLogResIdFilter => _activeStripeLogResIdFilter;
  set activeStripeLogResIdFilter(String value) {
    _activeStripeLogResIdFilter = value;
  }

  String _activeStripeLogCreatedBefore = '';
  String get activeStripeLogCreatedBefore => _activeStripeLogCreatedBefore;
  set activeStripeLogCreatedBefore(String value) {
    _activeStripeLogCreatedBefore = value;
  }

  String _activeStripeLogCreatedAfter = '';
  String get activeStripeLogCreatedAfter => _activeStripeLogCreatedAfter;
  set activeStripeLogCreatedAfter(String value) {
    _activeStripeLogCreatedAfter = value;
  }

  List<dynamic> _payoutRequestList = [];
  List<dynamic> get payoutRequestList => _payoutRequestList;
  set payoutRequestList(List<dynamic> value) {
    _payoutRequestList = value;
  }

  void addToPayoutRequestList(dynamic value) {
    payoutRequestList.add(value);
  }

  void removeFromPayoutRequestList(dynamic value) {
    payoutRequestList.remove(value);
  }

  void removeAtIndexFromPayoutRequestList(int index) {
    payoutRequestList.removeAt(index);
  }

  void updatePayoutRequestListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    payoutRequestList[index] = updateFn(_payoutRequestList[index]);
  }

  void insertAtIndexInPayoutRequestList(int index, dynamic value) {
    payoutRequestList.insert(index, value);
  }

  String _activePayoutStatusFilter = '';
  String get activePayoutStatusFilter => _activePayoutStatusFilter;
  set activePayoutStatusFilter(String value) {
    _activePayoutStatusFilter = value;
  }
}
