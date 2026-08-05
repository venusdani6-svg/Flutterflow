import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'staff_userdetails_page_widget.dart' show StaffUserdetailsPageWidget;
import 'package:flutter/material.dart';

class StaffUserdetailsPageModel
    extends FlutterFlowModel<StaffUserdetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // State field(s) for ForceDeleteUserReasonField widget.
  FocusNode? forceDeleteUserReasonFieldFocusNode;
  TextEditingController? forceDeleteUserReasonFieldTextController;
  String? Function(BuildContext, String?)?
      forceDeleteUserReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminForceDeleteUser] action in ForceDeleteUserButton widget.
  dynamic forceDeleteUserResult;
  // State field(s) for FreezeUserReasonField widget.
  FocusNode? freezeUserReasonFieldFocusNode;
  TextEditingController? freezeUserReasonFieldTextController;
  String? Function(BuildContext, String?)?
      freezeUserReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminToggleFreeze] action in FreezeUserButton widget.
  dynamic freezeUserResult;
  // Stores action output result for [Custom Action - adminToggleFreeze] action in UnfreezeUserButton widget.
  dynamic unfreezeUserResult;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    forceDeleteUserReasonFieldFocusNode?.dispose();
    forceDeleteUserReasonFieldTextController?.dispose();

    freezeUserReasonFieldFocusNode?.dispose();
    freezeUserReasonFieldTextController?.dispose();
  }
}
