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

import 'package:cloud_firestore/cloud_firestore.dart';

/// Plain open-read query — `banners` allows `read: true` in
/// firestore.rules, so no Cloud Function is needed for the list (same
/// convention as admin_get_system_config.dart). Only create/update still
/// goes through the adminUpsertBanner Cloud Function; this action never
/// writes anything.
Future<dynamic> adminGetBanners() async {
  try {
    final snap = await FirebaseFirestore.instance
        .collection('banners')
        .orderBy('display_order')
        .get();

    final banners = snap.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'title': data['title'] ?? '',
        'image_url': data['image_url'] ?? '',
        'link_url': data['link_url'] ?? '',
        'page': data['page'] ?? 'home',
        'display_order': data['display_order'] ?? 0,
        'active': data['active'] ?? true,
        'advertiser': data['advertiser'] ?? '',
        'display_days': data['display_days'] ?? 0,
        'start_date_display': _fmtDate(data['start_date']),
        'display_days_display': _fmtDay(data['display_days']),
      };
    }).toList();

    return {'success': true, 'banners': banners};
  } catch (e) {
    return {'success': false, 'error': e.toString(), 'banners': <dynamic>[]};
  }
}

String _fmtDate(dynamic raw) {
  if (raw is! Timestamp) return 'なし';
  final dt = raw.toDate().toLocal();
  final mm = dt.month.toString().padLeft(2, '0');
  final dd = dt.day.toString().padLeft(2, '0');
  return '${dt.year}. $mm. $dd';
}

String _fmtDay(dynamic raw) {
  if (raw is! num) return '0日';
  return '${raw.round()}日';
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
