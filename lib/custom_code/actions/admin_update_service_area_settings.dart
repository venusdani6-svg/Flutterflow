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
    final snap = await FirebaseFirestore.instance
        .collection('system_config')
        .doc('settings')
        .get();
    final currentAreas = (snap.data()?['service_areas'] as List?) ?? [];

    final updates = <String, bool>{
      '東京都': tokyoActive,
      '千葉県': chibaActive,
      '神奈川県': kanagawaActive,
      '岐阜県': gifuActive,
      '愛知県': aichiActive,
      '京都府': kyotoActive,
      '大阪府': osakaActive,
      '兵庫県': hyogoActive,
      '岡山県': okayamaActive,
      '広島県': hiroshimaActive,
      '福岡県': fukuokaActive,
    };

    final newAreas = <Map<String, dynamic>>[];
    final seen = <String>{};
    for (final area in currentAreas) {
      if (area is Map) {
        final pref = area['prefecture'] as String?;
        if (pref != null && updates.containsKey(pref)) {
          newAreas.add({'prefecture': pref, 'active': updates[pref]});
          seen.add(pref);
        } else {
          newAreas.add(Map<String, dynamic>.from(area));
        }
      }
    }
    updates.forEach((pref, active) {
      if (!seen.contains(pref)) {
        newAreas.add({'prefecture': pref, 'active': active});
      }
    });

    final settings = <String, dynamic>{'service_areas': newAreas};

    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpdateSystemConfig');
    final result = await callable.call({'settings': settings});
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
