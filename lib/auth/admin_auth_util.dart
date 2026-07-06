import 'package:flutter/material.dart';

import '/auth/admin_permissions_util.dart';
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
    await Future.delayed(const Duration(milliseconds: 500));
  }

  if (!currentUserIsAdmin) {
    await authManager.signOut();
    AdminPermissions.clear();
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

  if (!AdminPermissions.isLoaded) {
    await AdminPermissions.refresh();
  }

  return true;
}

/// Blocks access when the signed-in admin lacks a screen permission.
Future<bool> guardAdminPermission(
  BuildContext context,
  String permissionKey,
) async {
  final allowed = await guardAdminAccess(context);
  if (!allowed || !context.mounted) {
    return false;
  }
  if (AdminPermissions.can(permissionKey)) {
    return true;
  }
  await showDialog(
    context: context,
    builder: (alertDialogContext) {
      return AlertDialog(
        title: const Text('権限がありません'),
        content: Text(
          '${AdminPermissions.permissionLabels[permissionKey] ?? permissionKey} へのアクセス権限がありません。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(alertDialogContext),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
  if (context.mounted) {
    context.goNamed(AdminDashboardPageWidget.routeName);
  }
  return false;
}
