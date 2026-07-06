import '/backend/cloud_functions/admin_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'admin_dashboard_page_widget.dart' show AdminDashboardPageWidget;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardActivityLog {
  const DashboardActivityLog({
    required this.action,
    required this.targetUserName,
    required this.createdAtLabel,
  });

  final String action;
  final String targetUserName;
  final String createdAtLabel;
}

class AdminDashboardPageModel
    extends FlutterFlowModel<AdminDashboardPageWidget> {
  bool isLoadingDashboard = true;
  String? dashboardLoadError;

  int todayNewRegistrations = 0;
  int todayReservationCount = 0;
  int salesToday = 0;
  int pendingPayoutCount = 0;
  int pendingKycCount = 0;
  int pendingReportsCount = 0;
  int affiliateCount = 0;
  int cocotenShopCount = 0;
  int jobBoardPostCount = 0;

  List<int> salesAmounts = [0];
  List<String> monthLabels = ['-'];

  List<int> userTypeValues = [0, 0, 0];
  List<String> userTypeLabels = ['ゲスト', 'キャスト', 'スタッフ'];

  List<DashboardActivityLog> activityLogs = [];

  final _currencyFormatter = NumberFormat('#,###');
  final _activityDateFormatter = DateFormat('yy.MM.dd　HH : mm');

  String get todayNewRegistrationsLabel => '$todayNewRegistrations';
  String get todayReservationCountLabel => '$todayReservationCount';
  String get salesTodayLabel => _currencyFormatter.format(salesToday);
  String get pendingPayoutCountLabel => '$pendingPayoutCount';
  String get pendingKycCountLabel => '$pendingKycCount';
  String get pendingReportsCountLabel => '$pendingReportsCount';
  String get affiliateCountLabel => '$affiliateCount';
  String get cocotenShopCountLabel => '$cocotenShopCount';
  String get jobBoardPostCountLabel => '$jobBoardPostCount';

  late MainMenuCompModel mainMenuCompModel;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  Future<void> loadDashboardData(
    VoidCallback onUpdate, {
    bool showLoading = true,
  }) async {
    if (showLoading) {
      isLoadingDashboard = true;
      dashboardLoadError = null;
      onUpdate();
    }

    try {
      final stats = await adminGetDashboardStats();
      if (stats == null) {
        throw Exception('ダッシュボードデータを取得できませんでした');
      }

      todayNewRegistrations =
          _asInt(stats['todayNewRegistrations']);
      todayReservationCount = _asInt(
        stats['todayReservationCount'] ?? stats['reservationCount'],
      );
      salesToday = _asInt(stats['salesToday']);
      pendingPayoutCount = _asInt(stats['pendingPayoutCount']);
      pendingKycCount = _asInt(stats['pendingKycCount']);
      pendingReportsCount = _asInt(stats['pendingReportsCount']);
      affiliateCount = _asInt(stats['affiliateCount']);
      cocotenShopCount = _asInt(stats['cocotenShopCount']);
      jobBoardPostCount = _asInt(stats['jobBoardPostCount']);

      _applyMonthlySales(stats['monthlySales']);
      _applyUserTypeCounts(stats['userTypeCounts']);
      _applyActivityLogs(stats['recentActivityLogs']);

      dashboardLoadError = null;
    } catch (e) {
      dashboardLoadError = e.toString();
    } finally {
      isLoadingDashboard = false;
      onUpdate();
    }
  }

  void _applyMonthlySales(dynamic raw) {
    if (raw is! List || raw.isEmpty) {
      salesAmounts = [0];
      monthLabels = ['-'];
      return;
    }

    salesAmounts = raw
        .map((item) => _asInt((item as Map)['amount']))
        .toList();
    monthLabels = raw
        .map((item) => '${(item as Map)['month'] ?? '-'}')
        .toList();
  }

  void _applyUserTypeCounts(dynamic raw) {
    if (raw is! Map) {
      return;
    }
    userTypeValues = [
      _asInt(raw['guest']),
      _asInt(raw['cast']),
      _asInt(raw['staff']),
    ];
  }

  void _applyActivityLogs(dynamic raw) {
    if (raw is! List) {
      activityLogs = [];
      return;
    }

    activityLogs = raw.map((item) {
      final map = Map<String, dynamic>.from(item as Map);
      final createdAtRaw = map['createdAt'];
      DateTime? createdAt;
      if (createdAtRaw is String) {
        createdAt = DateTime.tryParse(createdAtRaw);
      }
      return DashboardActivityLog(
        action: map['action']?.toString() ?? '-',
        targetUserName: map['targetUserName']?.toString() ?? '-',
        createdAtLabel: createdAt != null
            ? _activityDateFormatter.format(createdAt.toLocal())
            : '-',
      );
    }).toList();
  }

  int _asInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.round();
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
