import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'filter_stripelog_dialog_comp_widget.dart'
    show FilterStripelogDialogCompWidget;
import 'package:flutter/material.dart';

class FilterStripelogDialogCompModel
    extends FlutterFlowModel<FilterStripelogDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - adminGetStripeLogs] action in Button widget.
  dynamic stripeLogFilterResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
