import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/info_dialog_comp/info_dialog_comp_widget.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/paymet_ledger/filter_ledgert_dialog_comp/filter_ledgert_dialog_comp_widget.dart';
import '/paymet_ledger/filter_payment_dialog_comp/filter_payment_dialog_comp_widget.dart';
import '/paymet_ledger/filter_stripelog_dialog_comp/filter_stripelog_dialog_comp_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_ledger_list_page_model.dart';
export 'payment_ledger_list_page_model.dart';

class PaymentLedgerListPageWidget extends StatefulWidget {
  const PaymentLedgerListPageWidget({super.key});

  static String routeName = 'PaymentLedgerListPage';
  static String routePath = '/paymentLedgerListPage';

  @override
  State<PaymentLedgerListPageWidget> createState() =>
      _PaymentLedgerListPageWidgetState();
}

class _PaymentLedgerListPageWidgetState
    extends State<PaymentLedgerListPageWidget> with TickerProviderStateMixin {
  late PaymentLedgerListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentLedgerListPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.ledgerFetchResult = await actions.adminGetLedger(
        '',
        '',
        '',
        100,
        '',
        '',
        '',
      );
      FFAppState().ledgerList = getJsonField(
        _model.ledgerFetchResult,
        r'''$.entries''',
        true,
      )!
          .toList()
          .cast<dynamic>();
      safeSetState(() {});
      _model.paymentFetchResult = await actions.adminGetReservations(
        '',
        '',
        '',
        100,
        '',
      );
      FFAppState().paymentList = getJsonField(
        _model.paymentFetchResult,
        r'''$.reservations''',
        true,
      )!
          .toList()
          .cast<dynamic>();
      safeSetState(() {});
      _model.stripeLogFetchResult = await actions.adminGetStripeLogs(
        '',
        '',
        50,
        '',
        '',
      );
      FFAppState().stripeLogList = getJsonField(
        _model.stripeLogFetchResult,
        r'''$.logs''',
        true,
      )!
          .toList()
          .cast<dynamic>();
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Visibility(
            visible: responsiveVisibility(
              context: context,
              phone: false,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                  ))
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 250.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.asset(
                                        'assets/images/transparent.png',
                                        width: 80.0,
                                        height: 80.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 100.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: 250.0,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Image.asset(
                                                              'assets/images/icoccha_logo.png',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'icoccha',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Text(
                                                                'contact@icooccha.com',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ]
                                                                .divide(SizedBox(
                                                                    height:
                                                                        4.0))
                                                                .around(SizedBox(
                                                                    height:
                                                                        4.0)),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            if (Theme.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness
                                                                    .dark) {
                                                              setDarkModeSetting(
                                                                  context,
                                                                  ThemeMode
                                                                      .light);
                                                            } else {
                                                              setDarkModeSetting(
                                                                  context,
                                                                  ThemeMode
                                                                      .dark);
                                                            }
                                                          },
                                                          child: Container(
                                                            width: 35.0,
                                                            height: 35.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                              ),
                                                            ),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                if ((Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .dark) ==
                                                                    true) {
                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        FFIcons
                                                                            .ksun,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                      Text(
                                                                        'light',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        FFIcons
                                                                            .kstarAndCrescent,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                      Text(
                                                                        'dark',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Builder(
                                                          builder: (context) =>
                                                              InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (dialogContext) {
                                                                  return Dialog(
                                                                    elevation:
                                                                        0,
                                                                    insetPadding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(dialogContext)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            400.0,
                                                                        width:
                                                                            760.0,
                                                                        child:
                                                                            InfoDialogCompWidget(),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                              width: 35.0,
                                                              height: 35.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    FFIcons
                                                                        .kchatCenteredTextG,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                  Text(
                                                                    'info',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              10.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 8.0)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 250.0,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                      child: Stack(
                                        children: [
                                          wrapWithModel(
                                            model: _model.mainMenuCompModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: MainMenuCompWidget(),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x00FFFFFF),
                                            ),
                                            child: Stack(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 8.0),
                                                    child: Text(
                                                      '決済・台帳一覧',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          8.0, 0.0, 0.0, 0.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.safePop();
                                                    },
                                                    child: Container(
                                                      width: 35.0,
                                                      height: 35.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_circle_left_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 20.0,
                                                          ),
                                                          Text(
                                                            'back',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      10.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: 100.0,
                                                      height: 800.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                Alignment(
                                                                    0.0, 0),
                                                            child: TabBar(
                                                              labelColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              unselectedLabelColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                              labelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .interTight(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                              unselectedLabelStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .interTight(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                              indicatorColor:
                                                                  Color(
                                                                      0xFFABE1FF),
                                                              indicatorWeight:
                                                                  5.0,
                                                              tabs: [
                                                                Tab(
                                                                  text: '決済一覧',
                                                                  icon: Icon(
                                                                    FFIcons
                                                                        .kcreditCard,
                                                                  ),
                                                                ),
                                                                Tab(
                                                                  text: '台帳一覧',
                                                                  icon: Icon(
                                                                    FFIcons
                                                                        .knotebook,
                                                                  ),
                                                                ),
                                                                Tab(
                                                                  text:
                                                                      'Stripeログ',
                                                                  icon: Icon(
                                                                    FFIcons
                                                                        .kstripeLogo,
                                                                  ),
                                                                ),
                                                              ],
                                                              controller: _model
                                                                  .tabBarController,
                                                              onTap: (i) async {
                                                                [
                                                                  () async {},
                                                                  () async {},
                                                                  () async {}
                                                                ][i]();
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: TabBarView(
                                                              controller: _model
                                                                  .tabBarController,
                                                              children: [
                                                                SingleChildScrollView(
                                                                  primary:
                                                                      false,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: 100.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                          ),
                                                                                          child: Stack(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            children: [
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    FFIcons.kcreditCardFill,
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    '決済一覧',
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.inter(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 8.0)),
                                                                                              ),
                                                                                              Builder(
                                                                                                builder: (context) => Padding(
                                                                                                  padding: EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      await showDialog(
                                                                                                        context: context,
                                                                                                        builder: (dialogContext) {
                                                                                                          return Dialog(
                                                                                                            elevation: 0,
                                                                                                            insetPadding: EdgeInsets.zero,
                                                                                                            backgroundColor: Colors.transparent,
                                                                                                            alignment: AlignmentDirectional(0.0, -1.0).resolve(Directionality.of(context)),
                                                                                                            child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                              },
                                                                                                              child: Container(
                                                                                                                height: 250.0,
                                                                                                                width: 760.0,
                                                                                                                child: FilterPaymentDialogCompWidget(),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                      );
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      width: 35.0,
                                                                                                      height: 35.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                        border: Border.all(
                                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: [
                                                                                                          Icon(
                                                                                                            FFIcons.karticleG,
                                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                                            size: 20.0,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'filter',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                  fontSize: 10.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final payment =
                                                                                FFAppState().paymentList.toList();

                                                                            return Wrap(
                                                                              spacing: 0.0,
                                                                              runSpacing: 0.0,
                                                                              alignment: WrapAlignment.start,
                                                                              crossAxisAlignment: WrapCrossAlignment.start,
                                                                              direction: Axis.horizontal,
                                                                              runAlignment: WrapAlignment.start,
                                                                              verticalDirection: VerticalDirection.down,
                                                                              clipBehavior: Clip.none,
                                                                              children: List.generate(payment.length, (paymentIndex) {
                                                                                final paymentItem = payment[paymentIndex];
                                                                                return Material(
                                                                                  color: Colors.transparent,
                                                                                  elevation: 1.0,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  child: Container(
                                                                                    width: 560.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      border: Border.all(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              width: 250.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topLeft: Radius.circular(16.0),
                                                                                                  bottomLeft: Radius.circular(16.0),
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                'PaymentIntent ID',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                paymentItem,
                                                                                                                r'''$.payment_intent_id''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                'ゲストユーザーニクネ',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                paymentItem,
                                                                                                                r'''$.guest_id''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                'ステータス',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Icon(
                                                                                                                  Icons.circle,
                                                                                                                  color: Color(0xFF06F705),
                                                                                                                  size: 14.0,
                                                                                                                ),
                                                                                                                Text(
                                                                                                                  getJsonField(
                                                                                                                    paymentItem,
                                                                                                                    r'''$.status_label''',
                                                                                                                  ).toString(),
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.inter(
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        fontSize: 12.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ].divide(SizedBox(width: 8.0)),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ].divide(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              width: 250.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topRight: Radius.circular(16.0),
                                                                                                  bottomRight: Radius.circular(16.0),
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '予約 ID',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                paymentItem,
                                                                                                                r'''$.id''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '決済額',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  getJsonField(
                                                                                                                    paymentItem,
                                                                                                                    r'''$.total_amount''',
                                                                                                                  ).toString(),
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.inter(
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        fontSize: 12.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                                Text(
                                                                                                                  '円',
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.inter(
                                                                                                                          fontWeight: FontWeight.normal,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        fontSize: 10.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ].divide(SizedBox(width: 8.0)),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '作成日時',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                getJsonField(
                                                                                                                  paymentItem,
                                                                                                                  r'''$.created_at''',
                                                                                                                ).toString(),
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ].divide(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 8.0)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SingleChildScrollView(
                                                                  primary:
                                                                      false,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: 100.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                          ),
                                                                                          child: Stack(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            children: [
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    FFIcons.knotebookFill,
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    '台帳一覧',
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.inter(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 8.0)),
                                                                                              ),
                                                                                              Builder(
                                                                                                builder: (context) => Padding(
                                                                                                  padding: EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      await showDialog(
                                                                                                        context: context,
                                                                                                        builder: (dialogContext) {
                                                                                                          return Dialog(
                                                                                                            elevation: 0,
                                                                                                            insetPadding: EdgeInsets.zero,
                                                                                                            backgroundColor: Colors.transparent,
                                                                                                            alignment: AlignmentDirectional(0.0, -1.0).resolve(Directionality.of(context)),
                                                                                                            child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                              },
                                                                                                              child: Container(
                                                                                                                height: 450.0,
                                                                                                                width: 760.0,
                                                                                                                child: FilterLedgertDialogCompWidget(),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                      );
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      width: 35.0,
                                                                                                      height: 35.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                        border: Border.all(
                                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: [
                                                                                                          Icon(
                                                                                                            FFIcons.karticleG,
                                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                                            size: 20.0,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'filter',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                  fontSize: 10.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final ledger =
                                                                                FFAppState().ledgerList.toList();

                                                                            return Wrap(
                                                                              spacing: 0.0,
                                                                              runSpacing: 0.0,
                                                                              alignment: WrapAlignment.start,
                                                                              crossAxisAlignment: WrapCrossAlignment.start,
                                                                              direction: Axis.horizontal,
                                                                              runAlignment: WrapAlignment.start,
                                                                              verticalDirection: VerticalDirection.down,
                                                                              clipBehavior: Clip.none,
                                                                              children: List.generate(ledger.length, (ledgerIndex) {
                                                                                final ledgerItem = ledger[ledgerIndex];
                                                                                return Material(
                                                                                  color: Colors.transparent,
                                                                                  elevation: 1.0,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  child: Container(
                                                                                    width: 560.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      border: Border.all(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              width: 250.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topLeft: Radius.circular(16.0),
                                                                                                  bottomLeft: Radius.circular(16.0),
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                'Ledger ID',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                ledgerItem,
                                                                                                                r'''$.id''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                              overflow: TextOverflow.ellipsis,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '対象者',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                ledgerItem,
                                                                                                                r'''$.user_id''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                'ステータス',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Icon(
                                                                                                                  Icons.circle,
                                                                                                                  color: Color(0xFF06F705),
                                                                                                                  size: 14.0,
                                                                                                                ),
                                                                                                                Text(
                                                                                                                  getJsonField(
                                                                                                                    ledgerItem,
                                                                                                                    r'''$.status_label''',
                                                                                                                  ).toString(),
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.inter(
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        fontSize: 12.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ].divide(SizedBox(width: 8.0)),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ].divide(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              width: 250.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topRight: Radius.circular(16.0),
                                                                                                  bottomRight: Radius.circular(16.0),
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '料金種別',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                ledgerItem,
                                                                                                                r'''$.type_label''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '利用料金',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Row(
                                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  getJsonField(
                                                                                                                    ledgerItem,
                                                                                                                    r'''$.amount''',
                                                                                                                  ).toString(),
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.inter(
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        fontSize: 12.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                                Text(
                                                                                                                  '円',
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.inter(
                                                                                                                          fontWeight: FontWeight.normal,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        fontSize: 10.0,
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ].divide(SizedBox(width: 8.0)),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '作成日時',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                getJsonField(
                                                                                                                  ledgerItem,
                                                                                                                  r'''$.created_at''',
                                                                                                                ).toString(),
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ].divide(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ].divide(SizedBox(width: 8.0)),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SingleChildScrollView(
                                                                  primary:
                                                                      false,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: 100.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          width: 100.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                          ),
                                                                                          child: Stack(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            children: [
                                                                                              Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    FFIcons.kstripeLogoFill,
                                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    'Stripeログ',
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.inter(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ].divide(SizedBox(width: 8.0)),
                                                                                              ),
                                                                                              Builder(
                                                                                                builder: (context) => Padding(
                                                                                                  padding: EdgeInsets.all(8.0),
                                                                                                  child: InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      await showDialog(
                                                                                                        context: context,
                                                                                                        builder: (dialogContext) {
                                                                                                          return Dialog(
                                                                                                            elevation: 0,
                                                                                                            insetPadding: EdgeInsets.zero,
                                                                                                            backgroundColor: Colors.transparent,
                                                                                                            alignment: AlignmentDirectional(0.0, -1.0).resolve(Directionality.of(context)),
                                                                                                            child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                              },
                                                                                                              child: Container(
                                                                                                                height: 350.0,
                                                                                                                width: 760.0,
                                                                                                                child: FilterStripelogDialogCompWidget(),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                      );
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      width: 35.0,
                                                                                                      height: 35.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                                        border: Border.all(
                                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        children: [
                                                                                                          Icon(
                                                                                                            FFIcons.karticleG,
                                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                                            size: 20.0,
                                                                                                          ),
                                                                                                          Text(
                                                                                                            'filter',
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                  fontSize: 10.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final stripeLog =
                                                                                FFAppState().stripeLogList.toList();

                                                                            return Wrap(
                                                                              spacing: 0.0,
                                                                              runSpacing: 0.0,
                                                                              alignment: WrapAlignment.start,
                                                                              crossAxisAlignment: WrapCrossAlignment.start,
                                                                              direction: Axis.horizontal,
                                                                              runAlignment: WrapAlignment.start,
                                                                              verticalDirection: VerticalDirection.down,
                                                                              clipBehavior: Clip.none,
                                                                              children: List.generate(stripeLog.length, (stripeLogIndex) {
                                                                                final stripeLogItem = stripeLog[stripeLogIndex];
                                                                                return Material(
                                                                                  color: Colors.transparent,
                                                                                  elevation: 1.0,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8.0),
                                                                                  ),
                                                                                  child: Container(
                                                                                    width: 560.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                                      border: Border.all(
                                                                                        color: FlutterFlowTheme.of(context).alternate,
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              width: 250.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topLeft: Radius.circular(16.0),
                                                                                                  bottomLeft: Radius.circular(16.0),
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                'Event Type',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                stripeLogItem,
                                                                                                                r'''$.event_type''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '受信日時',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                stripeLogItem,
                                                                                                                r'''$.created_at''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ].divide(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              width: 250.0,
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                borderRadius: BorderRadius.only(
                                                                                                  topRight: Radius.circular(16.0),
                                                                                                  bottomRight: Radius.circular(16.0),
                                                                                                ),
                                                                                              ),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '予約 ID',
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 12.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              getJsonField(
                                                                                                                stripeLogItem,
                                                                                                                r'''$.res_id''',
                                                                                                              ).toString(),
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 12.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              ),
                                                                                                            ),
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          child: Container(
                                                                                                            width: 250.0,
                                                                                                            height: 25.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              borderRadius: BorderRadius.circular(0.0),
                                                                                                              border: Border.all(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ].divide(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
