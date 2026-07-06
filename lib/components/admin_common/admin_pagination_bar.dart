import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPaginationBar extends StatelessWidget {
  const AdminPaginationBar({
    super.key,
    required this.page,
    required this.pageSize,
    required this.total,
    required this.onPrevious,
    required this.onNext,
  });

  final int page;
  final int pageSize;
  final int total;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  int get totalPages => total == 0 ? 1 : ((total - 1) / pageSize).floor() + 1;
  bool get canGoPrevious => page > 0;
  bool get canGoNext => (page + 1) * pageSize < total;

  @override
  Widget build(BuildContext context) {
    final from = total == 0 ? 0 : page * pageSize + 1;
    final to = (page + 1) * pageSize > total ? total : (page + 1) * pageSize;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FFButtonWidget(
            onPressed: canGoPrevious ? onPrevious : null,
            text: '前へ',
            options: FFButtonOptions(
              height: 32.0,
              color: FlutterFlowTheme.of(context).alternate,
              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontSize: 12.0),
                  ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '$from–$to / $total 件（${page + 1}/$totalPages ページ）',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontSize: 12.0),
                  ),
            ),
          ),
          FFButtonWidget(
            onPressed: canGoNext ? onNext : null,
            text: '次へ',
            options: FFButtonOptions(
              height: 32.0,
              color: FlutterFlowTheme.of(context).alternate,
              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontSize: 12.0),
                  ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
