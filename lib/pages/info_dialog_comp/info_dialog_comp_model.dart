import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'info_dialog_comp_widget.dart' show InfoDialogCompWidget;
import 'package:flutter/material.dart';

class InfoDialogCompModel extends FlutterFlowModel<InfoDialogCompWidget> {
  ///  Local state fields for this component.

  List<AdminActivityLogItemStruct> activityLog = [];
  void addToActivityLog(AdminActivityLogItemStruct item) =>
      activityLog.add(item);
  void removeFromActivityLog(AdminActivityLogItemStruct item) =>
      activityLog.remove(item);
  void removeAtIndexFromActivityLog(int index) => activityLog.removeAt(index);
  void insertAtIndexInActivityLog(int index, AdminActivityLogItemStruct item) =>
      activityLog.insert(index, item);
  void updateActivityLogAtIndex(
          int index, Function(AdminActivityLogItemStruct) updateFn) =>
      activityLog[index] = updateFn(activityLog[index]);

  bool? hasActivityLog;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - adminGetUserActivityLog] action in Info_DialogComp widget.
  List<AdminActivityLogItemStruct>? activityLogFetch;
  // Stores action output result for [Custom Action - adminHasUserActivityLog] action in Info_DialogComp widget.
  bool? hasActivityLogFetch;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
