import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'processed_events_list_page_widget.dart'
    show ProcessedEventsListPageWidget;
import 'package:flutter/material.dart';

class ProcessedEventsListPageModel
    extends FlutterFlowModel<ProcessedEventsListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetProcessedEvents] action in ProcessedEventsListPage widget.
  List<ProcessedEventItemStruct>? processedEventsInitRaw;
  // Model for Main_Menu_Comp.
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
