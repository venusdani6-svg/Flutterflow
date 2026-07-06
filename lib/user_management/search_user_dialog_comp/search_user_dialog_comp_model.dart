import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'search_user_dialog_comp_widget.dart' show SearchUserDialogCompWidget;
import 'package:flutter/material.dart';

class SearchUserDialogCompModel
    extends FlutterFlowModel<SearchUserDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  String? dropDownValue2;
  FormFieldController<String>? dropDownValue2Controller;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
