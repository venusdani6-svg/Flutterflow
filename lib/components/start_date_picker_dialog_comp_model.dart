import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'start_date_picker_dialog_comp_widget.dart'
    show StartDatePickerDialogCompWidget;
import 'package:flutter/material.dart';

class StartDatePickerDialogCompModel
    extends FlutterFlowModel<StartDatePickerDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {}
}
