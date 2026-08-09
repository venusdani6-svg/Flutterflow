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

/// FlutterFlow parameters:
/// - bannerId (String?) optional — null/empty = create, set = update
/// - title (String) required
/// - uploadedImageUrl (String?) optional — result of the "Upload file"
///   action's own Widget State (Uploaded File URL_uploadDataHq0). Blank
///   whenever the admin didn't pick a new file this session (always the
///   case on an edit where the image isn't being changed).
/// - existingImageUrl (String?) optional — existingBanner -> $.image_url,
///   the banner's current image before this save. Used only as a fallback
///   when uploadedImageUrl is blank, so editing a banner without touching
///   its image doesn't wipe out the existing image_url. See the
///   uploadedImageUrl/existingImageUrl resolution below and
///   PROJECT_KNOWLEDGE.md §18.36.
/// - linkUrl (String?) optional
/// - page (String?) optional
/// - displayOrder (int?) optional
/// - active (bool?) optional
/// - advertiser (String?) optional — 出稿主, informational only, not tied
///   to any expiration logic (no source document specifies auto-expiry
///   behavior for banners; see PROJECT_KNOWLEDGE.md §18.36)
/// - displayDays (int?) optional — 掲載期間, raw day count entered
///   directly by the admin, stored as-is (not computed from any date math)
/// - startDate (DateTime?) optional — 掲載開始日, defaults server-side to
///   now if omitted. Sent as `.toUtc().toIso8601String()` deliberately —
///   a local-time ISO string (no `Z` suffix) would be misparsed by the
///   Cloud Function's `new Date(start_date)` as UTC rather than JST, since
///   Cloud Functions run in UTC regardless of deploy region (same class of
///   bug already found once in this project for dashboard "today" math,
///   see PROJECT_KNOWLEDGE.md §18.16).
Future<dynamic> adminUpsertBanner(
  String? bannerId,
  String title,
  String? uploadedImageUrl,
  String? existingImageUrl,
  String? linkUrl,
  String? page,
  int? displayOrder,
  bool? active,
  String? advertiser,
  int? displayDays,
  DateTime? startDate,
) async {
  try {
    // Same '.toString()-on-null' class of bug as bannerId below: FlutterFlow's
    // JSON Path bindings can render the literal text "null" instead of true
    // absence, so guard for that string alongside real null/empty.
    bool hasValue(String? s) => s != null && s.isNotEmpty && s != 'null';
    final resolvedImageUrl = hasValue(uploadedImageUrl)
        ? uploadedImageUrl!
        : (hasValue(existingImageUrl) ? existingImageUrl! : '');

    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminUpsertBanner');
    final result = await callable.call({
      // The 'null' string check guards against FlutterFlow's action-argument
      // binding for bannerId (existingBanner -> $.id) resolving via a bare
      // getJsonField(...).toString() with no null-safety wrapper when
      // existingBanner has no `id` key (create mode) -- it renders the
      // literal text "null" instead of true absence, which would otherwise
      // be sent as banner_id and make the backend try to update a
      // nonexistent doc. See PROJECT_KNOWLEDGE.md §18.36.
      'banner_id': (bannerId == null || bannerId.isEmpty || bannerId == 'null')
          ? null
          : bannerId,
      'title': title,
      'image_url': resolvedImageUrl,
      'link_url': linkUrl ?? '',
      'page': page ?? 'home',
      'display_order': displayOrder ?? 0,
      'active': active ?? true,
      'advertiser': advertiser ?? '',
      'display_days': displayDays ?? 0,
      'start_date': (startDate ?? DateTime.now()).toUtc().toIso8601String(),
    });
    return result.data;
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}
