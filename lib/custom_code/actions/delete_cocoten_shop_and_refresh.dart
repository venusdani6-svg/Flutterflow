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

import '/custom_code/actions/index.dart' as actions;

Future<bool> deleteCocotenShopAndRefresh(String? shopId) async {
  final result = await actions.adminDeleteCocotenShop(shopId);
  final success = result is Map && result['success'] != false;
  if (!success) return false;
  final refreshed = await actions.adminGetCocotenShops('');
  FFAppState().cocomiseShopListStruct =
      refreshed!.toList().cast<CocotenShopItemStruct>();
  return true;
}
