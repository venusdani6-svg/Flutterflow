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

Future<dynamic> adminGetCocotenShops(String? keyword) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetCocotenShops');
    final result = await callable.call({});
    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final shopsRaw = data['shops'];
    if (shopsRaw is! List) return <CocotenShopItemStruct>[];
    var shops = shopsRaw
        .whereType<Map>()
        .map((s) => Map<String, dynamic>.from(s))
        .toList();
    final kw = (keyword ?? '').trim().toLowerCase();
    if (kw.isNotEmpty) {
      shops = shops.where((s) {
        final name = (s['name'] ?? '').toString().toLowerCase();
        return name.contains(kw);
      }).toList();
    }
    return shops.map((s) => _toCocotenShopItem(s)).toList();
  } catch (e) {
    return <CocotenShopItemStruct>[];
  }
}

CocotenShopItemStruct _toCocotenShopItem(Map<String, dynamic> s) {
  final active = s['active'] == true;
  return CocotenShopItemStruct.fromMap({
    'id': s['id']?.toString() ?? '',
    'name': s['name']?.toString() ?? '',
    'genre': s['genre']?.toString() ?? '',
    'prefecture': s['prefecture']?.toString() ?? '',
    'city': s['city']?.toString() ?? '',
    'town_block': s['town_block']?.toString() ?? '',
    'building': s['building']?.toString() ?? '',
    'active': active,
    'active_label': active ? '有効' : '無効',
  });
}
