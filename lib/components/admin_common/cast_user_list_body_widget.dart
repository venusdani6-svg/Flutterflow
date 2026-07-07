import '/components/admin_common/admin_user_list_body_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';

/// Cast users (role=1) list body.
class CastUserListBodyWidget extends StatelessWidget {
  const CastUserListBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminUserListBodyWidget(
      config: AdminUserListConfig(
        role: 1,
        detailRouteName: CastUserdetailsPageWidget.routeName,
        csvPrefix: 'cast_users',
      ),
    );
  }
}
