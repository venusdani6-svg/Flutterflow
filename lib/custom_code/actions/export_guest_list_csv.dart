// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:url_launcher/url_launcher.dart';

/// Builds a CSV from the guest rows currently on screen (guestUserList)
/// and triggers a browser download via a data: URL — no extra
/// file-system packages needed, works on Flutter Web.
///
/// Only exports the current page, not the full filtered result set,
/// since adminGetUsers is paginated server-side.
Future<dynamic> exportGuestListCsv(List<dynamic>? users) async {
  try {
    final rows = users ?? [];
    final headers = [
      'ニックネーム',
      '登録年月日',
      'KYC審査状況',
      'アカウント状態',
      '論理負債',
      '最終ログイン',
    ];
    final lines = <String>[headers.map(_csvEscape).join(',')];

    for (final u in rows) {
      if (u is! Map) continue;
      lines.add([
        u['nickname'],
        u['created_at'],
        u['kyc_status'],
        u['is_active'],
        u['logical_debt'],
        u['last_login_at'],
      ].map(_csvEscape).join(','));
    }

    // Excel needs a UTF-8 BOM or Japanese text renders as mojibake.
    final csv = '\uFEFF${lines.join('\r\n')}';
    final dataUrl = 'data:text/csv;charset=utf-8,${Uri.encodeComponent(csv)}';
    await launchUrl(Uri.parse(dataUrl));
    return {'success': true};
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

String _csvEscape(dynamic value) {
  final text = (value ?? '').toString();
  if (text.contains(',') || text.contains('"') || text.contains('\n')) {
    return '"${text.replaceAll('"', '""')}"';
  }
  return text;
}
