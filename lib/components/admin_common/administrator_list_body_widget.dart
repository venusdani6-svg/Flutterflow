import '/components/admin_common/admin_user_list_body_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';

/// Administrator users (role_admin=admin) list body.
class AdministratorListBodyWidget extends StatelessWidget {
  const AdministratorListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminUserListBodyWidget(
      config: AdminUserListConfig(
        roleAdmin: 'admin',
        detailRouteName: AdministratodetailsPageWidget.routeName,
        csvPrefix: 'admin_users',
        emptyMessage: '管理者ユーザーが見つかりません',
      ),
    );
  }
}
