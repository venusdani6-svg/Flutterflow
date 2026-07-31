import '/flutter_flow/flutter_flow_util.dart';
import 'kyc_review_dialog_comp_widget.dart' show KycReviewDialogCompWidget;
import 'package:flutter/material.dart';

class KycReviewDialogCompModel
    extends FlutterFlowModel<KycReviewDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for RejectReasonField widget.
  FocusNode? rejectReasonFieldFocusNode;
  TextEditingController? rejectReasonFieldTextController;
  String? Function(BuildContext, String?)?
      rejectReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminApproveKYC] action in Button widget.
  dynamic kycRejectResult;
  // Stores action output result for [Custom Action - adminApproveKYC] action in Button widget.
  dynamic kycApproveResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    rejectReasonFieldFocusNode?.dispose();
    rejectReasonFieldTextController?.dispose();
  }
}
