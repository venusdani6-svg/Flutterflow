import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

/// Status-dot color for ReservationdetailsPage/ReservationListPage's 11-value
/// status_label enum (admin_get_reservations.dart::_statusLabel) - §18.78.
Color? reservationStatusDotColor(String? label) {
  switch (label) {
    case '完了':
      return Color(0xFF06F705);
    case 'キャンセル':
    case '期限切れ':
      return Color(0xFFF70505);
    case 'リクエスト中':
    case '与信確保済み':
    case 'キャスト承諾待ち':
    case '確定決済済':
    case '合流待ち':
    case '交流中':
    case '完了報告待ち':
    case '評価待ち':
      return Color(0xFFF9CF58);
    default:
      return Color(0xFFB0B0B0);
  }
}

/// Status-dot color for the 有り/無し presence-boolean fields on
/// ReservationdetailsPage (group_invite_label, tipPresenceLabel,
/// thirty_min_rule_applied_label) - §18.78.
Color? presenceStatusDotColor(String? label) {
  switch (label) {
    case '有り':
      return Color(0xFF06F705);
    default:
      return Color(0xFFB0B0B0);
  }
}

/// Status-dot color for kyc_status (admin_get_users.dart::_kycStatusLabel) -
/// §18.78.
Color? kycStatusDotColor(String? label) {
  switch (label) {
    case '承認済':
      return Color(0xFF06F705);
    case '却下':
      return Color(0xFFF70505);
    case '提出済み':
    case '審査中':
      return Color(0xFFF9CF58);
    default:
      return Color(0xFFB0B0B0);
  }
}

/// Status-dot color for is_active (admin_get_users.dart) - §18.78.
Color? activeStatusDotColor(String? label) {
  switch (label) {
    case '有効':
      return Color(0xFF06F705);
    case '無効':
      return Color(0xFFF70505);
    default:
      return Color(0xFFB0B0B0);
  }
}

/// Status-dot color for WithdrawalApplicationListPage's status_label
/// (admin_get_payout_requests.dart::_payoutStatusLabel) - §18.78.
Color? payoutStatusDotColor(String? label) {
  switch (label) {
    case '承認済':
      return Color(0xFF06F705);
    case '否認':
      return Color(0xFFF70505);
    case '申請中':
    case '保留中':
      return Color(0xFFF9CF58);
    default:
      return Color(0xFFB0B0B0);
  }
}

/// Status-dot color for PaymentLedgerListPage's status_label
/// (admin_get_ledger.dart::_ledgerStatusLabel) - the client's own
/// "paid"/"pending" example, directly - §18.78.
Color? paymentStatusDotColor(String? label) {
  switch (label) {
    case '確定':
      return Color(0xFF06F705);
    case '失敗':
      return Color(0xFFF70505);
    case '保留中':
    case '再試行中':
      return Color(0xFFF9CF58);
    default:
      return Color(0xFFB0B0B0);
  }
}

/// Status-dot color for ReportListPage's status_label
/// (admin_get_reports.dart::_statusLabel) - §18.78.
Color? reportStatusDotColor(String? label) {
  switch (label) {
    case '解決済':
      return Color(0xFF06F705);
    case '却下':
      return Color(0xFFF70505);
    case '未対応':
      return Color(0xFFF9CF58);
    default:
      return Color(0xFFB0B0B0);
  }
}

/// 通報一覧の解決ボタンのラベル。「このユーザーを凍結する」チェックボックスがオンなら「凍結する」、オフなら「解決する」を返す。
String? reportResolveButtonLabel(bool? freezeUser) {
  return (freezeUser ?? false) ? '凍結する' : '解決する';
}

/// 報酬率設定タブの検索ピッカー用。adminGetAffiliateOverview の $.affiliators
/// 配列と検索クエリを受け取り、ニックネームの部分一致(大文字小文字を区別しない)でフィルタして返す。クエリが空なら全件を返す。
List<dynamic>? affiliateSearchResults(
  List<dynamic>? affiliators,
  String? query,
) {
  final list = affiliators ?? <dynamic>[];
  final q = (query ?? '').trim().toLowerCase();
  if (q.isEmpty) return list;
  return list.where((a) {
    final nickname =
        (a is Map ? a['nickname'] : null)?.toString().toLowerCase() ?? '';
    return nickname.contains(q);
  }).toList();
}

