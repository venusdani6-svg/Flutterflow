import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'administrator_list_page_widget.dart' show AdministratorListPageWidget;
import 'package:flutter/material.dart';

class AdministratorListPageModel
    extends FlutterFlowModel<AdministratorListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetUserListItems] action in AdministratorListPage widget.
  List<AdminUserListItemStruct>? administratorListInitRaw;
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
