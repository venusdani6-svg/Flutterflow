import '/components/admin_common/admin_user_list_body_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';

/// Staff users (role=2) list body.
class StaffUserListBodyWidget extends StatelessWidget {
  const StaffUserListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminUserListBodyWidget(
      config: AdminUserListConfig(
        role: 2,
        detailRouteName: StaffUserdetailsPageWidget.routeName,
        csvPrefix: 'staff_users',
      ),
    );
  }
}
