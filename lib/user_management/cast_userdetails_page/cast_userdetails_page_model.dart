import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'cast_userdetails_page_widget.dart' show CastUserdetailsPageWidget;
import 'package:flutter/material.dart';

class CastUserdetailsPageModel
    extends FlutterFlowModel<CastUserdetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;

  String userId = '';
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

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    tabBarController?.dispose();
  }
}
