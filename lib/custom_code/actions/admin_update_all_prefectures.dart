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

Future<dynamic> adminUpdateAllPrefectures(
  bool? hokkaidoActive,
  bool? aomoriActive,
  bool? iwateActive,
  bool? miyagiActive,
  bool? akitaActive,
  bool? yamagataActive,
  bool? fukushimaActive,
  bool? ibarakiActive,
  bool? tochigiActive,
  bool? gunmaActive,
  bool? saitamaActive,
  bool? chibaActive,
  bool? tokyoActive,
  bool? kanagawaActive,
  bool? niigataActive,
  bool? toyamaActive,
  bool? ishikawaActive,
  bool? fukuiActive,
  bool? yamanashiActive,
  bool? naganoActive,
  bool? gifuActive,
  bool? shizuokaActive,
  bool? aichiActive,
  bool? mieActive,
  bool? shigaActive,
  bool? kyotoActive,
  bool? osakaActive,
  bool? hyogoActive,
  bool? naraActive,
  bool? wakayamaActive,
  bool? tottoriActive,
  bool? shimaneActive,
  bool? okayamaActive,
  bool? hiroshimaActive,
  bool? yamaguchiActive,
  bool? tokushimaActive,
  bool? kagawaActive,
  bool? ehimeActive,
  bool? kochiActive,
  bool? fukuokaActive,
  bool? sagaActive,
  bool? nagasakiActive,
  bool? kumamotoActive,
  bool? oitaActive,
  bool? miyazakiActive,
  bool? kagoshimaActive,
  bool? okinawaActive,
) async {
  try {
    final newAreas = [
      {'prefecture': '北海道', 'active': hokkaidoActive ?? false},
      {'prefecture': '青森県', 'active': aomoriActive ?? false},
      {'prefecture': '岩手県', 'active': iwateActive ?? false},
      {'prefecture': '宮城県', 'active': miyagiActive ?? false},
      {'prefecture': '秋田県', 'active': akitaActive ?? false},
      {'prefecture': '山形県', 'active': yamagataActive ?? false},
      {'prefecture': '福島県', 'active': fukushimaActive ?? false},
      {'prefecture': '茨城県', 'active': ibarakiActive ?? false},
      {'prefecture': '栃木県', 'active': tochigiActive ?? false},
      {'prefecture': '群馬県', 'active': gunmaActive ?? false},
      {'prefecture': '埼玉県', 'active': saitamaActive ?? false},
      {'prefecture': '千葉県', 'active': chibaActive ?? false},
      {'prefecture': '東京都', 'active': tokyoActive ?? false},
      {'prefecture': '神奈川県', 'active': kanagawaActive ?? false},
      {'prefecture': '新潟県', 'active': niigataActive ?? false},
      {'prefecture': '富山県', 'active': toyamaActive ?? false},
      {'prefecture': '石川県', 'active': ishikawaActive ?? false},
      {'prefecture': '福井県', 'active': fukuiActive ?? false},
      {'prefecture': '山梨県', 'active': yamanashiActive ?? false},
      {'prefecture': '長野県', 'active': naganoActive ?? false},
      {'prefecture': '岐阜県', 'active': gifuActive ?? false},
      {'prefecture': '静岡県', 'active': shizuokaActive ?? false},
      {'prefecture': '愛知県', 'active': aichiActive ?? false},
      {'prefecture': '三重県', 'active': mieActive ?? false},
      {'prefecture': '滋賀県', 'active': shigaActive ?? false},
      {'prefecture': '京都府', 'active': kyotoActive ?? false},
      {'prefecture': '大阪府', 'active': osakaActive ?? false},
      {'prefecture': '兵庫県', 'active': hyogoActive ?? false},
      {'prefecture': '奈良県', 'active': naraActive ?? false},
      {'prefecture': '和歌山県', 'active': wakayamaActive ?? false},
      {'prefecture': '鳥取県', 'active': tottoriActive ?? false},
      {'prefecture': '島根県', 'active': shimaneActive ?? false},
      {'prefecture': '岡山県', 'active': okayamaActive ?? false},
      {'prefecture': '広島県', 'active': hiroshimaActive ?? false},
      {'prefecture': '山口県', 'active': yamaguchiActive ?? false},
      {'prefecture': '徳島県', 'active': tokushimaActive ?? false},
      {'prefecture': '香川県', 'active': kagawaActive ?? false},
      {'prefecture': '愛媛県', 'active': ehimeActive ?? false},
      {'prefecture': '高知県', 'active': kochiActive ?? false},
      {'prefecture': '福岡県', 'active': fukuokaActive ?? false},
      {'prefecture': '佐賀県', 'active': sagaActive ?? false},
      {'prefecture': '長崎県', 'active': nagasakiActive ?? false},
      {'prefecture': '熊本県', 'active': kumamotoActive ?? false},
      {'prefecture': '大分県', 'active': oitaActive ?? false},
      {'prefecture': '宮崎県', 'active': miyazakiActive ?? false},
      {'prefecture': '鹿児島県', 'active': kagoshimaActive ?? false},
      {'prefecture': '沖縄県', 'active': okinawaActive ?? false},
    ];
    final settings = <String, dynamic>{'service_areas': newAreas};
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateSystemConfig');
    final result = await callable.call({'settings': settings});
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
