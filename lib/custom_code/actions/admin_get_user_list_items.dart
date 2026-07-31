// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<dynamic> adminGetUserListItems(
  String? accountType,
  String? nicknamePrefix,
) async {
  try {
    dynamic result;
    if (accountType == 'admin') {
      result = await adminGetUsers(
        '',
        '',
        false,
        '',
        '',
        '',
        '',
        nicknamePrefix ?? '',
        300,
        '',
        '',
        true,
      );
    } else {
      result = await adminGetUsers(
        'cast',
        '',
        false,
        '',
        '',
        '',
        '',
        nicknamePrefix ?? '',
        200,
        '',
        '',
        true,
      );
    }
    final data =
        result is Map ? Map<String, dynamic>.from(result) : <String, dynamic>{};
    final usersRaw = data['users'];
    if (usersRaw is! List) return <AdminUserListItemStruct>[];
    var users = usersRaw
        .whereType<Map>()
        .map((u) => Map<String, dynamic>.from(u))
        .toList();
    if (accountType == 'cast') {
      users = users.where((u) => !_isStaffType(u['staff_type'])).toList();
    } else if (accountType == 'staff') {
      users = users.where((u) => _isStaffType(u['staff_type'])).toList();
    } else if (accountType == 'admin') {
      users = users.where((u) => u['role'] == 'admin').toList();
    }
    return users.map((u) => _toAdminUserListItem(u, accountType)).toList();
  } catch (e) {
    return <AdminUserListItemStruct>[];
  }
}

bool _isStaffType(dynamic value) {
  final s = value?.toString() ?? '';
  return s.isNotEmpty && s != 'none';
}

AdminUserListItemStruct _toAdminUserListItem(
  Map<String, dynamic> u,
  String? accountType,
) {
  var typeLabel = '';
  var extra = '';
  if (accountType == 'cast') {
    typeLabel = 'キャストユーザー';
    final debt = u['logical_debt'];
    final debtNum = debt is num ? debt.round() : 0;
    extra = '$debtNum円';
  } else if (accountType == 'staff') {
    final st = u['staff_type']?.toString() ?? '';
    typeLabel = st == 'transport' ? '送迎スタッフ' : (st.isEmpty ? 'スタッフ' : st);
    extra = (u['is_online'] == true) ? 'ON' : 'OFF';
  } else {
    final pref = u['prefecture']?.toString() ?? '';
    typeLabel = pref.isEmpty ? '本社管理者' : '都道府県別管理者';
  }
  return AdminUserListItemStruct.fromMap({
    'id': u['id']?.toString() ?? '',
    'nickname': u['nickname']?.toString() ?? '',
    'account_type_label': typeLabel,
    'created_at': u['created_at']?.toString() ?? '',
    'kyc_status': u['kyc_status']?.toString() ?? '',
    'is_active': u['is_active']?.toString() ?? '',
    'last_login_at': u['last_login_at']?.toString() ?? '',
    'extra_value': extra,
  });
}
