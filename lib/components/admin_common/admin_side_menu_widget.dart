import '/auth/admin_permissions_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _AdminMenuItem {
  const _AdminMenuItem({
    required this.permission,
    required this.label,
    required this.icon,
    required this.routeName,
  });

  final String permission;
  final String label;
  final IconData icon;
  final String routeName;
}

/// Side navigation filtered by [AdminPermissions].
class AdminSideMenuWidget extends StatelessWidget {
  const AdminSideMenuWidget({super.key});

  static const _items = [
    _AdminMenuItem(
      permission: 'dashboard',
      label: 'ダッシュボード',
      icon: Icons.slideshow,
      routeName: 'AdminDashboardPage',
    ),
    _AdminMenuItem(
      permission: 'user_management',
      label: 'ユーザー管理',
      icon: Icons.manage_accounts,
      routeName: 'UserManagementPage',
    ),
    _AdminMenuItem(
      permission: 'reservations',
      label: '予約管理',
      icon: Icons.event_available,
      routeName: 'ReservationsManagementPage',
    ),
    _AdminMenuItem(
      permission: 'payment_ledger',
      label: '決済・台帳管理',
      icon: Icons.credit_card,
      routeName: 'PaymentLedgerManagementPage',
    ),
    _AdminMenuItem(
      permission: 'withdrawal',
      label: '出金申請管理',
      icon: Icons.payments,
      routeName: 'WithdrawalApplicationManagementPage',
    ),
    _AdminMenuItem(
      permission: 'kyc',
      label: 'KYC審査管理',
      icon: Icons.verified_user,
      routeName: 'KYCReviewManagementPage',
    ),
    _AdminMenuItem(
      permission: 'reports',
      label: '通報管理',
      icon: Icons.report,
      routeName: 'ReportManagementPage',
    ),
    _AdminMenuItem(
      permission: 'affiliate',
      label: 'アフィリエイト管理',
      icon: Icons.groups,
      routeName: 'AffiliateManagementPage',
    ),
    _AdminMenuItem(
      permission: 'cocoten',
      label: 'ココ店管理',
      icon: Icons.storefront,
      routeName: 'CocomiseManagementPage',
    ),
    _AdminMenuItem(
      permission: 'job_board',
      label: 'お仕事掲示板管理',
      icon: Icons.restaurant,
      routeName: 'JobBoardManagementPage',
    ),
    _AdminMenuItem(
      permission: 'banners',
      label: 'バナー広告管理',
      icon: Icons.campaign,
      routeName: 'BannerManagementPage',
    ),
    _AdminMenuItem(
      permission: 'system_settings',
      label: 'システム設定管理',
      icon: Icons.settings_applications,
      routeName: 'SystemSettingsManagementPage',
    ),
    _AdminMenuItem(
      permission: 'audit_logs',
      label: '監査ログ管理',
      icon: Icons.fact_check,
      routeName: 'AuditLogManagementPage',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = _items.where((item) => AdminPermissions.can(item.permission));
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: visible
          .map(
            (item) => InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => context.pushNamed(
                item.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 0),
                  ),
                },
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    item.icon,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                  Text(
                    item.label,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ]
                    .divide(const SizedBox(width: 8.0))
                    .around(const SizedBox(width: 8.0)),
              ),
            ),
          )
          .toList()
          .divide(const SizedBox(height: 16.0))
          .around(const SizedBox(height: 16.0)),
    );
  }
}
