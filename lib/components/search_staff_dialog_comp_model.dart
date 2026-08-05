import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
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
  // Stores action output result for [Custom Action - categoryIsFrozen] action in SearchStaffButton widget.
  bool? staffIsFrozenComputed;
  // Stores action output result for [Custom Action - categoryDateAfter] action in SearchStaffButton widget.
  String? staffAfterComputed;
  // Stores action output result for [Custom Action - categoryDateBefore] action in SearchStaffButton widget.
  String? staffBeforeComputed;
  // Stores action output result for [Custom Action - adminGetUserListItems] action in SearchStaffButton widget.
  List<AdminUserListItemStruct>? staffSearchResult;
  // State field(s) for SearchStaffCategoryDropdown widget.
  String? searchStaffCategoryDropdownValue;
  FormFieldController<String>? searchStaffCategoryDropdownValueController;
  // State field(s) for SearchStaffFrozenDropdown widget.
  String? searchStaffFrozenDropdownValue;
  FormFieldController<String>? searchStaffFrozenDropdownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchStaffKeywordFieldFocusNode?.dispose();
    searchStaffKeywordFieldTextController?.dispose();
  }
}
