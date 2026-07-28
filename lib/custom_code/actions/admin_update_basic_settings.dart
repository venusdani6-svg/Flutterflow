// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

/// Save action for システム設定管理's 基本設定 tab only. Every parameter
/// is required (not nullable) — unlike the earlier one-action-for-all-5-
/// tabs design, this only ever needs this tab's own fields, so there's no
/// "leave the other tabs' fields Unset" problem to solve.
///
/// That earlier design (`adminUpdateSystemConfig`, 39 optional params
/// shared across all 5 tabs) turned out to be broken: FlutterFlow cannot
/// leave a Boolean action argument truly unset (confirmed live — 11
/// unrelated `xxxActive` params all resolved to `False` instead of
/// Unset), so any save button built that way would silently overwrite
/// every other tab's boolean fields with `false` on every save. See
/// `.cursor/rules/project_rules.md`'s "quirks learned the hard way" list.
/// Each of the other 4 tabs will get its own equivalent dedicated action
/// (`adminUpdateCastRewardSettings`, `adminUpdateAffiliateSettings`,
/// `adminUpdateServiceAreaSettings`, `adminUpdateTaxiSettings`) following
/// this same pattern, not a shared one.
///
/// Params map 1:1 to 基本設定's fields:
/// - chatCloseSecText ← textController2（チャット閉鎖秒数設定）, raw text —
///   see note below on why this and taxRateText are String, not int/double.
/// - extensionLimitCount ← countControllerValue1（延長上限回数設定）
/// - maxTotalHours ← countControllerValue2（最大総時間設定）
/// - taxRateText ← textController1（消費税率設定）, raw text
/// - nightSlot1Enabled..nightSlot4Enabled ← checkboxListTileValue1-4
///   （第1部..第4部）→ written as `night_time_slots: ["1部","2部",...]`
/// - featureAffiliateEnabled ← switchListTileValue3（アフィリエイト機能）
/// - featureSecurityStaffEnabled ← switchListTileValue1（セキュリティスタッフ）
/// - featureTransportStaffEnabled ← switchListTileValue2（送迎スタッフ）
/// - featureCocotenEnabled ← switchListTileValue4（ココ店機能）
/// - featureWorkBoardEnabled ← 5th switch（お仕事掲示板機能）
///   `features_enabled.staff` is written as
///   (featureSecurityStaffEnabled OR featureTransportStaffEnabled), plus
///   the 2 granular keys `security_staff`/`transport_staff`, same
///   reasoning as the old action (schema.md only documents one `staff`
///   key, but this UI has 2 independent staff toggles).
///
/// chatCloseSecText/taxRateText are String, parsed here, instead of
/// int/double — same fix as admin_update_taxi_settings.dart (§18.33).
/// Both text fields' Initial Value is seeded via a `??=` inside
/// initState() (before the async config load resolves), so on a fresh
/// page load they show the literal text "null" until edited. The
/// FlutterFlow-generated Save button previously did
/// `int.parse(...)`/`double.parse(...)` inline with no error handling —
/// clicking Save before editing those fields would throw an uncaught
/// FormatException. Parsing here instead returns a clean
/// {'success': false, 'error': ...} so a stray "null" can never crash the
/// button or reach Firestore.
Future<dynamic> adminUpdateBasicSettings(
  String chatCloseSecText,
  int extensionLimitCount,
  int maxTotalHours,
  String taxRateText,
  bool nightSlot1Enabled,
  bool nightSlot2Enabled,
  bool nightSlot3Enabled,
  bool nightSlot4Enabled,
  bool featureAffiliateEnabled,
  bool featureSecurityStaffEnabled,
  bool featureTransportStaffEnabled,
  bool featureCocotenEnabled,
  bool featureWorkBoardEnabled,
) async {
  try {
    final chatCloseSec = int.tryParse(chatCloseSecText.trim());
    final taxRate = double.tryParse(taxRateText.trim());
    if (chatCloseSec == null || taxRate == null) {
      return {
        'success': false,
        'error':
            'チャット閉鎖秒数と消費税率は数値で入力してください。（現在の入力: "$chatCloseSecText" / "$taxRateText"）',
      };
    }

    final nightSlots = <String>[];
    if (nightSlot1Enabled) nightSlots.add('1部');
    if (nightSlot2Enabled) nightSlots.add('2部');
    if (nightSlot3Enabled) nightSlots.add('3部');
    if (nightSlot4Enabled) nightSlots.add('4部');

    final settings = <String, dynamic>{
      'chat_close_sec': chatCloseSec,
      'extension_limit_count': extensionLimitCount,
      'max_total_hours': maxTotalHours,
      'tax_rate': taxRate,
      'night_time_slots': nightSlots,
      'features_enabled': {
        'affiliate': featureAffiliateEnabled,
        'security_staff': featureSecurityStaffEnabled,
        'transport_staff': featureTransportStaffEnabled,
        'staff': featureSecurityStaffEnabled || featureTransportStaffEnabled,
        'cocoten': featureCocotenEnabled,
        'work_board': featureWorkBoardEnabled,
      },
    };

    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateSystemConfig');
    final result = await callable.call({'settings': settings});
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
