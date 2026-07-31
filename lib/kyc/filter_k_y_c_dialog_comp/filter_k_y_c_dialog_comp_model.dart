import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'filter_k_y_c_dialog_comp_widget.dart' show FilterKYCDialogCompWidget;
import 'package:flutter/material.dart';

class FilterKYCDialogCompModel
    extends FlutterFlowModel<FilterKYCDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - adminGetKycUsersList] action in IconButton widget.
  List<KycUserItemStruct>? kycFilterResultTyped;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
