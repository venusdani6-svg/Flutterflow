import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
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
    this.shopId,
    this.shopName,
    this.genre,
    this.prefecture,
    this.city,
    this.townBlock,
    this.building,
    this.active,
  });

  final String? shopId;
  final String? shopName;
  final String? genre;
  final String? prefecture;
  final String? city;
  final String? townBlock;
  final String? building;
  final bool? active;

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

    _model.cocomiseActiveToggleValue = widget.active!;
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
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
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    font: GoogleFonts.interTight(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleMedium.fontStyle,
                  ),
            ),
            Text(
              widget.shopName!,
              style: TextStyle(),
            ),
            Text(
              widget.genre!,
              style: TextStyle(),
            ),
            Text(
              widget.prefecture!,
              style: TextStyle(),
            ),
            Text(
              widget.city!,
              style: TextStyle(),
            ),
            Text(
              widget.townBlock!,
              style: TextStyle(),
            ),
            Text(
              widget.building!,
              style: TextStyle(),
            ),
            TextFormField(
              controller: _model.cocomiseNameFieldTextController,
              focusNode: _model.cocomiseNameFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '店舗名',
                hintText: '店舗名を入力',
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
              validator: _model.cocomiseNameFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomiseGenreFieldTextController,
              focusNode: _model.cocomiseGenreFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'お店ジャンル',
                hintText: '例: 焼き鳥',
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
              validator: _model.cocomiseGenreFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomisePrefectureFieldTextController,
              focusNode: _model.cocomisePrefectureFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '都道府県',
                hintText: '例: 東京都',
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
              validator: _model.cocomisePrefectureFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomiseCityFieldTextController,
              focusNode: _model.cocomiseCityFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '市区町村',
                hintText: '例: 渋谷区',
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
              validator: _model.cocomiseCityFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomiseTownBlockFieldTextController,
              focusNode: _model.cocomiseTownBlockFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '町村番地',
                hintText: '例: 道玄坂1-2-3',
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
              validator: _model.cocomiseTownBlockFieldTextControllerValidator
                  .asValidator(context),
            ),
            TextFormField(
              controller: _model.cocomiseBuildingFieldTextController,
              focusNode: _model.cocomiseBuildingFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '建物名',
                hintText: '例: ○○ビル4F',
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
                      _model.cocomiseDeleteResult =
                          await actions.adminDeleteCocotenShop(
                        widget.shopId,
                      );
                      _model.cocomiseDeleteRefetch =
                          await actions.adminGetCocotenShops(
                        '',
                      );
                      FFAppState().cocomiseShopListStruct = _model
                          .cocomiseDeleteRefetch!
                          .toList()
                          .cast<CocotenShopItemStruct>();
                      safeSetState(() {});
                      Navigator.pop(context);

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
                      _model.cocomiseSaveResult =
                          await actions.adminUpsertCocotenShop(
                        widget.shopId,
                        _model.cocomiseNameFieldTextController.text,
                        _model.cocomiseGenreFieldTextController.text,
                        _model.cocomisePrefectureFieldTextController.text,
                        _model.cocomiseCityFieldTextController.text,
                        _model.cocomiseTownBlockFieldTextController.text,
                        _model.cocomiseBuildingFieldTextController.text,
                        _model.cocomiseActiveToggleValue,
                      );
                      _model.cocomiseSaveRefetch =
                          await actions.adminGetCocotenShops(
                        '',
                      );
                      FFAppState().cocomiseShopListStruct = _model
                          .cocomiseSaveRefetch!
                          .toList()
                          .cast<CocotenShopItemStruct>();
                      safeSetState(() {});
                      Navigator.pop(context);

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
