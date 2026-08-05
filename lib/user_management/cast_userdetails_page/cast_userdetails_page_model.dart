import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'cast_userdetails_page_widget.dart' show CastUserdetailsPageWidget;
import 'package:flutter/material.dart';

class CastUserdetailsPageModel
    extends FlutterFlowModel<CastUserdetailsPageWidget> {
  ///  Local state fields for this page.

  dynamic castDetail;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetUsers] action in CastUserdetailsPage widget.
  dynamic castUserDetailResult;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
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
    tabBarController?.dispose();
    forceDeleteUserReasonFieldFocusNode?.dispose();
    forceDeleteUserReasonFieldTextController?.dispose();

    freezeUserReasonFieldFocusNode?.dispose();
    freezeUserReasonFieldTextController?.dispose();
  }
}
