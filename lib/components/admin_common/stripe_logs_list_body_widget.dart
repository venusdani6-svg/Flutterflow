import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StripeLogListItem {
  StripeLogListItem({
    required this.id,
    required this.eventType,
    required this.reservationId,
    this.stripeEventId,
    this.createdAt,
  });

  final String id;
  final String eventType;
  final String reservationId;
  final String? stripeEventId;
  final DateTime? createdAt;

  factory StripeLogListItem.fromMap(Map<String, dynamic> map) {
    DateTime? created;
    final raw = map['created_at'];
    if (raw is Map && raw['_seconds'] != null) {
      created = DateTime.fromMillisecondsSinceEpoch(
        (raw['_seconds'] as int) * 1000,
      );
    } else if (raw is String) {
      created = DateTime.tryParse(raw);
    }
    return StripeLogListItem(
      id: map['id'] as String? ?? '',
      eventType: map['event_type'] as String? ?? '-',
      reservationId: map['reservation_id'] as String? ?? '-',
      stripeEventId: map['stripe_event_id'] as String?,
      createdAt: created,
    );
  }

  String get createdLabel {
    if (createdAt == null) {
      return '-';
    }
    return DateFormat('yyyy/MM/dd HH:mm').format(createdAt!);
  }
}

/// Stripe logs list with 3 filters: event type / reservation ID / date range.
class StripeLogsListBodyWidget extends StatefulWidget {
  const StripeLogsListBodyWidget({super.key});

  @override
  State<StripeLogsListBodyWidget> createState() =>
      _StripeLogsListBodyWidgetState();
}

class _StripeLogsListBodyWidgetState extends State<StripeLogsListBodyWidget> {
  final _query = AdminListQueryState();
  List<StripeLogListItem> _items = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;

  String? _eventType;
  final _resIdController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _resIdController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetStripeLogs(
        eventType: _eventType,
        reservationId: _resIdController.text.isNotEmpty
            ? _resIdController.text
            : null,
        startDate: _startDate?.toIso8601String(),
        endDate: _endDate?.toIso8601String(),
        limit: _query.pageSize,
      );
      if (result == null) {
        throw Exception('Stripeログの取得に失敗しました');
      }
      final raw = (result['logs'] as List?) ?? [];
      setState(() {
        _items = raw
            .map(
              (e) => StripeLogListItem.fromMap(
                Map<String, dynamic>.from(e as Map),
              ),
            )
            .toList();
        _total = (result['total'] as int?) ?? _items.length;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final dateFmt = DateFormat('yyyy/MM/dd');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DropdownButton<String?>(
                value: _eventType,
                hint: const Text('イベント種別'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('すべて')),
                  DropdownMenuItem(
                    value: 'payment_intent.succeeded',
                    child: Text('payment_intent.succeeded'),
                  ),
                  DropdownMenuItem(
                    value: 'charge.refunded',
                    child: Text('charge.refunded'),
                  ),
                  DropdownMenuItem(
                    value: 'payout.paid',
                    child: Text('payout.paid'),
                  ),
                ],
                onChanged: (value) => setState(() => _eventType = value),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _resIdController,
                  decoration: const InputDecoration(
                    hintText: '予約ID (res_id)',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () => _pickDate(isStart: true),
                child: Text(
                  _startDate == null
                      ? '開始日'
                      : dateFmt.format(_startDate!),
                ),
              ),
              OutlinedButton(
                onPressed: () => _pickDate(isStart: false),
                child: Text(
                  _endDate == null ? '終了日' : dateFmt.format(_endDate!),
                ),
              ),
              ElevatedButton(
                onPressed: _load,
                child: const Text('検索'),
              ),
            ],
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_error!, style: TextStyle(color: theme.error)),
          ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _items.isEmpty
                  ? const Center(child: Text('Stripeログがありません'))
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      itemCount: _items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ListTile(
                          tileColor: theme.secondaryBackground,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: theme.alternate),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          title: Text(item.eventType),
                          subtitle: Text(
                            '予約: ${item.reservationId}\n'
                            'Stripe: ${item.stripeEventId ?? '-'}\n'
                            '${item.createdLabel}',
                          ),
                          isThreeLine: true,
                        );
                      },
                    ),
        ),
        AdminPaginationBar(
          page: _query.page,
          pageSize: _query.pageSize,
          total: _total,
          onPrevious: () {
            if (_query.page > 0) {
              setState(() => _query.page--);
              _load();
            }
          },
          onNext: () {
            if ((_query.page + 1) * _query.pageSize < _total) {
              setState(() => _query.page++);
              _load();
            }
          },
        ),
      ],
    );
  }
}
