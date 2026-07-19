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
  // Stores action output result for [Custom Action - adminGetUsers] action in Button widget.
  dynamic searchResult;
  // State field(s) for FilterCategoryDropDown widget.
  String? filterCategoryDropDownValue;
  FormFieldController<String>? filterCategoryDropDownValueController;
  // State field(s) for FrozenStatusDropDown widget.
  String? frozenStatusDropDownValue;
  FormFieldController<String>? frozenStatusDropDownValueController;
  // State field(s) for KycStatusDropDown widget.
  String? kycStatusDropDownValue;
  FormFieldController<String>? kycStatusDropDownValueController;
  // State field(s) for AccountTypeDropDown widget.
  String? accountTypeDropDownValue;
  FormFieldController<String>? accountTypeDropDownValueController;
  // State field(s) for PrefectureDropDown widget.
  String? prefectureDropDownValue;
  FormFieldController<String>? prefectureDropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
