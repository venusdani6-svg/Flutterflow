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

Future<dynamic> adminUpdateServiceAreaSettings(
  bool tokyoActive,
  bool chibaActive,
  bool kanagawaActive,
  bool gifuActive,
  bool aichiActive,
  bool kyotoActive,
  bool osakaActive,
  bool hyogoActive,
  bool okayamaActive,
  bool hiroshimaActive,
  bool fukuokaActive,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');

    // Read the CURRENT full 47-prefecture state first - this tab only
    // edits 11 of them, and service_areas is replaced wholesale on save
    // (see the fix note above), so the other 36 must be carried forward
    // unchanged rather than defaulted/dropped.
    final currentResult =
        await functions.httpsCallable('adminGetSystemConfig').call({});
    final currentRaw = currentResult.data;
    final current = currentRaw is Map
        ? Map<String, dynamic>.from(currentRaw)
        : <String, dynamic>{};
    bool currentActive(String key) => current[key] == true;

    final newAreas = [
      {'prefecture': '北海道', 'active': currentActive('area_hokkaido_active')},
      {'prefecture': '青森県', 'active': currentActive('area_aomori_active')},
      {'prefecture': '岩手県', 'active': currentActive('area_iwate_active')},
      {'prefecture': '宮城県', 'active': currentActive('area_miyagi_active')},
      {'prefecture': '秋田県', 'active': currentActive('area_akita_active')},
      {'prefecture': '山形県', 'active': currentActive('area_yamagata_active')},
      {'prefecture': '福島県', 'active': currentActive('area_fukushima_active')},
      {'prefecture': '茨城県', 'active': currentActive('area_ibaraki_active')},
      {'prefecture': '栃木県', 'active': currentActive('area_tochigi_active')},
      {'prefecture': '群馬県', 'active': currentActive('area_gunma_active')},
      {'prefecture': '埼玉県', 'active': currentActive('area_saitama_active')},
      {'prefecture': '千葉県', 'active': chibaActive},
      {'prefecture': '東京都', 'active': tokyoActive},
      {'prefecture': '神奈川県', 'active': kanagawaActive},
      {'prefecture': '新潟県', 'active': currentActive('area_niigata_active')},
      {'prefecture': '富山県', 'active': currentActive('area_toyama_active')},
      {'prefecture': '石川県', 'active': currentActive('area_ishikawa_active')},
      {'prefecture': '福井県', 'active': currentActive('area_fukui_active')},
      {'prefecture': '山梨県', 'active': currentActive('area_yamanashi_active')},
      {'prefecture': '長野県', 'active': currentActive('area_nagano_active')},
      {'prefecture': '岐阜県', 'active': gifuActive},
      {'prefecture': '静岡県', 'active': currentActive('area_shizuoka_active')},
      {'prefecture': '愛知県', 'active': aichiActive},
      {'prefecture': '三重県', 'active': currentActive('area_mie_active')},
      {'prefecture': '滋賀県', 'active': currentActive('area_shiga_active')},
      {'prefecture': '京都府', 'active': kyotoActive},
      {'prefecture': '大阪府', 'active': osakaActive},
      {'prefecture': '兵庫県', 'active': hyogoActive},
      {'prefecture': '奈良県', 'active': currentActive('area_nara_active')},
      {'prefecture': '和歌山県', 'active': currentActive('area_wakayama_active')},
      {'prefecture': '鳥取県', 'active': currentActive('area_tottori_active')},
      {'prefecture': '島根県', 'active': currentActive('area_shimane_active')},
      {'prefecture': '岡山県', 'active': okayamaActive},
      {'prefecture': '広島県', 'active': hiroshimaActive},
      {'prefecture': '山口県', 'active': currentActive('area_yamaguchi_active')},
      {'prefecture': '徳島県', 'active': currentActive('area_tokushima_active')},
      {'prefecture': '香川県', 'active': currentActive('area_kagawa_active')},
      {'prefecture': '愛媛県', 'active': currentActive('area_ehime_active')},
      {'prefecture': '高知県', 'active': currentActive('area_kochi_active')},
      {'prefecture': '福岡県', 'active': fukuokaActive},
      {'prefecture': '佐賀県', 'active': currentActive('area_saga_active')},
      {'prefecture': '長崎県', 'active': currentActive('area_nagasaki_active')},
      {'prefecture': '熊本県', 'active': currentActive('area_kumamoto_active')},
      {'prefecture': '大分県', 'active': currentActive('area_oita_active')},
      {'prefecture': '宮崎県', 'active': currentActive('area_miyazaki_active')},
      {'prefecture': '鹿児島県', 'active': currentActive('area_kagoshima_active')},
      {'prefecture': '沖縄県', 'active': currentActive('area_okinawa_active')},
    ];

    final settings = <String, dynamic>{'service_areas': newAreas};
    final callable = functions.httpsCallable('adminUpdateSystemConfig');
    final result = await callable.call({'settings': settings});
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
