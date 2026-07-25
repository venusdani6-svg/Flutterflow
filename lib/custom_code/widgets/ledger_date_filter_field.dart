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

/// A tappable date field for the ledger filter dialog.
///
/// Same widget/reasoning as ReservationDateFilterField (TextField has no On
/// Tap trigger, and On Focus Change + a dialog-opening action loops); copied
/// rather than generalized since that one is hardcoded to specific App State
/// field names and a focused copy is simpler than a callback-based generic
/// version.
class LedgerDateFilterField extends StatefulWidget {
  const LedgerDateFilterField({
    super.key,
    this.width,
    this.height,
    required this.hintText,
    required this.isStartDate,
  });

  final double? width;
  final double? height;
  final String hintText;

  /// true writes into activeLedgerCreatedAfter, false writes into
  /// activeLedgerCreatedBefore.
  final bool isStartDate;

  @override
  State<LedgerDateFilterField> createState() => _LedgerDateFilterFieldState();
}

class _LedgerDateFilterFieldState extends State<LedgerDateFilterField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final savedDateStr = widget.isStartDate
        ? FFAppState().activeLedgerCreatedAfter
        : FFAppState().activeLedgerCreatedBefore;
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
          final endDateStr = FFAppState().activeLedgerCreatedBefore;
          final endDate = DateTime.tryParse(endDateStr);
          if (endDate != null) lastDate = endDate;
        } else {
          final startDateStr = FFAppState().activeLedgerCreatedAfter;
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
            FFAppState().activeLedgerCreatedAfter = isoDate;
          } else {
            FFAppState().activeLedgerCreatedBefore = isoDate;
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

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
