import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filter_k_y_c_dialog_comp_model.dart';
export 'filter_k_y_c_dialog_comp_model.dart';

class FilterKYCDialogCompWidget extends StatefulWidget {
  const FilterKYCDialogCompWidget({super.key});

  @override
  State<FilterKYCDialogCompWidget> createState() =>
      _FilterKYCDialogCompWidgetState();
}

class _FilterKYCDialogCompWidgetState extends State<FilterKYCDialogCompWidget> {
  late FilterKYCDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterKYCDialogCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
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
                  controller: _model.dropDownValueController ??=
                      FormFieldController<String>(
                    _model.dropDownValue ??= 'approved',
                  ),
                  options: List<String>.from(
                      ['pending', 'approved', 'rejected', 'submitted']),
                  optionLabels: ['審査中', '承認済み', '却下', '提出済み'],
                  onChanged: (val) =>
                      safeSetState(() => _model.dropDownValue = val),
                  width: 689.0,
                  height: 40.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  hintText: 'フィルタを選択してください',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 25.0,
                  ),
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  elevation: 2.0,
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderWidth: 0.0,
                  borderRadius: 8.0,
                  margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
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
                    size: 25.0,
                  ),
                  onPressed: () async {
                    FFAppState().kycReviewActiveStatus = _model.dropDownValue!;
                    safeSetState(() {});
                    _model.kycFilterResult = await actions.adminGetUsersV2(
                      '',
                      '',
                      false,
                      FFAppState().kycReviewActiveStatus,
                      '',
                      '',
                      '',
                      '',
                      50,
                      '',
                      '',
                      true,
                    );
                    FFAppState().debugKycRaw = getJsonField(
                      _model.kycFilterResult,
                      r'''$''',
                    ).toString();
                    safeSetState(() {});
                    FFAppState().kycUserList = getJsonField(
                      _model.kycFilterResult,
                      r'''$.users''',
                      true,
                    )!
                        .toList()
                        .cast<dynamic>();
                    _model.updatePage(() {});
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
    );
  }
}
