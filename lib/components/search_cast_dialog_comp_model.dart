import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_cast_dialog_comp_widget.dart' show SearchCastDialogCompWidget;
import 'package:flutter/material.dart';

class SearchCastDialogCompModel
    extends FlutterFlowModel<SearchCastDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for SearchCastKeywordField widget.
  FocusNode? searchCastKeywordFieldFocusNode;
  TextEditingController? searchCastKeywordFieldTextController;
  String? Function(BuildContext, String?)?
      searchCastKeywordFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminGetUserListItems] action in SearchCastButton widget.
  List<AdminUserListItemStruct>? castSearchResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchCastKeywordFieldFocusNode?.dispose();
    searchCastKeywordFieldTextController?.dispose();
  }
}
