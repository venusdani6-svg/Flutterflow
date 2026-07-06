import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'cocomise_list_page_widget.dart' show CocomiseListPageWidget;
import 'package:flutter/material.dart';

class CocomiseListPageModel extends FlutterFlowModel<CocomiseListPageWidget> {
  ///  State fields for stateful widgets in this page.

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
