import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'job_board_list_page_widget.dart' show JobBoardListPageWidget;
import 'package:flutter/material.dart';

class JobBoardListPageModel extends FlutterFlowModel<JobBoardListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetWorkPosts] action in JobBoardListPage widget.
  List<WorkPostItemStruct>? workPostListInitRaw;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - adminCloseWorkPost] action in CloseWorkPostButton widget.
  dynamic closeWorkPostResult;
  // Stores action output result for [Custom Action - adminGetWorkPosts] action in CloseWorkPostButton widget.
  List<WorkPostItemStruct>? closeWorkPostRefetch;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
