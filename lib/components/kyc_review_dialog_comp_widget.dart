import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'kyc_review_dialog_comp_model.dart';
export 'kyc_review_dialog_comp_model.dart';

/// Approve/reject modal for one KYC submission: shows the applicant nickname
/// plus their submitted ID document and selfie photo, with Approve/Reject
/// buttons calling adminApproveKYC.
///
/// Opened from a row tap on KYCReviewListPage.
class KycReviewDialogCompWidget extends StatefulWidget {
  const KycReviewDialogCompWidget({
    super.key,
    this.userId,
    this.nickname,
    this.idDocUrl,
    this.selfieUrl,
  });

  final String? userId;
  final String? nickname;
  final String? idDocUrl;
  final String? selfieUrl;

  @override
  State<KycReviewDialogCompWidget> createState() =>
      _KycReviewDialogCompWidgetState();
}

class _KycReviewDialogCompWidgetState extends State<KycReviewDialogCompWidget> {
  late KycReviewDialogCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KycReviewDialogCompModel());

    _model.rejectReasonFieldTextController ??= TextEditingController();
    _model.rejectReasonFieldFocusNode ??= FocusNode();
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.nickname!,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '本人確認書類',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 0),
                          fadeOutDuration: Duration(milliseconds: 0),
                          imageUrl: widget.idDocUrl!,
                          height: 140.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '本人顔写真',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 0),
                          fadeOutDuration: Duration(milliseconds: 0),
                          imageUrl: widget.selfieUrl!,
                          height: 140.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
            TextFormField(
              controller: _model.rejectReasonFieldTextController,
              focusNode: _model.rejectReasonFieldFocusNode,
              obscureText: false,
              decoration: InputDecoration(
                labelText: '却下理由（却下する場合のみ入力）',
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
              maxLines: 2,
              validator: _model.rejectReasonFieldTextControllerValidator
                  .asValidator(context),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: FFButtonWidget(
                    onPressed: () async {
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('却下確認'),
                                content: Text('このユーザーの本人確認を却下しますか？'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: Text('キャンセル'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: Text('却下する'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      _model.kycRejectResult = await actions.adminApproveKYC(
                        widget.userId!,
                        false,
                        _model.rejectReasonFieldTextController.text,
                      );
                      Navigator.pop(context);

                      safeSetState(() {});
                    },
                    text: '却下',
                    options: FFButtonOptions(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Colors.transparent,
                      textStyle: TextStyle(
                        color: FlutterFlowTheme.of(context).error,
                      ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FFButtonWidget(
                    onPressed: () async {
                      var confirmDialogResponse = await showDialog<bool>(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('承認確認'),
                                content: Text('このユーザーの本人確認を承認しますか？'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(
                                        alertDialogContext, false),
                                    child: Text('キャンセル'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext, true),
                                    child: Text('承認する'),
                                  ),
                                ],
                              );
                            },
                          ) ??
                          false;
                      _model.kycApproveResult = await actions.adminApproveKYC(
                        widget.userId!,
                        true,
                        '',
                      );
                      Navigator.pop(context);

                      safeSetState(() {});
                    },
                    text: '承認',
                    options: FFButtonOptions(
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
          ].divide(SizedBox(height: 12.0)),
        ),
      ),
    );
  }
}
