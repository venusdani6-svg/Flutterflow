import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filter_ledgert_dialog_comp_model.dart';
export 'filter_ledgert_dialog_comp_model.dart';

class FilterLedgertDialogCompWidget extends StatefulWidget {
  const FilterLedgertDialogCompWidget({super.key});

  @override
  State<FilterLedgertDialogCompWidget> createState() =>
      _FilterLedgertDialogCompWidgetState();
}

class _FilterLedgertDialogCompWidgetState
    extends State<FilterLedgertDialogCompWidget> {
  late FilterLedgertDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterLedgertDialogCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlutterFlowDropDown<String>(
                      controller: _model.dropDownValueController1 ??=
                          FormFieldController<String>(null),
                      options: List<String>.from([
                        '',
                        'reward',
                        'staff_fee',
                        'refund',
                        'affiliate',
                        'debt_offset',
                        'tip'
                      ]),
                      optionLabels: [
                        'すべて',
                        '報酬',
                        'スタッフ費用',
                        '返金',
                        'アフィリエイト報酬',
                        '負債相殺',
                        'チップ '
                      ],
                      onChanged: (val) =>
                          safeSetState(() => _model.dropDownValue1 = val),
                      width: 600.0,
                      height: 40.0,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                      hintText: '種別で絞り込み',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      elevation: 2.0,
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      borderWidth: 0.0,
                      borderRadius: 8.0,
                      margin:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),
                    FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        Icons.search,
                        color: FlutterFlowTheme.of(context).info,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        FFAppState().activeLedgerTypeFilter =
                            _model.dropDownValue1!;
                        safeSetState(() {});
                        FFAppState().activeLedgerStatusFilter =
                            _model.dropDownValue2!;
                        safeSetState(() {});
                        _model.ledgerFilterResult =
                            await actions.adminGetLedger(
                          '',
                          FFAppState().activeLedgerTypeFilter,
                          FFAppState().activeLedgerStatusFilter,
                          100,
                          '',
                          FFAppState().activeLedgerCreatedAfter,
                          FFAppState().activeLedgerCreatedBefore,
                        );
                        FFAppState().ledgerList = getJsonField(
                          _model.ledgerFilterResult,
                          r'''$.entries''',
                          true,
                        )!
                            .toList()
                            .cast<dynamic>();
                        safeSetState(() {});
                        Navigator.pop(context);

                        safeSetState(() {});
                      },
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterFlowDropDown<String>(
                      controller: _model.dropDownValueController2 ??=
                          FormFieldController<String>(null),
                      options: List<String>.from(
                          ['', 'pending', 'confirmed', 'failed', 'retrying']),
                      optionLabels: ['すべて', '保留中', '確定', '失敗', '再試行中'],
                      onChanged: (val) =>
                          safeSetState(() => _model.dropDownValue2 = val),
                      width: 700.0,
                      height: 40.0,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                      hintText: '状態で絞り込み',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      elevation: 2.0,
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      borderWidth: 0.0,
                      borderRadius: 8.0,
                      margin:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      hidesUnderline: true,
                      isOverButton: false,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.0,
                      height: 40.0,
                      child: custom_widgets.LedgerDateFilterField(
                        width: 100.0,
                        height: 40.0,
                        hintText: '開始日',
                        isStartDate: true,
                      ),
                    ),
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                    ))
                      Container(
                        width: 100.0,
                        height: 40.0,
                        child: custom_widgets.LedgerDateFilterField(
                          width: 100.0,
                          height: 40.0,
                          hintText: '終了日',
                          isStartDate: false,
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                        ),
                        child: Icon(
                          Icons.close,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ].divide(SizedBox(height: 24.0)).around(SizedBox(height: 24.0)),
            ),
          ),
        ),
      ],
    );
  }
}
