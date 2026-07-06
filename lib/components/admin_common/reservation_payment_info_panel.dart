import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_confirm_dialog.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Payment info block for reservation detail (customer agreement 5/22).
class ReservationPaymentInfoPanel extends StatefulWidget {
  const ReservationPaymentInfoPanel({
    super.key,
    required this.reservationId,
    this.onCancelled,
  });

  final String reservationId;
  final VoidCallback? onCancelled;

  @override
  State<ReservationPaymentInfoPanel> createState() =>
      _ReservationPaymentInfoPanelState();
}

class _ReservationPaymentInfoPanelState
    extends State<ReservationPaymentInfoPanel> {
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _reservation;
  double _tipTotal = 0;
  bool _hasTips = false;

  final _currency = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant ReservationPaymentInfoPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reservationId != widget.reservationId) {
      _load();
    }
  }

  Future<void> _load() async {
    if (widget.reservationId.isEmpty) {
      return;
    }
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final reservation = await adminGetReservation(
        reservationId: widget.reservationId,
      );
      final tips = await adminGetTipsByReservation(
        reservationId: widget.reservationId,
      );
      setState(() {
        _reservation = reservation;
        _tipTotal = (tips?['total'] as num?)?.toDouble() ?? 0;
        _hasTips = tips?['hasTips'] == true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  double _num(String key) {
    return (_reservation?[key] as num?)?.toDouble() ?? 0;
  }

  String _formatYen(double value) => '¥${_currency.format(value.round())}';

  String _formatTimestamp(dynamic raw) {
    if (raw == null) {
      return '-';
    }
    DateTime? dt;
    if (raw is Map) {
      final sec = raw['_seconds'] ?? raw['seconds'];
      if (sec != null) {
        dt = DateTime.fromMillisecondsSinceEpoch((sec as int) * 1000);
      }
    } else if (raw is String) {
      dt = DateTime.tryParse(raw);
    }
    if (dt == null) {
      return '-';
    }
    return DateFormat('yyyy/MM/dd HH:mm').format(dt);
  }

  Future<void> _forceCancel() async {
    final confirmed = await showAdminConfirmDialog(
      context,
      title: '強制キャンセル',
      message: 'この予約を強制キャンセルしますか？',
      confirmLabel: 'キャンセル実行',
    );
    if (!confirmed) {
      return;
    }
    await adminForceCancel(reservationId: widget.reservationId);
    widget.onCancelled?.call();
    await _load();
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 160, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    if (widget.reservationId.isEmpty) {
      return const SizedBox.shrink();
    }
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '決済情報',
              style: theme.titleMedium,
            ),
            const SizedBox(height: 12),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Text(_error!, style: TextStyle(color: theme.error))
            else if (_reservation != null) ...[
              _row('基本料金', _formatYen(_num('base_fee'))),
              _row('タクシー代', _formatYen(_num('taxi_fee'))),
              _row('スタッフ費用', _formatYen(_num('staff_fee'))),
              _row(
                'チップ合計',
                _hasTips ? _formatYen(_tipTotal) : 'なし',
              ),
              _row('決済総額', _formatYen(_num('total_amount'))),
              _row(
                '延長回数 / 総時間',
                '${_reservation!['extension_count'] ?? 0} 回 / '
                '${_reservation!['total_duration_minutes'] ?? 0} 分',
              ),
              _row(
                '30分ルール適用有無',
                (_reservation!['thirty_min_rule_applied'] == true)
                    ? '適用'
                    : '未適用',
              ),
              _row(
                '最終売上確定日時',
                _formatTimestamp(_reservation!['sales_finalized_at']),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: _forceCancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.error,
                  ),
                  child: const Text('強制キャンセル'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
