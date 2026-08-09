import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_work_post_dialog_comp_widget.dart'
    show CreateWorkPostDialogCompWidget;
import 'package:flutter/material.dart';

class CreateWorkPostDialogCompModel
    extends FlutterFlowModel<CreateWorkPostDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for WorkPostTypeDropdown widget.
  String? workPostTypeDropdownValue;
  FormFieldController<String>? workPostTypeDropdownValueController;
  // State field(s) for WorkPostDescriptionField widget.
  FocusNode? workPostDescriptionFieldFocusNode;
  TextEditingController? workPostDescriptionFieldTextController;
  String? Function(BuildContext, String?)?
      workPostDescriptionFieldTextControllerValidator;
  // State field(s) for WorkPostLocationField widget.
  FocusNode? workPostLocationFieldFocusNode;
  TextEditingController? workPostLocationFieldTextController;
  String? Function(BuildContext, String?)?
      workPostLocationFieldTextControllerValidator;
  // State field(s) for WorkPostFeeField widget.
  FocusNode? workPostFeeFieldFocusNode;
  TextEditingController? workPostFeeFieldTextController;
  String? Function(BuildContext, String?)?
      workPostFeeFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminCreateWorkPost] action in CreateWorkPostSubmitButton widget.
  WorkPostCreateResultStruct? createWorkPostResult;
  // Stores action output result for [Custom Action - adminGetWorkPosts] action in CreateWorkPostSubmitButton widget.
  List<WorkPostItemStruct>? createWorkPostRefetch;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    workPostDescriptionFieldFocusNode?.dispose();
    workPostDescriptionFieldTextController?.dispose();

    workPostLocationFieldFocusNode?.dispose();
    workPostLocationFieldTextController?.dispose();

    workPostFeeFieldFocusNode?.dispose();
    workPostFeeFieldTextController?.dispose();
  }
}
