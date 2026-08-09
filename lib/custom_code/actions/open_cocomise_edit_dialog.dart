// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/material.dart';
import '/components/cocomise_edit_dialog_comp_widget.dart';

Future<void> openCocomiseEditDialog(
  BuildContext context,
  String? shopId,
  String? shopName,
  String? genre,
  String? prefecture,
  String? city,
  String? townBlock,
  String? building,
  bool? active,
) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(dialogContext).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CocomiseEditDialogCompWidget(
              shopId: shopId,
              shopName: shopName,
              genre: genre,
              prefecture: prefecture,
              city: city,
              townBlock: townBlock,
              building: building,
              active: active,
            ),
          ),
        ),
      );
    },
  );
}
