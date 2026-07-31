import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'filter_job_board_dialog_comp_widget.dart'
    show FilterJobBoardDialogCompWidget;
import 'package:flutter/material.dart';

class FilterJobBoardDialogCompModel
    extends FlutterFlowModel<FilterJobBoardDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - adminGetWorkPosts] action in Container widget.
  List<WorkPostItemStruct>? workPostFilterResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
