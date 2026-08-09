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

Future<dynamic> adminGetSystemConfig() async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetSystemConfig');
    final result = await callable.call({});
    final raw = result.data;
    final data =
        raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};
    return _withSafeDefaults(data);
  } catch (e) {
    return _withSafeDefaults({'success': false, 'error': e.toString()});
  }
}

const _kBoolFields = [
  'night_slot_1',
  'night_slot_2',
  'night_slot_3',
  'night_slot_4',
  'area_tokyo_active',
  'area_chiba_active',
  'area_kanagawa_active',
  'area_gifu_active',
  'area_aichi_active',
  'area_kyoto_active',
  'area_osaka_active',
  'area_hyogo_active',
  'area_okayama_active',
  'area_hiroshima_active',
  'area_fukuoka_active',
  'area_hokkaido_active',
  'area_aomori_active',
  'area_iwate_active',
  'area_miyagi_active',
  'area_akita_active',
  'area_yamagata_active',
  'area_fukushima_active',
  'area_ibaraki_active',
  'area_tochigi_active',
  'area_gunma_active',
  'area_saitama_active',
  'area_niigata_active',
  'area_toyama_active',
  'area_ishikawa_active',
  'area_fukui_active',
  'area_yamanashi_active',
  'area_nagano_active',
  'area_shizuoka_active',
  'area_mie_active',
  'area_shiga_active',
  'area_nara_active',
  'area_wakayama_active',
  'area_tottori_active',
  'area_shimane_active',
  'area_yamaguchi_active',
  'area_tokushima_active',
  'area_kagawa_active',
  'area_ehime_active',
  'area_kochi_active',
  'area_saga_active',
  'area_nagasaki_active',
  'area_kumamoto_active',
  'area_oita_active',
  'area_miyazaki_active',
  'area_kagoshima_active',
  'area_okinawa_active',
];

const _kFeatureFlagKeys = [
  'affiliate',
  'cocoten',
  'gps',
  'staff',
  'work_board',
  'security_staff',
  'transport_staff',
];

const _kDisplayStringFields = [
  'default_cast_rate_display',
  'security_staff_fee_display',
  'transport_staff_fee_display',
  'cancel_general_rate_display',
  'default_affiliate_rate_display',
  'affiliate_min_days_display',
  'affiliate_payment_day_display',
];

const _kIntFields = [
  'chat_close_sec',
  'extension_limit_count',
  'max_total_hours',
  'tax_rate',
  'transport_fee_amount',
  'transport_fee_threshold_sec',
];

Map<String, dynamic> _withSafeDefaults(Map<String, dynamic> data) {
  final result = <String, dynamic>{...data};
  result['success'] = result['success'] == true;
  for (final key in _kBoolFields) {
    if (result[key] is! bool) result[key] = false;
  }
  for (final key in _kIntFields) {
    if (result[key] is! num) result[key] = 0;
  }
  for (final key in _kDisplayStringFields) {
    if (result[key] is! String) result[key] = '-';
  }
  final featuresRaw = result['features_enabled'];
  final features = featuresRaw is Map
      ? Map<String, dynamic>.from(featuresRaw)
      : <String, dynamic>{};
  for (final key in _kFeatureFlagKeys) {
    if (features[key] is! bool) features[key] = false;
  }
  result['features_enabled'] = features;
  return result;
}
