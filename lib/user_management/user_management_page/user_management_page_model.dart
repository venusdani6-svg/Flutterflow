import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'user_management_page_widget.dart' show UserManagementPageWidget;
import 'package:flutter/material.dart';

class UserManagementPageModel
    extends FlutterFlowModel<UserManagementPageWidget> {
  ///  Local state fields for this page.

  String? guestRegCount = '0';

  String? castRegCount = '0';

  String? staffRegCount = '0';

  String? adminRegCount = '0';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetTodaysRegistrationCounts] action in UserManagementPage widget.
  TodaysRegistrationCountsStruct? regCounts;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
