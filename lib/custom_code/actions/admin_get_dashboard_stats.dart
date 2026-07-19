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

/// Calls Cloud Function `adminGetDashboardStats` (asia-northeast1)
/// and normalizes the payload for AdminDashboardPage JSON paths:
/// - $.totals.users / reservations / pendingKyc / openReports / revenue /
///   pendingWithdrawals / affiliateCount / cocotenShopCount /
///   jobBoardPostCount / bannerCount
/// - $.userTypeLabels / userTypeValues / monthLabels / salesAmounts
Future<dynamic> adminGetDashboardStats() async {
  try {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('adminGetDashboardStats');
    final result = await callable.call();

    final raw = result.data;
    final data = raw is Map
        ? Map<String, dynamic>.from(raw as Map)
        : <String, dynamic>{};
    final statsRaw = data['stats'];
    final stats = statsRaw is Map
        ? Map<String, dynamic>.from(statsRaw as Map)
        : <String, dynamic>{};

    // Prefer nested stats (current Functions), fall back to flat / totals.
    final totalsIn = data['totals'] is Map
        ? Map<String, dynamic>.from(data['totals'] as Map)
        : <String, dynamic>{};

    final normalizedTotals = <String, dynamic>{
      'users':
          totalsIn['users'] ?? stats['total_users'] ?? data['total_users'] ?? 0,
      'reservations': totalsIn['reservations'] ??
          stats['today_reservations'] ??
          stats['active_reservations'] ??
          data['today_reservations'] ??
          0,
      'pendingKyc': totalsIn['pendingKyc'] ??
          stats['pending_kyc'] ??
          data['pending_kyc'] ??
          0,
      'openReports': totalsIn['openReports'] ??
          stats['pending_reports'] ??
          data['pending_reports'] ??
          0,
    };

    return <String, dynamic>{
      ...data,
      'success': data['success'] ?? true,
      'stats': stats.isNotEmpty ? stats : data['stats'],
      // Merge, don't replace: totalsIn already carries revenue /
      // pendingWithdrawals / affiliateCount / cocotenShopCount /
      // jobBoardPostCount / bannerCount straight from the backend. Spread
      // it first, then overlay the 4 defensively-normalized fields so
      // older/alternate response shapes still fall back correctly. A
      // previous version of this code did `'totals': normalizedTotals`
      // here, which silently dropped every field not in that 4-key list.
      'totals': {...totalsIn, ...normalizedTotals},
      'userTypeLabels':
          data['userTypeLabels'] ?? <String>['ゲスト', 'キャスト', 'スタッフ'],
      'userTypeValues': data['userTypeValues'] ?? <int>[0, 0, 0],
      'monthLabels':
          data['monthLabels'] ?? <String>['1月', '2月', '3月', '4月', '5月', '6月'],
      'salesAmounts': data['salesAmounts'] ?? <int>[0, 0, 0, 0, 0, 0],
    };
  } catch (e) {
    return {
      'success': false,
      'error': e.toString(),
      'totals': {
        'users': 0,
        'reservations': 0,
        'pendingKyc': 0,
        'openReports': 0,
        'revenue': 0,
        'pendingWithdrawals': 0,
        'affiliateCount': 0,
        'cocotenShopCount': 0,
        'jobBoardPostCount': 0,
        'bannerCount': 0,
      },
      'userTypeLabels': <String>['ゲスト', 'キャスト', 'スタッフ'],
      'userTypeValues': <int>[0, 0, 0],
      'monthLabels': <String>['1月', '2月', '3月', '4月', '5月', '6月'],
      'salesAmounts': <int>[0, 0, 0, 0, 0, 0],
    };
  }
}
