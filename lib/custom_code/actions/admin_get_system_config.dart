// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> adminGetSystemConfig() async {
  try {
    final snap = await FirebaseFirestore.instance
        .collection('system_config')
        .doc('settings')
        .get();

    if (!snap.exists || snap.data() == null) {
      return {'success': false, 'error': 'system_config/settings not found'};
    }

    final data = snap.data()!;
    final nightSlots = data['night_time_slots'] is List
        ? List<String>.from(data['night_time_slots'] as List)
        : <String>[];
    final cancelFeeRates = data['cancel_fee_rates'] is Map
        ? Map<String, dynamic>.from(data['cancel_fee_rates'] as Map)
        : <String, dynamic>{};
    final serviceAreas = data['service_areas'] is List
        ? List<dynamic>.from(data['service_areas'] as List)
        : <dynamic>[];
    bool areaActive(String prefecture) {
      final match = serviceAreas.firstWhere(
        (a) => a is Map && a['prefecture'] == prefecture,
        orElse: () => null,
      );
      return match is Map ? (match['active'] == true) : false;
    }

    return {
      'success': true,
      ...data,
      'night_slot_1': nightSlots.contains('1部'),
      'night_slot_2': nightSlots.contains('2部'),
      'night_slot_3': nightSlots.contains('3部'),
      'night_slot_4': nightSlots.contains('4部'),
      'default_cast_rate_display': _fmtPct(data['default_cast_rate']),
      'security_staff_fee_display': _fmtYen(data['security_staff_fee']),
      'transport_staff_fee_display': _fmtYen(data['transport_staff_fee']),
      'cancel_general_rate_display':
          _fmtPct(cancelFeeRates['cast_reward_rate']),
      'default_affiliate_rate_display': _fmtPct(data['default_affiliate_rate']),
      'affiliate_min_days_display': _fmtDay(data['affiliate_min_days']),
      'affiliate_payment_day_display': _fmtDay(data['affiliate_payment_day']),
      'area_tokyo_active': areaActive('東京都'),
      'area_chiba_active': areaActive('千葉県'),
      'area_kanagawa_active': areaActive('神奈川県'),
      'area_gifu_active': areaActive('岐阜県'),
      'area_aichi_active': areaActive('愛知県'),
      'area_kyoto_active': areaActive('京都府'),
      'area_osaka_active': areaActive('大阪府'),
      'area_hyogo_active': areaActive('兵庫県'),
      'area_okayama_active': areaActive('岡山県'),
      'area_hiroshima_active': areaActive('広島県'),
      'area_fukuoka_active': areaActive('福岡県'),
      'area_hokkaido_active': areaActive('北海道'),
      'area_aomori_active': areaActive('青森県'),
      'area_iwate_active': areaActive('岩手県'),
      'area_miyagi_active': areaActive('宮城県'),
      'area_akita_active': areaActive('秋田県'),
      'area_yamagata_active': areaActive('山形県'),
      'area_fukushima_active': areaActive('福島県'),
      'area_ibaraki_active': areaActive('茨城県'),
      'area_tochigi_active': areaActive('栃木県'),
      'area_gunma_active': areaActive('群馬県'),
      'area_saitama_active': areaActive('埼玉県'),
      'area_niigata_active': areaActive('新潟県'),
      'area_toyama_active': areaActive('富山県'),
      'area_ishikawa_active': areaActive('石川県'),
      'area_fukui_active': areaActive('福井県'),
      'area_yamanashi_active': areaActive('山梨県'),
      'area_nagano_active': areaActive('長野県'),
      'area_shizuoka_active': areaActive('静岡県'),
      'area_mie_active': areaActive('三重県'),
      'area_shiga_active': areaActive('滋賀県'),
      'area_nara_active': areaActive('奈良県'),
      'area_wakayama_active': areaActive('和歌山県'),
      'area_tottori_active': areaActive('鳥取県'),
      'area_shimane_active': areaActive('島根県'),
      'area_yamaguchi_active': areaActive('山口県'),
      'area_tokushima_active': areaActive('徳島県'),
      'area_kagawa_active': areaActive('香川県'),
      'area_ehime_active': areaActive('愛媛県'),
      'area_kochi_active': areaActive('高知県'),
      'area_saga_active': areaActive('佐賀県'),
      'area_nagasaki_active': areaActive('長崎県'),
      'area_kumamoto_active': areaActive('熊本県'),
      'area_oita_active': areaActive('大分県'),
      'area_miyazaki_active': areaActive('宮崎県'),
      'area_kagoshima_active': areaActive('鹿児島県'),
      'area_okinawa_active': areaActive('沖縄県'),
    };
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

String? _fmtPct(dynamic raw) {
  if (raw is! num) return null;
  return '${(raw * 100).round()} %';
}

String? _fmtDay(dynamic raw) {
  if (raw is! num) return null;
  return '${raw.round()} 日';
}

String? _fmtYen(dynamic raw) {
  if (raw is! num) return null;
  final s = raw.round().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return '$buf円';
}
