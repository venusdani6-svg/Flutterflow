import 'package:cloud_functions/cloud_functions.dart';

import '/auth/firebase_auth/auth_util.dart';

Future<Map<String, dynamic>> _callAdmin(
  String name, [
  Map<String, dynamic> data = const {},
]) async {
  final result = await adminFunctions.httpsCallable(name).call(data);
  return Map<String, dynamic>.from(result.data as Map);
}

Future<Map<String, dynamic>?> adminGetDashboardStats() =>
    _callAdmin('adminGetDashboardStats');

Future<Map<String, dynamic>?> adminHealthCheck() =>
    _callAdmin('adminHealthCheck');

Future<Map<String, dynamic>?> adminGetUsers({
  int? role,
  String? roleAdmin,
  String? kycStatus,
  String? search,
  String? orderBy,
  String? orderDirection,
  bool? isFrozen,
  int limit = 50,
  int offset = 0,
}) =>
    _callAdmin('adminGetUsers', {
      if (role != null) 'role': role,
      if (roleAdmin != null) 'roleAdmin': roleAdmin,
      if (kycStatus != null) 'kycStatus': kycStatus,
      if (search != null && search.isNotEmpty) 'search': search,
      if (orderBy != null) 'orderBy': orderBy,
      if (orderDirection != null) 'orderDirection': orderDirection,
      if (isFrozen != null) 'isFrozen': isFrozen,
      'limit': limit,
      'offset': offset,
    });

Future<Map<String, dynamic>?> adminGetUser({
  required String userId,
}) =>
    _callAdmin('adminGetUser', {'userId': userId});

Future<Map<String, dynamic>?> adminApproveKYC({
  required String userId,
  bool approved = true,
}) =>
    _callAdmin('adminApproveKYC', {'userId': userId, 'approved': approved});

Future<Map<String, dynamic>?> adminToggleFreeze({
  required String userId,
  required bool frozen,
}) =>
    _callAdmin('adminToggleFreeze', {'userId': userId, 'frozen': frozen});

Future<Map<String, dynamic>?> adminForceDeleteUser({
  required String userId,
}) =>
    _callAdmin('adminForceDeleteUser', {'userId': userId});

Future<Map<String, dynamic>?> adminGetReservations({
  String? status,
  String? search,
  int limit = 50,
  int offset = 0,
}) =>
    _callAdmin('adminGetReservations', {
      if (status != null) 'status': status,
      if (search != null && search.isNotEmpty) 'search': search,
      'limit': limit,
      'offset': offset,
    });

Future<Map<String, dynamic>?> adminGetReservation({
  required String reservationId,
}) =>
    _callAdmin('adminGetReservation', {'reservationId': reservationId});

Future<Map<String, dynamic>?> adminForceCancel({
  required String reservationId,
  String? reason,
}) =>
    _callAdmin('adminForceCancel', {
      'reservationId': reservationId,
      if (reason != null) 'reason': reason,
    });

Future<Map<String, dynamic>?> adminGetTipsByReservation({
  required String reservationId,
}) =>
    _callAdmin('adminGetTipsByReservation', {
      'reservationId': reservationId,
    });

Future<Map<String, dynamic>?> adminGetLedger({
  String? type,
  String? reservationId,
  int limit = 50,
}) =>
    _callAdmin('adminGetLedger', {
      if (type != null) 'type': type,
      if (reservationId != null) 'reservationId': reservationId,
      'limit': limit,
    });

Future<Map<String, dynamic>?> adminGetStripeLogs({
  String? eventType,
  String? reservationId,
  String? startDate,
  String? endDate,
  int limit = 50,
}) =>
    _callAdmin('adminGetStripeLogs', {
      if (eventType != null) 'eventType': eventType,
      if (reservationId != null) 'reservationId': reservationId,
      if (startDate != null) 'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      'limit': limit,
    });

Future<Map<String, dynamic>?> adminGetPayoutRequests({
  String? status,
  int limit = 50,
  int offset = 0,
}) =>
    _callAdmin('adminGetPayoutRequests', {
      if (status != null) 'status': status,
      'limit': limit,
      'offset': offset,
    });

Future<Map<String, dynamic>?> adminApprovePayout({
  required String payoutId,
  required String status,
}) =>
    _callAdmin('adminApprovePayout', {
      'payoutId': payoutId,
      'status': status,
    });

Future<Map<String, dynamic>?> adminUpdateSystemConfig({
  required String section,
  required Map<String, dynamic> payload,
}) =>
    _callAdmin('adminUpdateSystemConfig', {
      'section': section,
      'payload': payload,
    });

Future<Map<String, dynamic>?> adminGetSystemConfig() =>
    _callAdmin('adminGetSystemConfig');

Future<Map<String, dynamic>?> adminUpsertBanner({
  String? bannerId,
  required Map<String, dynamic> payload,
}) =>
    _callAdmin('adminUpsertBanner', {
      if (bannerId != null) 'bannerId': bannerId,
      'payload': payload,
    });

Future<Map<String, dynamic>?> adminGetReports({
  String? status,
  int limit = 50,
}) =>
    _callAdmin('adminGetReports', {
      if (status != null) 'status': status,
      'limit': limit,
    });

Future<Map<String, dynamic>?> adminResolveReport({
  required String reportId,
  String resolution = 'resolved',
}) =>
    _callAdmin('adminResolveReport', {
      'reportId': reportId,
      'resolution': resolution,
    });

Future<Map<String, dynamic>?> adminGetAffiliateOverview() =>
    _callAdmin('adminGetAffiliateOverview');

Future<Map<String, dynamic>?> adminUpdateAffiliateRate({
  required String userId,
  required double rate,
}) =>
    _callAdmin('adminUpdateAffiliateRate', {
      'userId': userId,
      'rate': rate,
    });

Future<Map<String, dynamic>?> adminGetAuditLogs({
  String? targetType,
  String? targetId,
  int limit = 50,
}) =>
    _callAdmin('adminGetAuditLogs', {
      if (targetType != null) 'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      'limit': limit,
    });
