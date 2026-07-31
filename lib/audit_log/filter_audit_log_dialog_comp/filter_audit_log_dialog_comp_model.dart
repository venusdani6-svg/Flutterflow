import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'filter_audit_log_dialog_comp_widget.dart'
    show FilterAuditLogDialogCompWidget;
import 'package:flutter/material.dart';

class FilterAuditLogDialogCompModel
    extends FlutterFlowModel<FilterAuditLogDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - adminGetAuditLogs] action in Container widget.
  List<AuditLogItemStruct>? auditLogFilterResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
