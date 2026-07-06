import '/flutter_flow/flutter_flow_util.dart';
import 'reset_password_form_widget.dart' show ResetPasswordFormWidget;
import 'package:flutter/material.dart';

class ResetPasswordFormModel extends FlutterFlowModel<ResetPasswordFormWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for ResetPasswordEmailField widget.
  FocusNode? resetPasswordEmailFieldFocusNode;
  TextEditingController? resetPasswordEmailFieldTextController;
  String? Function(BuildContext, String?)?
      resetPasswordEmailFieldTextControllerValidator;
  String? _resetPasswordEmailFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '必須入力です';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return '登録したメールアドレスを入力してください';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    resetPasswordEmailFieldTextControllerValidator =
        _resetPasswordEmailFieldTextControllerValidator;
  }

  @override
  void dispose() {
    resetPasswordEmailFieldFocusNode?.dispose();
    resetPasswordEmailFieldTextController?.dispose();
  }
}
