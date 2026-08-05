import '/backend/schema/structs/index.dart';
import '/components/end_date_picker_dialog_comp_widget.dart';
import '/components/start_date_picker_dialog_comp_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_staff_dialog_comp_model.dart';
export 'search_staff_dialog_comp_model.dart';

/// Keyword search for StaffUserListPage.
///
/// Replaces the previously-shared (and wrong) Search_User_DialogComp
/// reference.
class SearchStaffDialogCompWidget extends StatefulWidget {
  const SearchStaffDialogCompWidget({super.key});

  @override
  State<SearchStaffDialogCompWidget> createState() =>
      _SearchStaffDialogCompWidgetState();
}

class _SearchStaffDialogCompWidgetState
    extends State<SearchStaffDialogCompWidget> {
  late SearchStaffDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchStaffDialogCompModel());

    _model.searchStaffKeywordFieldTextController ??= TextEditingController();
    _model.searchStaffKeywordFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 630.0,
                child: TextFormField(
                  controller: _model.searchStaffKeywordFieldTextController,
                  focusNode: _model.searchStaffKeywordFieldFocusNode,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'キーワード入力してください',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    filled: true,
                  ),
                  style: TextStyle(),
                  maxLines: null,
                  validator: _model
                      .searchStaffKeywordFieldTextControllerValidator
                      .asValidator(context),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  _model.staffIsFrozenComputed = await actions.categoryIsFrozen(
                    _model.searchStaffCategoryDropdownValue,
                    _model.searchStaffFrozenDropdownValue,
                  );
                  _model.staffAfterComputed = await actions.categoryDateAfter(
                    _model.searchStaffCategoryDropdownValue,
                    FFAppState().filterCreatedAfter,
                  );
                  _model.staffBeforeComputed = await actions.categoryDateBefore(
                    _model.searchStaffCategoryDropdownValue,
                    FFAppState().filterCreatedBefore,
                  );
                  _model.staffSearchResult =
                      await actions.adminGetUserListItems(
                    'staff',
                    _model.searchStaffKeywordFieldTextController.text,
                    _model.staffIsFrozenComputed,
                    '',
                    '',
                    _model.staffAfterComputed,
                    _model.staffBeforeComputed,
                  );
                  FFAppState().staffUserListStruct = _model.staffSearchResult!
                      .toList()
                      .cast<AdminUserListItemStruct>();
                  safeSetState(() {});
                  FFAppState().staffActiveIsFrozen =
                      _model.staffIsFrozenComputed!;
                  safeSetState(() {});
                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: '検　索',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFF3829FE),
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ].divide(SizedBox(width: 8.0)),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 700.0,
                height: 40.0,
                child: FlutterFlowDropDown<String>(
                  controller:
                      _model.searchStaffCategoryDropdownValueController ??=
                          FormFieldController<String>(null),
                  options: ['有効 / 凍結状態', '登録期間'],
                  onChanged: (val) => safeSetState(
                      () => _model.searchStaffCategoryDropdownValue = val),
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  hintText: 'フィルタを選択してください',
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 2.0,
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderWidth: 1.0,
                  borderRadius: 8.0,
                  margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                  hidesUnderline: true,
                  isOverButton: false,
                  isSearchable: false,
                  isMultiSelect: false,
                ),
              ),
            ],
          ),
          if (_model.searchStaffCategoryDropdownValue == '有効 / 凍結状態')
            Container(
              width: 200.0,
              height: 40.0,
              child: FlutterFlowDropDown<String>(
                controller: _model.searchStaffFrozenDropdownValueController ??=
                    FormFieldController<String>(
                  _model.searchStaffFrozenDropdownValue ??= '有効',
                ),
                options: ['有効', '凍結中'],
                onChanged: (val) => safeSetState(
                    () => _model.searchStaffFrozenDropdownValue = val),
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
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
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                elevation: 2.0,
                borderColor: FlutterFlowTheme.of(context).alternate,
                borderWidth: 1.0,
                borderRadius: 8.0,
                margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                hidesUnderline: true,
                isOverButton: false,
                isSearchable: false,
                isMultiSelect: false,
              ),
            ),
          if (_model.searchStaffCategoryDropdownValue == '登録期間')
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) => FFButtonWidget(
                      onPressed: () async {
                        await showAlignedDialog(
                          context: context,
                          isGlobal: false,
                          avoidOverflow: false,
                          targetAnchor: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          followerAnchor: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          builder: (dialogContext) {
                            return Material(
                              color: Colors.transparent,
                              child: Container(
                                height: 600.0,
                                width: 400.0,
                                child: StartDatePickerDialogCompWidget(),
                              ),
                            );
                          },
                        );
                      },
                      text: '開始日を選択',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => FFButtonWidget(
                      onPressed: () async {
                        await showAlignedDialog(
                          context: context,
                          isGlobal: false,
                          avoidOverflow: false,
                          targetAnchor: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          followerAnchor: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          builder: (dialogContext) {
                            return Material(
                              color: Colors.transparent,
                              child: Container(
                                height: 600.0,
                                width: 400.0,
                                child: EndDatePickerDialogCompWidget(),
                              ),
                            );
                          },
                        );
                      },
                      text: '終了日を選択',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
        ].divide(SizedBox(height: 24.0)),
      ),
    );
  }
}
