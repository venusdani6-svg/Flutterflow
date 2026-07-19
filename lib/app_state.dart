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
}
