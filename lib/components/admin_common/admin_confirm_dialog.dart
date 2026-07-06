import 'package:flutter/material.dart';

/// Shows a confirmation dialog for destructive admin actions.
Future<bool> showAdminConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = '実行',
  String cancelLabel = 'キャンセル',
  bool isDestructive = true,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: isDestructive
              ? TextButton.styleFrom(foregroundColor: Colors.red)
              : null,
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}
