import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
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
  // State field(s) for ReportResolutionReasonField widget.
  FocusNode? reportResolutionReasonFieldFocusNode;
  TextEditingController? reportResolutionReasonFieldTextController;
  String? Function(BuildContext, String?)?
      reportResolutionReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminResolveReport] action in Button widget.
  dynamic resolveResult1Checked;
  // Stores action output result for [Custom Action - adminToggleFreeze] action in Button widget.
  dynamic reportFreezeResultChecked;
  // Stores action output result for [Custom Action - adminResolveReport] action in Button widget.
  dynamic resolveResult1Unchecked;
  // Stores action output result for [Custom Action - adminToggleFreeze] action in Button widget.
  dynamic reportFreezeResultUnchecked;
  // State field(s) for FreezeReportedUserCheckbox widget.
  Map<dynamic, bool> freezeReportedUserCheckboxValueMap = {};
  List<dynamic> get freezeReportedUserCheckboxCheckedItems =>
      freezeReportedUserCheckboxValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // Stores action output result for [Custom Action - adminGetReportChatLog] action in ViewChatLogButton widget.
  ReportChatLogResultStruct? reportChatLogResult;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    reportResolutionReasonFieldFocusNode?.dispose();
    reportResolutionReasonFieldTextController?.dispose();
  }
}
