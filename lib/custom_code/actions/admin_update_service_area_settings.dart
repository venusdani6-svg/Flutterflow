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
    final newAreas = [
      {'prefecture': '東京都', 'active': tokyoActive},
      {'prefecture': '千葉県', 'active': chibaActive},
      {'prefecture': '神奈川県', 'active': kanagawaActive},
      {'prefecture': '岐阜県', 'active': gifuActive},
      {'prefecture': '愛知県', 'active': aichiActive},
      {'prefecture': '京都府', 'active': kyotoActive},
      {'prefecture': '大阪府', 'active': osakaActive},
      {'prefecture': '兵庫県', 'active': hyogoActive},
      {'prefecture': '岡山県', 'active': okayamaActive},
      {'prefecture': '広島県', 'active': hiroshimaActive},
      {'prefecture': '福岡県', 'active': fukuokaActive},
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