/// アフィリエイター一覧の1行分の報酬率表示。直近で保存した affiliator_uid と一致する行だけ保存直後の新しい料率を表示し、それ以外は元の
/// affiliate_rate_display を そのまま表示する(Save後にページを再読み込みせずに反映するための仕組み、§18.88)。
String? affiliateRateDisplayFor(
  dynamic item,
  String? lastChangedUid,
  String? lastChangedRateDisplay,
) {
  final map = item is Map ? item : <String, dynamic>{};
  final uid = map['affiliator_uid']?.toString() ?? '';
  if ((lastChangedUid ?? '').isNotEmpty && uid == lastChangedUid) {
    // lastChangedRateDisplay carries the rate DROPDOWN's raw widget text
    // (e.g. '10　％', full-width space + full-width percent), copied
    // verbatim at Save time - strip it down to digits-only to match
    // affiliate_rate_display's own plain-number format.
    final digitsOnly = (lastChangedRateDisplay ?? '').replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    if (digitsOnly.isNotEmpty) return digitsOnly;
  }
  return map['affiliate_rate_display']?.toString() ?? '-';
}

/// 報酬率設定タブの「オプションウィンドウ」の閉じた状態に表示するテキスト。選択済みのアフィリエイトがいればその名前、いなければ選択を促す文言を返す。
String? affiliatePickerPromptText(String? selectedNickname) {
  final s = (selectedNickname ?? '').trim();
  return s.isEmpty ? 'アフィリエイトを選択してください' : s;
}

/// Formats a cocoten shop field's current value as a small "現在の値" caption for
/// CocomiseEditDialogComp - §18.95.
///
/// Empty input (create mode, or an edit dialog field that was never set)
/// renders as an empty caption rather than a bare "現在の値: " label.
String? cocomiseCurrentValueLabel(String? value) {
  final v = (value ?? '').trim();
  return v.isEmpty ? '' : '現在の値: $v';
}

/// Status-dot color for JobBoardListPage's status_label
/// (admin_get_work_posts.dart::_workPostStatusLabel) - §18.99.
Color? workPostStatusDotColor(String? label) {
  switch (label) {
    case '募集中':
      return Color(0xFFF9CF58);
    case '採用済み':
      return Color(0xFF06F705);
    case '終了':
      return Color(0xFFB0B0B0);
    default:
      return Color(0xFFB0B0B0);
  }
}

/// Live status-dot color for a service-area toggle (提供エリア設定 tab + 都道府県一覧
/// dialog) - takes the already-loaded LOCAL_STATE bool directly (not a string
/// label like the other §18.78 dot functions, since no adjacent Text shows
/// this as a string) so the color re-evaluates on every rebuild instead of
/// being captured once, unlike Switch.adaptive.
Color? areaActiveDotColor(bool? active) {
  return (active ?? false) ? Color(0xFF06F705) : Color(0xFFF70505);
}

/// Live summary text for 提供エリア設定 tab's left-side "サービス提供エリア一覧" panel
/// (previously a static, always-empty placeholder Text with no data binding
/// at all) - lists the currently-active prefectures among the 11 hardcoded
/// ones this tab manages, comma-separated, re-evaluating on every rebuild
/// from the same areaXxxActive LOCAL_STATE fields the switches and Save
/// button already use.
String? serviceAreaSummary(
  bool? tokyo,
  bool? chiba,
  bool? kanagawa,
  bool? gifu,
  bool? aichi,
  bool? kyoto,
  bool? osaka,
  bool? hyogo,
  bool? okayama,
  bool? hiroshima,
  bool? fukuoka,
) {
  final names = <String>[];
  if (tokyo ?? false) names.add('東京都');
  if (chiba ?? false) names.add('千葉県');
  if (kanagawa ?? false) names.add('神奈川県');
  if (gifu ?? false) names.add('岐阜県');
  if (aichi ?? false) names.add('愛知県');
  if (kyoto ?? false) names.add('京都府');
  if (osaka ?? false) names.add('大阪府');
  if (hyogo ?? false) names.add('兵庫県');
  if (okayama ?? false) names.add('岡山県');
  if (hiroshima ?? false) names.add('広島県');
  if (fukuoka ?? false) names.add('福岡県');
  if (names.isEmpty) return '現在、提供中のエリアはありません';
  return names.join('、');
}

/// Live "X／47" active-prefecture count for 提供エリア設定's left-side summary panel
/// - counts active entries in the full 47-item serviceAreaListStruct (not
/// just the tab's original hardcoded 11), so it can never undercount a
/// prefecture toggled via 提供都道府県一覧 or its 都道府県一覧 add dialog.
String? serviceAreaActiveCount(List<ServiceAreaItemStruct>? areas) {
  final list = areas ?? const <ServiceAreaItemStruct>[];
  final activeCount = list.where((a) => a.active).length;
  return '$activeCount／${list.length}';
}

