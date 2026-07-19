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

/// FlutterFlow parameters:
/// - bannerId (String?) optional — null/empty = create, set = update
/// - title (String) required
/// - imageUrl (String) required
/// - linkUrl (String?) optional
/// - page (String?) optional
/// - displayOrder (int?) optional
/// - active (bool?) optional
Future<dynamic> adminUpsertBanner(
  String? bannerId,
  String title,
  String imageUrl,
  String? linkUrl,
  String? page,
  int? displayOrder,
  bool? active,
) async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpsertBanner');
    final result = await callable.call({
      'banner_id': (bannerId == null || bannerId.isEmpty) ? null : bannerId,
      'title': title,
      'image_url': imageUrl,
      'link_url': linkUrl ?? '',
      'page': page ?? 'home',
      'display_order': displayOrder ?? 0,
      'active': active ?? true,
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
