import 'package:flutter/material.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';

/// Returns true if the current user is an admin.
/// If logged in but not admin, signs out and navigates to login.
Future<bool> guardAdminAccess(BuildContext context) async {
  if (!loggedIn) {
    if (context.mounted) {
      context.goNamed(AdminLoginPageWidget.routeName);
    }
    return false;
  }

  if (currentUserDocument == null) {
    // Wait briefly for authenticatedUserStream to populate the profile.
    await Future.delayed(const Duration(milliseconds: 500));
  }

  if (!currentUserIsAdmin) {
    await authManager.signOut();
    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: const Text('アクセスできません'),
            content: const Text('管理者権限がありません'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      context.goNamed(AdminLoginPageWidget.routeName);
    }
    return false;
  }

  return true;
}
