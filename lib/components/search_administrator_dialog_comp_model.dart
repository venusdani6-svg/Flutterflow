import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'search_administrator_dialog_comp_widget.dart'
    show SearchAdministratorDialogCompWidget;
import 'package:flutter/material.dart';

class SearchAdministratorDialogCompModel
    extends FlutterFlowModel<SearchAdministratorDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for SearchAdministratorKeywordField widget.
  FocusNode? searchAdministratorKeywordFieldFocusNode;
  TextEditingController? searchAdministratorKeywordFieldTextController;
  String? Function(BuildContext, String?)?
      searchAdministratorKeywordFieldTextControllerValidator;
  // Stores action output result for [Custom Action - categoryIsFrozen] action in SearchAdministratorButton widget.
  bool? adminIsFrozenComputed;
  // Stores action output result for [Custom Action - categoryPrefecture] action in SearchAdministratorButton widget.
  String? adminPrefComputed;
  // Stores action output result for [Custom Action - categoryDateAfter] action in SearchAdministratorButton widget.
  String? adminAfterComputed;
  // Stores action output result for [Custom Action - categoryDateBefore] action in SearchAdministratorButton widget.
  String? adminBeforeComputed;
  // Stores action output result for [Custom Action - adminGetUserListItems] action in SearchAdministratorButton widget.
  List<AdminUserListItemStruct>? adminSearchResult;
  // State field(s) for SearchAdministratorCategoryDropdown widget.
  String? searchAdministratorCategoryDropdownValue;
  FormFieldController<String>?
      searchAdministratorCategoryDropdownValueController;
  // State field(s) for SearchAdministratorFrozenDropdown widget.
  String? searchAdministratorFrozenDropdownValue;
  FormFieldController<String>? searchAdministratorFrozenDropdownValueController;
  // State field(s) for SearchAdministratorPrefectureDropdown widget.
  String? searchAdministratorPrefectureDropdownValue;
  FormFieldController<String>?
      searchAdministratorPrefectureDropdownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchAdministratorKeywordFieldFocusNode?.dispose();
    searchAdministratorKeywordFieldTextController?.dispose();
  }
}
