import '/components/admin_common/admin_user_list_body_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';

/// Guest users (role=0) list body.
class GuestUserListBodyWidget extends StatelessWidget {
  const GuestUserListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminUserListBodyWidget(
      config: AdminUserListConfig(
        role: 0,
        detailRouteName: GuestUserdetailsPageWidget.routeName,
        csvPrefix: 'guest_users',
      ),
    );
  }
}
