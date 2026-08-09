// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_functions/cloud_functions.dart';

/// One shared save action for all 5 tabs of システム設定管理
/// (system_settings_list_page). Every parameter is optional/nullable —
/// each tab's save button only binds the params for the fields shown on
/// that tab and leaves the rest Unset. The backend
/// (`adminUpdateSystemConfig` Cloud Function, asia-northeast1) does a
/// `system_config/settings` write with `{merge: true}`, so unset fields
/// are left untouched.
///
/// Several of this page's inputs are FlutterFlowDropDown widgets whose
/// option strings carry display formatting ('50 %', '2,500円', '3 日')
/// instead of raw numbers — FlutterFlow's built-in text-to-number cast
/// can't strip those units, so this action takes the raw selected option
/// string for those fields and parses it internally (see _pct/_yen/_day
/// below), matching how every other unit-bearing dropdown in this project
/// is handled in the Dart wrapper rather than in a chain of FlutterFlow
/// actions.
///
/// ---- 基本設定 tab ----
/// - chatCloseSec (int?) ← textController2 (plain number field)
/// - extensionLimitCount (int?) ← countControllerValue1 (FlutterFlowCountController)
/// - maxTotalHours (int?) ← countControllerValue2 (FlutterFlowCountController)
/// - taxRate (double?) ← textController1 (plain decimal field, e.g. 0.1 for 10%)
/// - nightSlot1Enabled..nightSlot4Enabled (bool?) ← checkboxListTileValue1-4
///   (第1部 17:00-20:00 / 第2部 20:00-23:00 / 第3部 23:00-2:00 / 第4部 2:00-17:00).
///   Written together as `night_time_slots: ["1部","2部",...]` whenever any
///   of the 4 is passed non-null.
/// - featureAffiliateEnabled (bool?) ← switchListTileValue3 (relabeled: アフィリエイト機能)
/// - featureSecurityStaffEnabled (bool?) ← switchListTileValue1 (relabeled: スタッフヘルプ機能/セキュリティスタッフ)
/// - featureTransportStaffEnabled (bool?) ← switchListTileValue2 (relabeled: スタッフヘルプ機能/送迎スタッフ)
/// - featureCocotenEnabled (bool?) ← switchListTileValue4 (relabeled: ココ店機能)
/// - featureWorkBoardEnabled (bool?) ← new 5th switch (お仕事掲示板機能)
///   `features_enabled` only documents affiliate/staff/cocoten/work_board/gps
///   (see firebase/firestore/schema.md), but this UI has 2 separate staff
///   toggles (security/transport), not 1. Resolved by writing `staff` as
///   (securityStaff OR transportStaff) for anything downstream that only
///   reads the coarse flag, plus the 2 granular keys `security_staff` /
///   `transport_staff` so no UI state is lost. `gps` has no toggle on this
///   page and is never written by this action.
///
/// ---- キャスト報酬設定 tab ----
/// - defaultCastRateOption (String?) ← dropDownValueController1, e.g. '50 %'
/// - securityStaffFeeOption (String?) ← dropDownValueController2, e.g. '2,500円'
/// - transportStaffFeeOption (String?) ← dropDownValueController3, e.g. '2,500円'
/// - cancelGeneralRateOption (String?) ← dropDownValueController4 (キャンセル時に発生した利用料の割合（キャスト報酬）)
/// - guestCancelBeforeRateOption (String?) ← dropDownValueController5 (ゲスト都合/交流前)
/// - guestCancelJustBeforeRateOption (String?) ← dropDownValueController6 (ゲスト都合/交流直前)
/// - guestCancelDuringRateOption (String?) ← dropDownValueController7 (ゲスト都合/交流途中)
/// - castCancelBeforeRateOption (String?) ← dropDownValueController8 (キャスト都合/交流前)
/// - castCancelJustBeforeRateOption (String?) ← dropDownValueController9 (キャスト都合/交流直前)
/// - castCancelDuringRateOption (String?) ← dropDownValueController10 (キャスト都合/交流途中)
///   All 7 cancel-rate options share the same '50 %'..'20 %' option list.
///   No prior code defines cancel_fee_rates' internal keys (schema.md just
///   says "map"), so this action writes:
///   cancel_fee_rates: { cast_reward_rate, guest_cancel: {before,
///   just_before, during}, cast_cancel: {before, just_before, during} }.
///
/// ---- アフィリエイト設定 tab ----
/// - defaultAffiliateRateOption (String?) ← dropDownValueController11, e.g. '5 %'
/// - affiliateMinDaysOption (String?) ← dropDownValueController12, e.g. '3 日'
/// - affiliatePaymentDayOption (String?) ← dropDownValueController13, e.g. '5 日'
///   NOTE: dropDownValueController13's '6 日' option has a stray trailing
///   "\n" baked into it in the FlutterFlow builder (copy/paste artifact) —
///   fix that option's literal text in the builder; this action's parser
///   already `.trim()`s so it tolerates it either way.
///
/// ---- 提供エリア設定 tab ----
/// - tokyoActive/chibaActive/kanagawaActive/gifuActive/aichiActive/
///   kyotoActive/osakaActive/hyogoActive/okayamaActive/hiroshimaActive/
///   fukuokaActive (bool?) ← switchValue1-11, in that exact display order.
///   Firestore replaces array fields wholesale on write (unlike maps,
///   `merge:true` does not merge individual array elements) — always pass
///   all 11 together from this tab's save button. Any left Unset default
///   to `true` (active) rather than silently dropping that prefecture.
///   `service_areas[].name` is documented in schema.md but has no input
///   anywhere in this UI; this action does not write a `name` key.
///
/// ---- タクシー代設定 tab ----
/// - transportFeeAmount (int?) ← textController3 (plain number field)
/// - transportFeeThresholdSec (int?) ← textController4 (plain number field)
Future<dynamic> adminUpdateSystemConfig(
  int? chatCloseSec,
  int? extensionLimitCount,
  int? maxTotalHours,
  double? taxRate,
  bool? nightSlot1Enabled,
  bool? nightSlot2Enabled,
  bool? nightSlot3Enabled,
  bool? nightSlot4Enabled,
  bool? featureAffiliateEnabled,
  bool? featureSecurityStaffEnabled,
  bool? featureTransportStaffEnabled,
  bool? featureCocotenEnabled,
  bool? featureWorkBoardEnabled,
  String? defaultCastRateOption,
  String? securityStaffFeeOption,
  String? transportStaffFeeOption,
  String? cancelGeneralRateOption,
  String? guestCancelBeforeRateOption,
  String? guestCancelJustBeforeRateOption,
  String? guestCancelDuringRateOption,
  String? castCancelBeforeRateOption,
  String? castCancelJustBeforeRateOption,
  String? castCancelDuringRateOption,
  String? defaultAffiliateRateOption,
  String? affiliateMinDaysOption,
  String? affiliatePaymentDayOption,
  bool? tokyoActive,
  bool? chibaActive,
  bool? kanagawaActive,
  bool? gifuActive,
  bool? aichiActive,
  bool? kyotoActive,
  bool? osakaActive,
  bool? hyogoActive,
  bool? okayamaActive,
  bool? hiroshimaActive,
  bool? fukuokaActive,
  int? transportFeeAmount,
  int? transportFeeThresholdSec,
) async {
  try {
    final settings = <String, dynamic>{};

    if (chatCloseSec != null) settings['chat_close_sec'] = chatCloseSec;
    if (extensionLimitCount != null) {
      settings['extension_limit_count'] = extensionLimitCount;
    }
    if (maxTotalHours != null) settings['max_total_hours'] = maxTotalHours;
    if (taxRate != null) settings['tax_rate'] = taxRate;

    if ([
      nightSlot1Enabled,
      nightSlot2Enabled,
      nightSlot3Enabled,
      nightSlot4Enabled,
    ].any((v) => v != null)) {
      final slots = <String>[];
      if (nightSlot1Enabled == true) slots.add('1部');
      if (nightSlot2Enabled == true) slots.add('2部');
      if (nightSlot3Enabled == true) slots.add('3部');
      if (nightSlot4Enabled == true) slots.add('4部');
      settings['night_time_slots'] = slots;
    }

    final features = <String, dynamic>{};
    if (featureAffiliateEnabled != null) {
      features['affiliate'] = featureAffiliateEnabled;
    }
    if (featureSecurityStaffEnabled != null ||
        featureTransportStaffEnabled != null) {
      if (featureSecurityStaffEnabled != null) {
        features['security_staff'] = featureSecurityStaffEnabled;
      }
      if (featureTransportStaffEnabled != null) {
        features['transport_staff'] = featureTransportStaffEnabled;
      }
      features['staff'] = (featureSecurityStaffEnabled ?? false) ||
          (featureTransportStaffEnabled ?? false);
    }
    if (featureCocotenEnabled != null) {
      features['cocoten'] = featureCocotenEnabled;
    }
    if (featureWorkBoardEnabled != null) {
      features['work_board'] = featureWorkBoardEnabled;
    }
    if (features.isNotEmpty) settings['features_enabled'] = features;

    if (defaultCastRateOption != null) {
      settings['default_cast_rate'] = _pct(defaultCastRateOption);
    }
    if (securityStaffFeeOption != null) {
      settings['security_staff_fee'] = _yen(securityStaffFeeOption);
    }
    if (transportStaffFeeOption != null) {
      settings['transport_staff_fee'] = _yen(transportStaffFeeOption);
    }

    final cancelRates = <String, dynamic>{};
    if (cancelGeneralRateOption != null) {
      cancelRates['cast_reward_rate'] = _pct(cancelGeneralRateOption);
    }
    final guestCancel = <String, dynamic>{};
    if (guestCancelBeforeRateOption != null) {
      guestCancel['before'] = _pct(guestCancelBeforeRateOption);
    }
    if (guestCancelJustBeforeRateOption != null) {
      guestCancel['just_before'] = _pct(guestCancelJustBeforeRateOption);
    }
    if (guestCancelDuringRateOption != null) {
      guestCancel['during'] = _pct(guestCancelDuringRateOption);
    }
    if (guestCancel.isNotEmpty) cancelRates['guest_cancel'] = guestCancel;
    final castCancel = <String, dynamic>{};
    if (castCancelBeforeRateOption != null) {
      castCancel['before'] = _pct(castCancelBeforeRateOption);
    }
    if (castCancelJustBeforeRateOption != null) {
      castCancel['just_before'] = _pct(castCancelJustBeforeRateOption);
    }
    if (castCancelDuringRateOption != null) {
      castCancel['during'] = _pct(castCancelDuringRateOption);
    }
    if (castCancel.isNotEmpty) cancelRates['cast_cancel'] = castCancel;
    if (cancelRates.isNotEmpty) settings['cancel_fee_rates'] = cancelRates;

    if (defaultAffiliateRateOption != null) {
      settings['default_affiliate_rate'] = _pct(defaultAffiliateRateOption);
    }
    if (affiliateMinDaysOption != null) {
      settings['affiliate_min_days'] = _day(affiliateMinDaysOption);
    }
    if (affiliatePaymentDayOption != null) {
      settings['affiliate_payment_day'] = _day(affiliatePaymentDayOption);
    }

    if ([
      tokyoActive,
      chibaActive,
      kanagawaActive,
      gifuActive,
      aichiActive,
      kyotoActive,
      osakaActive,
      hyogoActive,
      okayamaActive,
      hiroshimaActive,
      fukuokaActive,
    ].any((v) => v != null)) {
      settings['service_areas'] = [
        {'prefecture': '東京都', 'active': tokyoActive ?? true},
        {'prefecture': '千葉県', 'active': chibaActive ?? true},
        {'prefecture': '神奈川県', 'active': kanagawaActive ?? true},
        {'prefecture': '岐阜県', 'active': gifuActive ?? true},
        {'prefecture': '愛知県', 'active': aichiActive ?? true},
        {'prefecture': '京都府', 'active': kyotoActive ?? true},
        {'prefecture': '大阪府', 'active': osakaActive ?? true},
        {'prefecture': '兵庫県', 'active': hyogoActive ?? true},
        {'prefecture': '岡山県', 'active': okayamaActive ?? true},
        {'prefecture': '広島県', 'active': hiroshimaActive ?? true},
        {'prefecture': '福岡県', 'active': fukuokaActive ?? true},
      ];
    }

    if (transportFeeAmount != null) {
      settings['transport_fee_amount'] = transportFeeAmount;
    }
    if (transportFeeThresholdSec != null) {
      settings['transport_fee_threshold_sec'] = transportFeeThresholdSec;
    }

    if (settings.isEmpty) {
      return {'success': false, 'error': 'No fields provided to update.'};
    }

    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateSystemConfig');
    final result = await callable.call({'settings': settings});
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

/// '50 %' -> 0.5
double? _pct(String raw) {
  final cleaned = raw.trim().replaceAll('%', '').trim();
  final value = double.tryParse(cleaned);
  return value == null ? null : value / 100;
}

/// '2,500円' -> 2500
int? _yen(String raw) {
  final cleaned = raw.trim().replaceAll('円', '').replaceAll(',', '').trim();
  return int.tryParse(cleaned);
}

/// '3 日' (or '6 日\n') -> 3
int? _day(String raw) {
  final cleaned = raw.trim().replaceAll('日', '').trim();
  return int.tryParse(cleaned);
}
