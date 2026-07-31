import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prefectures_dialog_comp_model.dart';
export 'prefectures_dialog_comp_model.dart';

class PrefecturesDialogCompWidget extends StatefulWidget {
  const PrefecturesDialogCompWidget({super.key});

  @override
  State<PrefecturesDialogCompWidget> createState() =>
      _PrefecturesDialogCompWidgetState();
}

class _PrefecturesDialogCompWidgetState
    extends State<PrefecturesDialogCompWidget> {
  late PrefecturesDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrefecturesDialogCompModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.prefDialogConfigInit = await actions.adminGetSystemConfig();
      _model.hokkaidoActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_hokkaido_active''',
      );
      safeSetState(() {});
      _model.aomoriActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_aomori_active''',
      );
      safeSetState(() {});
      _model.iwateActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_iwate_active''',
      );
      safeSetState(() {});
      _model.miyagiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_miyagi_active''',
      );
      safeSetState(() {});
      _model.akitaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_akita_active''',
      );
      safeSetState(() {});
      _model.yamagataActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_yamagata_active''',
      );
      safeSetState(() {});
      _model.fukushimaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_fukushima_active''',
      );
      safeSetState(() {});
      _model.ibarakiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_ibaraki_active''',
      );
      safeSetState(() {});
      _model.tochigiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_tochigi_active''',
      );
      safeSetState(() {});
      _model.gunmaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_gunma_active''',
      );
      safeSetState(() {});
      _model.saitamaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_saitama_active''',
      );
      safeSetState(() {});
      _model.chibaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_chiba_active''',
      );
      safeSetState(() {});
      _model.tokyoActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_tokyo_active''',
      );
      safeSetState(() {});
      _model.kanagawaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_kanagawa_active''',
      );
      safeSetState(() {});
      _model.niigataActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_niigata_active''',
      );
      safeSetState(() {});
      _model.toyamaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_toyama_active''',
      );
      safeSetState(() {});
      _model.ishikawaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_ishikawa_active''',
      );
      safeSetState(() {});
      _model.fukuiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_fukui_active''',
      );
      safeSetState(() {});
      _model.yamanashiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_yamanashi_active''',
      );
      safeSetState(() {});
      _model.naganoActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_nagano_active''',
      );
      safeSetState(() {});
      _model.gifuActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_gifu_active''',
      );
      safeSetState(() {});
      _model.shizuokaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_shizuoka_active''',
      );
      safeSetState(() {});
      _model.aichiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_aichi_active''',
      );
      safeSetState(() {});
      _model.mieActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_mie_active''',
      );
      safeSetState(() {});
      _model.shigaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_shiga_active''',
      );
      safeSetState(() {});
      _model.kyotoActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_kyoto_active''',
      );
      safeSetState(() {});
      _model.osakaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_osaka_active''',
      );
      safeSetState(() {});
      _model.hyogoActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_hyogo_active''',
      );
      safeSetState(() {});
      _model.naraActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_nara_active''',
      );
      safeSetState(() {});
      _model.wakayamaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_wakayama_active''',
      );
      safeSetState(() {});
      _model.tottoriActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_tottori_active''',
      );
      safeSetState(() {});
      _model.shimaneActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_shimane_active''',
      );
      safeSetState(() {});
      _model.okayamaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_okayama_active''',
      );
      safeSetState(() {});
      _model.hiroshimaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_hiroshima_active''',
      );
      safeSetState(() {});
      _model.yamaguchiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_yamaguchi_active''',
      );
      safeSetState(() {});
      _model.tokushimaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_tokushima_active''',
      );
      safeSetState(() {});
      _model.kagawaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_kagawa_active''',
      );
      safeSetState(() {});
      _model.ehimeActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_ehime_active''',
      );
      safeSetState(() {});
      _model.kochiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_kochi_active''',
      );
      safeSetState(() {});
      _model.fukuokaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_fukuoka_active''',
      );
      safeSetState(() {});
      _model.sagaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_saga_active''',
      );
      safeSetState(() {});
      _model.nagasakiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_nagasaki_active''',
      );
      safeSetState(() {});
      _model.kumamotoActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_kumamoto_active''',
      );
      safeSetState(() {});
      _model.oitaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_oita_active''',
      );
      safeSetState(() {});
      _model.miyazakiActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_miyazaki_active''',
      );
      safeSetState(() {});
      _model.kagoshimaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_kagoshima_active''',
      );
      safeSetState(() {});
      _model.okinawaActive = getJsonField(
        _model.prefDialogConfigInit,
        r'''$.area_okinawa_active''',
      );
      safeSetState(() {});
    });

    _model.switchValue1 = _model.hokkaidoActive!;
    _model.switchValue2 = _model.aomoriActive!;
    _model.switchValue3 = _model.iwateActive!;
    _model.switchValue4 = _model.miyagiActive!;
    _model.switchValue5 = _model.akitaActive!;
    _model.switchValue6 = _model.yamagataActive!;
    _model.switchValue7 = _model.fukushimaActive!;
    _model.switchValue8 = _model.ibarakiActive!;
    _model.switchValue9 = _model.tochigiActive!;
    _model.switchValue10 = _model.gunmaActive!;
    _model.switchValue11 = _model.saitamaActive!;
    _model.switchValue12 = _model.chibaActive!;
    _model.switchValue13 = _model.tokyoActive!;
    _model.switchValue14 = _model.kanagawaActive!;
    _model.switchValue15 = _model.niigataActive!;
    _model.switchValue16 = _model.toyamaActive!;
    _model.switchValue17 = _model.ishikawaActive!;
    _model.switchValue18 = _model.fukuiActive!;
    _model.switchValue19 = _model.yamanashiActive!;
    _model.switchValue20 = _model.naganoActive!;
    _model.switchValue21 = _model.gifuActive!;
    _model.switchValue22 = _model.shizuokaActive!;
    _model.switchValue23 = _model.aichiActive!;
    _model.switchValue24 = _model.mieActive!;
    _model.switchValue25 = _model.shigaActive!;
    _model.switchValue26 = _model.kyotoActive!;
    _model.switchValue27 = _model.osakaActive!;
    _model.switchValue28 = _model.hyogoActive!;
    _model.switchValue29 = _model.naraActive!;
    _model.switchValue30 = _model.wakayamaActive!;
    _model.switchValue31 = _model.tottoriActive!;
    _model.switchValue32 = _model.shimaneActive!;
    _model.switchValue33 = _model.okayamaActive!;
    _model.switchValue34 = _model.hiroshimaActive!;
    _model.switchValue35 = _model.yamaguchiActive!;
    _model.switchValue36 = _model.tokushimaActive!;
    _model.switchValue37 = _model.kagawaActive!;
    _model.switchValue38 = _model.ehimeActive!;
    _model.switchValue39 = _model.kochiActive!;
    _model.switchValue40 = _model.fukuokaActive!;
    _model.switchValue41 = _model.sagaActive!;
    _model.switchValue42 = _model.nagasakiActive!;
    _model.switchValue43 = _model.kumamotoActive!;
    _model.switchValue44 = _model.oitaActive!;
    _model.switchValue45 = _model.miyazakiActive!;
    _model.switchValue46 = _model.kagoshimaActive!;
    _model.switchValue47 = _model.okinawaActive!;
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            alignment: AlignmentDirectional(1.0, 0.0),
            children: [
              Container(
                width: double.infinity,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '都道府県一覧',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  _model.saveAllPrefecturesResult =
                      await actions.adminUpdateAllPrefectures(
                    _model.switchValue1,
                    _model.switchValue2,
                    _model.switchValue3,
                    _model.switchValue4,
                    _model.switchValue5,
                    _model.switchValue6,
                    _model.switchValue7,
                    _model.switchValue8,
                    _model.switchValue9,
                    _model.switchValue10,
                    _model.switchValue11,
                    _model.switchValue12,
                    _model.switchValue13,
                    _model.switchValue14,
                    _model.switchValue15,
                    _model.switchValue16,
                    _model.switchValue17,
                    _model.switchValue18,
                    _model.switchValue19,
                    _model.switchValue20,
                    _model.switchValue21,
                    _model.switchValue22,
                    _model.switchValue23,
                    _model.switchValue24,
                    _model.switchValue25,
                    _model.switchValue26,
                    _model.switchValue27,
                    _model.switchValue28,
                    _model.switchValue29,
                    _model.switchValue30,
                    _model.switchValue31,
                    _model.switchValue32,
                    _model.switchValue33,
                    _model.switchValue34,
                    _model.switchValue35,
                    _model.switchValue36,
                    _model.switchValue37,
                    _model.switchValue38,
                    _model.switchValue39,
                    _model.switchValue40,
                    _model.switchValue41,
                    _model.switchValue42,
                    _model.switchValue43,
                    _model.switchValue44,
                    _model.switchValue45,
                    _model.switchValue46,
                    _model.switchValue47,
                  );
                  Navigator.pop(context);

                  safeSetState(() {});
                },
                text: '保存',
                options: FFButtonOptions(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(),
                    child: Icon(
                      Icons.close_sharp,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 35.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          '北海道・東　北',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '北海道',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue1!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue1 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '青森県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue2!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue2 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '岩手県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue3!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue3 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '宮城県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue4!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue4 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '秋田県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue5!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue5 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '山形県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue6!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue6 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '福島県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue7!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue7 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            '関　東',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '茨城県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue8!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue8 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '栃木県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue9!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue9 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '群馬県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue10!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue10 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '埼玉県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue11!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue11 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '千葉県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue12!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue12 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '東京都',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue13!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue13 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '神奈川県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue14!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue14 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 45.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            '中　部（北陸・甲信越・東海）',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '新潟県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue15!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue15 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '富山県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue16!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue16 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '石川県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue17!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue17 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '福井県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue18!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue18 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '山梨県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue19!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue19 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '長野県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue20!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue20 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '岐阜県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue21!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue21 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '静岡県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue22!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue22 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '愛知県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue23!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue23 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 45.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            '近　畿（関西）',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '三重県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue24!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue24 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '滋賀県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue25!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue25 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '京都府',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue26!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue26 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '大阪府',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue27!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue27 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '兵庫県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue28!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue28 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '奈良県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue29!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue29 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '和歌山県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue30!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue30 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 45.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            '中　国',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '鳥取県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue31!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue31 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '島根県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue32!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue32 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '岡山県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue33!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue33 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '広島県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue34!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue34 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '山口県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue35!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue35 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 45.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            '四　国',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '徳島県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue36!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue36 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '香川県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue37!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue37 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '愛媛県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue38!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue38 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '高知県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue39!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue39 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            '九　州・沖　縄',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '福岡県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue40!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue40 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '佐賀県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue41!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue41 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '長崎県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue42!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue42 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '熊本県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue43!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue43 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '大分県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue44!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue44 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '宮崎県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue45!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue45 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '鹿児島県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue46!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue46 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).alternate,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '沖縄県',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Switch.adaptive(
                                      value: _model.switchValue47!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue47 = newValue);
                                      },
                                      activeColor: Color(0xFF06F705),
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                      inactiveThumbColor: Color(0xFFF70505),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                          .divide(SizedBox(width: 8.0))
                          .around(SizedBox(width: 8.0)),
                    ),
                  ].divide(SizedBox(height: 8.0)).around(SizedBox(height: 8.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
