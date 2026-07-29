import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'report_list_page_widget.dart' show ReportListPageWidget;
import 'package:flutter/material.dart';

class ReportListPageModel extends FlutterFlowModel<ReportListPageWidget> {
  ///  Local state fields for this page.

  dynamic reportsResult;

  bool isReportsLoaded = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetReports] action in ReportListPage widget.
  dynamic reportsResult1;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - adminResolveReport] action in Button widget.
  dynamic resolveResult1;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
