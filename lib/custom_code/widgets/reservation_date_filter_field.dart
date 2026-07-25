// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

/// A tappable date field for the reservation list's filter dialog.
///
/// FlutterFlow's TextField widget only exposes On Submit / On Change / On
/// Focus Change as action triggers - none of which support a clean
/// tap-to-open-picker flow (On Focus Change re-fires when the picker closes
/// and hands focus back, causing an open/reset loop). This widget handles
/// the tap and native date picker directly in code, then writes straight
/// into FFAppState so no follow-up action wiring is needed in the builder.
class ReservationDateFilterField extends StatefulWidget {
  const ReservationDateFilterField({
    super.key,
    this.width,
    this.height,
    required this.hintText,
    required this.isStartDate,
  });

  final double? width;
  final double? height;
  final String hintText;

  /// true writes into activeReservationScheduledAfter, false writes into
  /// activeReservationScheduledBefore.
  final bool isStartDate;

  @override
  State<ReservationDateFilterField> createState() =>
      _ReservationDateFilterFieldState();
}

class _ReservationDateFilterFieldState
    extends State<ReservationDateFilterField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final savedDateStr = widget.isStartDate
        ? FFAppState().activeReservationScheduledAfter
        : FFAppState().activeReservationScheduledBefore;
    _selectedDate = DateTime.tryParse(savedDateStr);
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _selectedDate == null
        ? widget.hintText
        : '${_selectedDate!.year}. ${_selectedDate!.month.toString().padLeft(2, '0')}. ${_selectedDate!.day.toString().padLeft(2, '0')}';

    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () async {
        var firstDate = DateTime(2000);
        var lastDate = DateTime(2100);

        if (widget.isStartDate) {
          final endDateStr = FFAppState().activeReservationScheduledBefore;
          final endDate = DateTime.tryParse(endDateStr);
          if (endDate != null) lastDate = endDate;
        } else {
          final startDateStr = FFAppState().activeReservationScheduledAfter;
          final startDate = DateTime.tryParse(startDateStr);
          if (startDate != null) firstDate = startDate;
        }

        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (picked == null) return;

        setState(() => _selectedDate = picked);

        final isoDate =
            '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        FFAppState().update(() {
          if (widget.isStartDate) {
            FFAppState().activeReservationScheduledAfter = isoDate;
          } else {
            FFAppState().activeReservationScheduledBefore = isoDate;
          }
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height ?? 40.0,
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayText,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontSize: 12.0,
                    letterSpacing: 0.0,
                    color: _selectedDate == null
                        ? FlutterFlowTheme.of(context).secondaryText
                        : FlutterFlowTheme.of(context).primaryText,
                  ),
            ),
            Icon(
              Icons.calendar_month,
              size: 18.0,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}
