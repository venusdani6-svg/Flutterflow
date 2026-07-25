import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'search_reservation_dialog_comp_widget.dart'
    show SearchReservationDialogCompWidget;
import 'package:flutter/material.dart';

class SearchReservationDialogCompModel
    extends FlutterFlowModel<SearchReservationDialogCompWidget> {
  ///  Local state fields for this component.

  DateTime? startDate;

  DateTime? endDate;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - adminGetReservations] action in Button widget.
  dynamic reservationFilterResult;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
