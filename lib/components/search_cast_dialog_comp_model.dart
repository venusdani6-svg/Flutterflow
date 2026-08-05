import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
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
  // Stores action output result for [Custom Action - categoryIsFrozen] action in SearchCastButton widget.
  bool? castIsFrozenComputed;
  // Stores action output result for [Custom Action - categoryKycStatus] action in SearchCastButton widget.
  String? castKycComputed;
  // Stores action output result for [Custom Action - categoryPrefecture] action in SearchCastButton widget.
  String? castPrefComputed;
  // Stores action output result for [Custom Action - categoryDateAfter] action in SearchCastButton widget.
  String? castAfterComputed;
  // Stores action output result for [Custom Action - categoryDateBefore] action in SearchCastButton widget.
  String? castBeforeComputed;
  // Stores action output result for [Custom Action - adminGetUserListItems] action in SearchCastButton widget.
  List<AdminUserListItemStruct>? castSearchResult;
  // State field(s) for SearchCastCategoryDropdown widget.
  String? searchCastCategoryDropdownValue;
  FormFieldController<String>? searchCastCategoryDropdownValueController;
  // State field(s) for SearchCastFrozenDropdown widget.
  String? searchCastFrozenDropdownValue;
  FormFieldController<String>? searchCastFrozenDropdownValueController;
  // State field(s) for SearchCastKycDropdown widget.
  String? searchCastKycDropdownValue;
  FormFieldController<String>? searchCastKycDropdownValueController;
  // State field(s) for SearchCastPrefectureDropdown widget.
  String? searchCastPrefectureDropdownValue;
  FormFieldController<String>? searchCastPrefectureDropdownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchCastKeywordFieldFocusNode?.dispose();
    searchCastKeywordFieldTextController?.dispose();
  }
}
