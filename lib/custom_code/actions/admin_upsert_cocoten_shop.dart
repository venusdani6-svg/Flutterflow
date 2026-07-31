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

Future<dynamic> adminUpsertCocotenShop(
  String? shopId,
  String? name,
  String? genre,
  String? prefecture,
  String? city,
  String? townBlock,
  String? building,
  bool? active,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpsertCocotenShop');
    final result = await callable.call({
      'shop_id': shopId,
      'name': name,
      'genre': genre,
      'prefecture': prefecture,
      'city': city,
      'town_block': townBlock,
      'building': building,
      'active': active,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
