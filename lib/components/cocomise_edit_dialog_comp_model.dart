import '/flutter_flow/flutter_flow_util.dart';
import 'cocomise_edit_dialog_comp_widget.dart'
    show CocomiseEditDialogCompWidget;
import 'package:flutter/material.dart';

class CocomiseEditDialogCompModel
    extends FlutterFlowModel<CocomiseEditDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for CocomiseNameField widget.
  FocusNode? cocomiseNameFieldFocusNode;
  TextEditingController? cocomiseNameFieldTextController;
  String? Function(BuildContext, String?)?
      cocomiseNameFieldTextControllerValidator;
  // State field(s) for CocomiseGenreField widget.
  FocusNode? cocomiseGenreFieldFocusNode;
  TextEditingController? cocomiseGenreFieldTextController;
  String? Function(BuildContext, String?)?
      cocomiseGenreFieldTextControllerValidator;
  // State field(s) for CocomisePrefectureField widget.
  FocusNode? cocomisePrefectureFieldFocusNode;
  TextEditingController? cocomisePrefectureFieldTextController;
  String? Function(BuildContext, String?)?
      cocomisePrefectureFieldTextControllerValidator;
  // State field(s) for CocomiseCityField widget.
  FocusNode? cocomiseCityFieldFocusNode;
  TextEditingController? cocomiseCityFieldTextController;
  String? Function(BuildContext, String?)?
      cocomiseCityFieldTextControllerValidator;
  // State field(s) for CocomiseTownBlockField widget.
  FocusNode? cocomiseTownBlockFieldFocusNode;
  TextEditingController? cocomiseTownBlockFieldTextController;
  String? Function(BuildContext, String?)?
      cocomiseTownBlockFieldTextControllerValidator;
  // State field(s) for CocomiseBuildingField widget.
  FocusNode? cocomiseBuildingFieldFocusNode;
  TextEditingController? cocomiseBuildingFieldTextController;
  String? Function(BuildContext, String?)?
      cocomiseBuildingFieldTextControllerValidator;
  // State field(s) for CocomiseActiveToggle widget.
  bool? cocomiseActiveToggleValue;
  // Stores action output result for [Custom Action - deleteCocotenShopAndRefresh] action in CocomiseDeleteButton widget.
  bool? cocomiseDeleteOutcome;
  // Stores action output result for [Custom Action - cocomiseNameFilled] action in CocomiseSaveButton widget.
  bool? cocomiseNameFilledCheck;
  // Stores action output result for [Custom Action - upsertCocotenShopAndRefresh] action in CocomiseSaveButton widget.
  bool? cocomiseSaveOutcome;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    cocomiseNameFieldFocusNode?.dispose();
    cocomiseNameFieldTextController?.dispose();

    cocomiseGenreFieldFocusNode?.dispose();
    cocomiseGenreFieldTextController?.dispose();

    cocomisePrefectureFieldFocusNode?.dispose();
    cocomisePrefectureFieldTextController?.dispose();

    cocomiseCityFieldFocusNode?.dispose();
    cocomiseCityFieldTextController?.dispose();

    cocomiseTownBlockFieldFocusNode?.dispose();
    cocomiseTownBlockFieldTextController?.dispose();

    cocomiseBuildingFieldFocusNode?.dispose();
    cocomiseBuildingFieldTextController?.dispose();
  }
}
