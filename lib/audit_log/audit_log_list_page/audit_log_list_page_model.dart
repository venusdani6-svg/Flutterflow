import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'audit_log_list_page_widget.dart' show AuditLogListPageWidget;
import 'package:flutter/material.dart';

class AuditLogListPageModel extends FlutterFlowModel<AuditLogListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetAuditLogs] action in AuditLogListPage widget.
  List<AuditLogItemStruct>? auditLogInitRaw;
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
