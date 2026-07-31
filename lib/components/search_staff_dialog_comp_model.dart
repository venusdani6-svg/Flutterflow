import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_staff_dialog_comp_widget.dart' show SearchStaffDialogCompWidget;
import 'package:flutter/material.dart';

class SearchStaffDialogCompModel
    extends FlutterFlowModel<SearchStaffDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for SearchStaffKeywordField widget.
  FocusNode? searchStaffKeywordFieldFocusNode;
  TextEditingController? searchStaffKeywordFieldTextController;
  String? Function(BuildContext, String?)?
      searchStaffKeywordFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminGetUserListItems] action in SearchStaffButton widget.
  List<AdminUserListItemStruct>? staffSearchResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchStaffKeywordFieldFocusNode?.dispose();
    searchStaffKeywordFieldTextController?.dispose();
  }
}
