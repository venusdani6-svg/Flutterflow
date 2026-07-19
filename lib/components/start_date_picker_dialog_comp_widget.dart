import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'start_date_picker_dialog_comp_model.dart';
export 'start_date_picker_dialog_comp_model.dart';

class StartDatePickerDialogCompWidget extends StatefulWidget {
  const StartDatePickerDialogCompWidget({super.key});

  @override
  State<StartDatePickerDialogCompWidget> createState() =>
      _StartDatePickerDialogCompWidgetState();
}

class _StartDatePickerDialogCompWidgetState
    extends State<StartDatePickerDialogCompWidget> {
  late StartDatePickerDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartDatePickerDialogCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 319.0,
      height: 354.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: FlutterFlowCalendar(
              color: FlutterFlowTheme.of(context).primary,
              iconColor: FlutterFlowTheme.of(context).secondaryText,
              weekFormat: false,
              weekStartsMonday: false,
              rowHeight: 48.0,
              onChange: (DateTimeRange? newSelectedDate) async {
                if (_model.calendarSelectedDay == newSelectedDate) {
                  return;
                }
                _model.calendarSelectedDay = newSelectedDate;
                FFAppState().filterCreatedAfter =
                    _model.calendarSelectedDay?.start;
                safeSetState(() {});
                safeSetState(() {});
              },
              titleStyle: FlutterFlowTheme.of(context).titleLarge.override(
                    font: GoogleFonts.interTight(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
              dayOfWeekStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                  ),
              dateStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
              selectedDateStyle: FlutterFlowTheme.of(context)
                  .titleSmall
                  .override(
                    font: GoogleFonts.interTight(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleSmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleSmall.fontStyle,
                  ),
              inactiveDateStyle: FlutterFlowTheme.of(context)
                  .labelMedium
                  .override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 1.0),
            child: FFButtonWidget(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: 'Save',
              icon: Icon(
                Icons.save,
                size: 15.0,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Color(0x3144484B),
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.1,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  shadows: [
                    Shadow(
                      color: FlutterFlowTheme.of(context).secondaryText,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 2.0,
                    )
                  ],
                ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(12.0),
                hoverBorderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
