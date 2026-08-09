import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'filter_audit_log_dialog_comp_model.dart';
export 'filter_audit_log_dialog_comp_model.dart';

class FilterAuditLogDialogCompWidget extends StatefulWidget {
  const FilterAuditLogDialogCompWidget({super.key});

  @override
  State<FilterAuditLogDialogCompWidget> createState() =>
      _FilterAuditLogDialogCompWidgetState();
}

class _FilterAuditLogDialogCompWidgetState
    extends State<FilterAuditLogDialogCompWidget> {
  late FilterAuditLogDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterAuditLogDialogCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlutterFlowDropDown<String>(
                  controller: _model.dropDownValueController ??=
                      FormFieldController<String>(null),
                  options: List<String>.from([
                    '',
                    'approve_kyc',
                    'reject_kyc',
                    'freeze_account',
                    'unfreeze_account',
                    'force_delete',
                    'force_cancel',
                    'update_reservation_location',
                    'update_affiliate_rate',
                    'delete_banner',
                    'update_system_config',
                    'resolve_report',
                    'payout_on_hold',
                    'payout_rejected',
                    'approve_payout',
                    'create_cocomise',
                    'update_cocomise',
                    'delete_cocomise',
                    'close_work_post',
                    'manual_refund',
                    'update_profile',
                    'create_banner',
                    'update_banner'
                  ]),
                  optionLabels: [
                    'すべて',
                    'KYC承認',
                    'KYC却下',
                    'アカウント凍結',
                    'アカウント凍結解除',
                    '強制退会',
                    '予約強制キャンセル',
                    '予約場所変更',
                    'アフィリエイト料率変更',
                    'バナー削除',
                    'システム設定変更',
                    '通報対応',
                    '出金保留',
                    '出金否認',
                    '出金承認',
                    'ココ店新規登録',
                    'ココ店情報変更',
                    'ココ店削除',
                    'お仕事掲示板投稿終了',
                    '手動返金',
                    'プロフィール編集',
                    'バナー新規作成',
                    'バナー情報変更'
                  ],
                  onChanged: (val) =>
                      safeSetState(() => _model.dropDownValue = val),
                  width: 700.0,
                  height: 40.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 12.0,
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
                    _model.auditLogFilterResult =
                        await actions.adminGetAuditLogs(
                      _model.dropDownValue,
                      '',
                      '',
                    );
                    FFAppState().auditLogListStruct = _model
                        .auditLogFilterResult!
                        .toList()
                        .cast<AuditLogItemStruct>();
                    safeSetState(() {});
                    Navigator.pop(context);

                    safeSetState(() {});
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
