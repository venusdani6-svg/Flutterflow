import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_cast_dialog_comp_model.dart';
export 'search_cast_dialog_comp_model.dart';

/// Keyword search for CastUserListPage.
///
/// Replaces the previously-shared (and wrong) Search_User_DialogComp
/// reference.
class SearchCastDialogCompWidget extends StatefulWidget {
  const SearchCastDialogCompWidget({super.key});

  @override
  State<SearchCastDialogCompWidget> createState() =>
      _SearchCastDialogCompWidgetState();
}

class _SearchCastDialogCompWidgetState
    extends State<SearchCastDialogCompWidget> {
  late SearchCastDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchCastDialogCompModel());

    _model.searchCastKeywordFieldTextController ??= TextEditingController();
    _model.searchCastKeywordFieldFocusNode ??= FocusNode();
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
              'キャストユーザー検索',
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _model.searchCastKeywordFieldTextController,
                    focusNode: _model.searchCastKeywordFieldFocusNode,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'ニックネームで検索',
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
                        .searchCastKeywordFieldTextControllerValidator
                        .asValidator(context),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    _model.castSearchResult =
                        await actions.adminGetUserListItems(
                      'cast',
                      _model.searchCastKeywordFieldTextController.text,
                    );
                    FFAppState().castUserListStruct = _model.castSearchResult!
                        .toList()
                        .cast<AdminUserListItemStruct>();
                    safeSetState(() {});
                    Navigator.pop(context);

                    safeSetState(() {});
                  },
                  text: '検　索',
                  options: FFButtonOptions(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ].divide(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
