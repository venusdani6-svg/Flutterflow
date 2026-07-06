import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'staff_userdetails_page_widget.dart' show StaffUserdetailsPageWidget;
import 'package:flutter/material.dart';

class StaffUserdetailsPageModel
    extends FlutterFlowModel<StaffUserdetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;

  String userId = '';

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
