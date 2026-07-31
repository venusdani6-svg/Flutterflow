import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'admin_login_page_widget.dart' show AdminLoginPageWidget;
import 'package:flutter/material.dart';

class AdminLoginPageModel extends FlutterFlowModel<AdminLoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for LoginEmailField widget.
  FocusNode? loginEmailFieldFocusNode;
  TextEditingController? loginEmailFieldTextController;
  String? Function(BuildContext, String?)?
      loginEmailFieldTextControllerValidator;
  String? _loginEmailFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '必須入力です';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'メールアドレスを入力してください';
    }
    return null;
  }

  // State field(s) for LoginPasswordField widget.
  FocusNode? loginPasswordFieldFocusNode;
  TextEditingController? loginPasswordFieldTextController;
  late bool loginPasswordFieldVisibility;
  String? Function(BuildContext, String?)?
      loginPasswordFieldTextControllerValidator;
  String? _loginPasswordFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '必須入力です';
    }

    if (val.length < 8) {
      return 'パスワードは８文字以上を入力してください';
    }

    if (!RegExp('^[a-z0-9]+\$').hasMatch(val)) {
      return 'パスワードは半角小文字と数字のみで入力してください';
    }
    return null;
  }

  @override
  void initState(BuildContext context) {
    loginEmailFieldTextControllerValidator =
        _loginEmailFieldTextControllerValidator;
    loginPasswordFieldVisibility = false;
    loginPasswordFieldTextControllerValidator =
        _loginPasswordFieldTextControllerValidator;
  }

  @override
  void dispose() {
    loginEmailFieldFocusNode?.dispose();
    loginEmailFieldTextController?.dispose();

    loginPasswordFieldFocusNode?.dispose();
    loginPasswordFieldTextController?.dispose();
  }
}
