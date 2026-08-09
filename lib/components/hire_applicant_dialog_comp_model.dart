import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'hire_applicant_dialog_comp_widget.dart'
    show HireApplicantDialogCompWidget;
import 'package:flutter/material.dart';

class HireApplicantDialogCompModel
    extends FlutterFlowModel<HireApplicantDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - adminHireWorkPostApplicant] action in HireApplicantButton widget.
  dynamic hireApplicantResult;
  // Stores action output result for [Custom Action - adminGetWorkPosts] action in HireApplicantButton widget.
  List<WorkPostItemStruct>? hireApplicantRefetch;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
