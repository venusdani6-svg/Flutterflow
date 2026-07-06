import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/admin_dashboard_page/admin_dashboard_page_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardActivityLogCard extends StatelessWidget {
  const DashboardActivityLogCard({
    super.key,
    required this.log,
  });

  final DashboardActivityLog log;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: 300.0,
            height: 110.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).alternate,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _logRow(context, '操作内容　：　', log.action),
                  _logRow(context, '対象ユーザー　：　', log.targetUserName),
                  _logRow(context, '操作日時　：　', log.createdAtLabel),
                ].divide(const SizedBox(height: 8.0)).around(const SizedBox(height: 8.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _logRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                fontSize: 12.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ].divide(const SizedBox(width: 8.0)).around(const SizedBox(width: 8.0)),
    );
  }
}
