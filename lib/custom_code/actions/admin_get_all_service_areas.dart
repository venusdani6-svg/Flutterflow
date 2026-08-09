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

Future<dynamic> adminGetAllServiceAreas() async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final result =
        await functions.httpsCallable('adminGetSystemConfig').call({});
    final raw = result.data;
    final data =
        raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};
    bool active(String key) => data[key] == true;

    const order = <String, String>{
      '北海道': 'area_hokkaido_active',
      '青森県': 'area_aomori_active',
      '岩手県': 'area_iwate_active',
      '宮城県': 'area_miyagi_active',
      '秋田県': 'area_akita_active',
      '山形県': 'area_yamagata_active',
      '福島県': 'area_fukushima_active',
      '茨城県': 'area_ibaraki_active',
      '栃木県': 'area_tochigi_active',
      '群馬県': 'area_gunma_active',
      '埼玉県': 'area_saitama_active',
      '千葉県': 'area_chiba_active',
      '東京都': 'area_tokyo_active',
      '神奈川県': 'area_kanagawa_active',
      '新潟県': 'area_niigata_active',
      '富山県': 'area_toyama_active',
      '石川県': 'area_ishikawa_active',
      '福井県': 'area_fukui_active',
      '山梨県': 'area_yamanashi_active',
      '長野県': 'area_nagano_active',
      '岐阜県': 'area_gifu_active',
      '静岡県': 'area_shizuoka_active',
      '愛知県': 'area_aichi_active',
      '三重県': 'area_mie_active',
      '滋賀県': 'area_shiga_active',
      '京都府': 'area_kyoto_active',
      '大阪府': 'area_osaka_active',
      '兵庫県': 'area_hyogo_active',
      '奈良県': 'area_nara_active',
      '和歌山県': 'area_wakayama_active',
      '鳥取県': 'area_tottori_active',
      '島根県': 'area_shimane_active',
      '岡山県': 'area_okayama_active',
      '広島県': 'area_hiroshima_active',
      '山口県': 'area_yamaguchi_active',
      '徳島県': 'area_tokushima_active',
      '香川県': 'area_kagawa_active',
      '愛媛県': 'area_ehime_active',
      '高知県': 'area_kochi_active',
      '福岡県': 'area_fukuoka_active',
      '佐賀県': 'area_saga_active',
      '長崎県': 'area_nagasaki_active',
      '熊本県': 'area_kumamoto_active',
      '大分県': 'area_oita_active',
      '宮崎県': 'area_miyazaki_active',
      '鹿児島県': 'area_kagoshima_active',
      '沖縄県': 'area_okinawa_active',
    };

    return order.entries.map((entry) {
      final isActive = active(entry.value);
      return ServiceAreaItemStruct.fromMap({
        'prefecture': entry.key,
        'active': isActive,
        'activeLabel': isActive ? '有効' : '無効',
      });
    }).toList();
  } catch (e) {
    return <ServiceAreaItemStruct>[];
  }
}
