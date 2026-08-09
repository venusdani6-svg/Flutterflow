import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cocomise_edit_dialog_comp_model.dart';
export 'cocomise_edit_dialog_comp_model.dart';

/// Create/edit form for a single cocoten_shops record.
///
/// Empty shopId param means "create new"; a non-empty shopId means "edit this
/// shop" (also enables the delete button).
class CocomiseEditDialogCompWidget extends StatefulWidget {
  const CocomiseEditDialogCompWidget({
    super.key,
    String? shopId,
    String? shopName,
    String? genre,
    String? prefecture,
    String? city,
    String? townBlock,
    String? building,
    bool? active,
  })  : this.shopId = shopId ?? '',
        this.shopName = shopName ?? '',
        this.genre = genre ?? '',
        this.prefecture = prefecture ?? '',
        this.city = city ?? '',
        this.townBlock = townBlock ?? '',
        this.building = building ?? '',
        this.active = active ?? true;

  final String shopId;
  final String shopName;
  final String genre;
  final String prefecture;
  final String city;
  final String townBlock;
  final String building;
  final bool active;

  @override
  State<CocomiseEditDialogCompWidget> createState() =>
      _CocomiseEditDialogCompWidgetState();
}

class _CocomiseEditDialogCompWidgetState
    extends State<CocomiseEditDialogCompWidget> {
  late CocomiseEditDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CocomiseEditDialogCompModel());

    _model.cocomiseNameFieldTextController ??= TextEditingController();
    _model.cocomiseNameFieldFocusNode ??= FocusNode();

    _model.cocomiseGenreFieldTextController ??= TextEditingController();
    _model.cocomiseGenreFieldFocusNode ??= FocusNode();

    _model.cocomisePrefectureFieldTextController ??= TextEditingController();
    _model.cocomisePrefectureFieldFocusNode ??= FocusNode();

    _model.cocomiseCityFieldTextController ??= TextEditingController();
    _model.cocomiseCityFieldFocusNode ??= FocusNode();

    _model.cocomiseTownBlockFieldTextController ??= TextEditingController();
    _model.cocomiseTownBlockFieldFocusNode ??= FocusNode();

    _model.cocomiseBuildingFieldTextController ??= TextEditingController();
    _model.cocomiseBuildingFieldFocusNode ??= FocusNode();

    _model.cocomiseActiveToggleValue = widget.active;
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 24.0,
            color: Color(0x1F000000),
            offset: Offset(
              0.0,
              8.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ココ店登録・編集',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    font: GoogleFonts.interTight(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primary,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
            ),
            Text(
              functions.cocomiseCurrentValueLabel(widget.shopName)!,
              style: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12.0,
              ),
            ),
            Text(
              functions.cocomiseCurrentValueLabel(widget.genre)!,
              style: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12.0,
              ),
            ),
            Text(
              functions.cocomiseCurrentValueLabel(widget.prefecture)!,
              style: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12.0,
              ),
            ),
            Text(
              functions.cocomiseCurrentValueLabel(widget.city)!,
              style: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12.0,
              ),
            ),
            Text(
              functions.cocomiseCurrentValueLabel(widget.townBlock)!,
              style: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12.0,
              ),
            ),
            Text(
              functions.cocomiseCurrentValueLabel(widget.building)!,
              style: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 12.0,
              ),
            ),
            TextFormField(
              controller: _model.cocomiseNameFieldTextController,
              focusNode: _model.cocomiseNameFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '店舗名',
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                hintText: '店舗名を入力',
                hintStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
              ),
              style: TextStyle(),
              maxLines: null,
              cursorColor: FlutterFlowTheme.of(context).primary,
              validator: _model.cocomiseNameFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomiseGenreFieldTextController,
              focusNode: _model.cocomiseGenreFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'お店ジャンル',
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                hintText: '例: 焼き鳥',
                hintStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
              ),
              style: TextStyle(),
              maxLines: null,
              cursorColor: FlutterFlowTheme.of(context).primary,
              validator: _model.cocomiseGenreFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomisePrefectureFieldTextController,
              focusNode: _model.cocomisePrefectureFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '都道府県',
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                hintText: '例: 東京都',
                hintStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
              ),
              style: TextStyle(),
              maxLines: null,
              cursorColor: FlutterFlowTheme.of(context).primary,
              validator: _model.cocomisePrefectureFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomiseCityFieldTextController,
              focusNode: _model.cocomiseCityFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '市区町村',
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                hintText: '例: 渋谷区',
                hintStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
              ),
              style: TextStyle(),
              maxLines: null,
              cursorColor: FlutterFlowTheme.of(context).primary,
              validator: _model.cocomiseCityFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomiseTownBlockFieldTextController,
              focusNode: _model.cocomiseTownBlockFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '町村番地',
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                hintText: '例: 道玄坂1-2-3',
                hintStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
              ),
              style: TextStyle(),
              maxLines: null,
              cursorColor: FlutterFlowTheme.of(context).primary,
              validator: _model.cocomiseTownBlockFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomiseBuildingFieldTextController,
              focusNode: _model.cocomiseBuildingFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '建物名',
                labelStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                hintText: '例: ○○ビル4F',
                hintStyle: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).primary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
              ),
              style: TextStyle(),
              maxLines: null,
              cursorColor: FlutterFlowTheme.of(context).primary,
              validator: _model.cocomiseBuildingFieldTextControllerValidator
                  .asValidator(context),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '有効状態',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                ),
                Switch(
                  value: _model.cocomiseActiveToggleValue!,
                  onChanged: (newValue) async {
                    safeSetState(
                        () => _model.cocomiseActiveToggleValue = newValue);
                  },
                  activeThumbColor: FlutterFlowTheme.of(context).primary,
                  activeTrackColor: FlutterFlowTheme.of(context).accent1,
                  inactiveTrackColor:
                      FlutterFlowTheme.of(context).primaryBackground,
                  inactiveThumbColor:
                      FlutterFlowTheme.of(context).secondaryText,
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!(widget.shopId == ''))
                  FFButtonWidget(
                    onPressed: () async {
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('削除確認'),
                                content: Text('この店舗情報を削除します。よろしいですか？'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: Text('キャンセル'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: Text('削除する'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      if (confirmDialogResponse) {
                        _model.cocomiseDeleteOutcome =
                            await actions.deleteCocotenShopAndRefresh(
                          widget.shopId,
                        );
                        if (_model.cocomiseDeleteOutcome!) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '削除に失敗しました。もう一度お試しください。',
                                style: TextStyle(),
                              ),
                              duration: Duration(milliseconds: 4000),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '操作をキャンセルしました。',
                              style: TextStyle(),
                            ),
                            duration: Duration(milliseconds: 4000),
                          ),
                        );
                      }

                      safeSetState(() {});
                    },
                    text: '削除',
                    options: FFButtonOptions(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).error,
                      textStyle: TextStyle(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.cocomiseNameFilledCheck =
                          await actions.cocomiseNameFilled(
                        _model.cocomiseNameFieldTextController.text,
                      );
                      if (_model.cocomiseNameFilledCheck!) {
                        _model.cocomiseSaveOutcome =
                            await actions.upsertCocotenShopAndRefresh(
                          widget.shopId,
                          _model.cocomiseNameFieldTextController.text,
                          _model.cocomiseGenreFieldTextController.text,
                          _model.cocomisePrefectureFieldTextController.text,
                          _model.cocomiseCityFieldTextController.text,
                          _model.cocomiseTownBlockFieldTextController.text,
                          _model.cocomiseBuildingFieldTextController.text,
                          _model.cocomiseActiveToggleValue,
                        );
                        if (_model.cocomiseSaveOutcome!) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '保存に失敗しました。店舗名など必須項目を確認してください。',
                                style: TextStyle(),
                              ),
                              duration: Duration(milliseconds: 4000),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '店舗名を入力してください。',
                              style: TextStyle(),
                            ),
                            duration: Duration(milliseconds: 4000),
                          ),
                        );
                      }

                      safeSetState(() {});
                    },
                    text: '保存',
                    options: FFButtonOptions(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: TextStyle(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  text: 'キャンセル',
                  options: FFButtonOptions(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Colors.transparent,
                    textStyle: TextStyle(
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ].divide(SizedBox(height: 12.0)),
        ),
      ),
    );
  }
}