/// Live comma-separated list of currently-active prefecture names for
/// 提供エリア設定's left-side summary panel - reads the full 47-item
/// serviceAreaListStruct (same source the right-side 提供都道府県一覧 list and its
/// toggles already use), replacing serviceAreaSummary (§18.106), which only
/// covered the tab's original hardcoded 11 prefectures and could silently
/// omit an active one added through the 47-item list or its dialog.
String? serviceAreaActiveNames(List<ServiceAreaItemStruct>? areas) {
  final list = areas ?? const <ServiceAreaItemStruct>[];
  final activeNames =
      list.where((a) => a.active).map((a) => a.prefecture).toList();
  if (activeNames.isEmpty) {
    return '現在、提供中のエリアはありません';
  }
  return activeNames.join('、');
}

/// The 11 canonical prefectures this tab has always managed, in their fixed
/// display order, each carrying its real live active state from the full
/// 47-item serviceAreaListStruct.
///
/// Powers 提供エリア設定's right-side panel top section (client requirement: only
/// these 11 show there by default).
List<ServiceAreaItemStruct>? canonicalServiceAreas(
    List<ServiceAreaItemStruct>? areas) {
  const order = [
    '東京都',
    '千葉県',
    '神奈川県',
    '岐阜県',
    '愛知県',
    '京都府',
    '大阪府',
    '兵庫県',
    '岡山県',
    '広島県',
    '福岡県',
  ];
  final list = areas ?? const <ServiceAreaItemStruct>[];
  final byName = {for (final a in list) a.prefecture: a};
  return [
    for (final name in order)
      byName[name] ??
          ServiceAreaItemStruct(
            prefecture: name,
            active: false,
            activeLabel: '無効',
          ),
  ];
}

/// Any of the remaining 36 (non-canonical) prefectures that are currently
/// ACTIVE - i.e.
///
/// added via the 提供エリア追加 dialog. Powers 提供エリア設定's right-side panel second
/// section, shown below the 11 canonical prefectures.
List<ServiceAreaItemStruct>? extraServiceAreas(
    List<ServiceAreaItemStruct>? areas) {
  const canonical = {
    '東京都',
    '千葉県',
    '神奈川県',
    '岐阜県',
    '愛知県',
    '京都府',
    '大阪府',
    '兵庫県',
    '岡山県',
    '広島県',
    '福岡県',
  };
  final list = areas ?? const <ServiceAreaItemStruct>[];
  return list
      .where((a) => a.active && !canonical.contains(a.prefecture))
      .toList();
}

/// True when extraServiceAreas would be non-empty - gates the "追加エリア"
/// sub-section header/list so it only renders when there is actually
/// something to show there, instead of an empty section.
bool? hasExtraServiceAreas(List<ServiceAreaItemStruct>? areas) {
  const canonical = {
    '東京都',
    '千葉県',
    '神奈川県',
    '岐阜県',
    '愛知県',
    '京都府',
    '大阪府',
    '兵庫県',
    '岡山県',
    '広島県',
    '福岡県',
  };
  final list = areas ?? const <ServiceAreaItemStruct>[];
  return list.any((a) => a.active && !canonical.contains(a.prefecture));
}

/// True when a work_posts row should show its hire-applicants action -
/// staff-job types only (security/transport, never partner_recruit, which
/// stays moderation-only per §17.4 ⑩), still open, and at least one
/// applicant.
bool? canHireWorkPostApplicants(
  String? type,
  String? status,
  String? applicantCount,
) {
  final isStaffJob = type == 'security' || type == 'transport';
  final isOpen = status == 'open';
  final hasApplicants = (int.tryParse(applicantCount ?? '') ?? 0) > 0;
  return isStaffJob && isOpen && hasApplicants;
}

/// True when CreateWorkPostDialogComp's 3 required fields (内容/場所/報酬) are all
/// non-empty - gates 作成する so an empty submission shows a validation message
/// instead of silently calling the backend.
bool? isWorkPostFormValid(
  String? description,
  String? location,
  String? fee,
) {
  return (description ?? '').trim().isNotEmpty &&
      (location ?? '').trim().isNotEmpty &&
      (fee ?? '').trim().isNotEmpty;
}
