import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
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
  // Stores action output result for [Custom Action - adminGetUserListItems] action in SearchAdministratorButton widget.
  List<AdminUserListItemStruct>? administratorSearchResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchAdministratorKeywordFieldFocusNode?.dispose();
    searchAdministratorKeywordFieldTextController?.dispose();
  }
}
