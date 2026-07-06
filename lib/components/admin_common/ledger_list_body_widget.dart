import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LedgerListItem {
  LedgerListItem({
    required this.id,
    required this.type,
    required this.amount,
    required this.reservationId,
    this.description,
    this.createdAt,
  });

  final String id;
  final String type;
  final double amount;
  final String reservationId;
  final String? description;
  final DateTime? createdAt;

  factory LedgerListItem.fromMap(Map<String, dynamic> map) {
    DateTime? created;
    final raw = map['created_at'];
    if (raw is Map && raw['_seconds'] != null) {
      created = DateTime.fromMillisecondsSinceEpoch(
        (raw['_seconds'] as int) * 1000,
      );
    } else if (raw is String) {
      created = DateTime.tryParse(raw);
    }
    return LedgerListItem(
      id: map['id'] as String? ?? '',
      type: map['type'] as String? ?? '-',
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      reservationId: map['reservation_id'] as String? ?? '-',
      description: map['description'] as String?,
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

/// Ledger list wired to [adminGetLedger].
class LedgerListBodyWidget extends StatefulWidget {
  const LedgerListBodyWidget({super.key, this.initialType});

  final String? initialType;

  @override
  State<LedgerListBodyWidget> createState() => _LedgerListBodyWidgetState();
}

class _LedgerListBodyWidgetState extends State<LedgerListBodyWidget> {
  final _query = AdminListQueryState();
  List<LedgerListItem> _items = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;
  String? _typeFilter;
  final _resIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeFilter = widget.initialType;
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
      final result = await adminGetLedger(
        type: _typeFilter,
        reservationId: _resIdController.text.isNotEmpty
            ? _resIdController.text
            : null,
        limit: _query.pageSize,
      );
      if (result == null) {
        throw Exception('台帳一覧の取得に失敗しました');
      }
      final raw = (result['entries'] as List?) ?? [];
      setState(() {
        _items = raw
            .map(
              (e) => LedgerListItem.fromMap(
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

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final currency = NumberFormat('#,###');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _resIdController,
                  decoration: const InputDecoration(
                    hintText: '予約IDで絞り込み',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String?>(
                value: _typeFilter,
                hint: const Text('種別'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('すべて')),
                  DropdownMenuItem(value: 'payment', child: Text('payment')),
                  DropdownMenuItem(value: 'tip', child: Text('tip')),
                  DropdownMenuItem(value: 'refund', child: Text('refund')),
                ],
                onChanged: (value) {
                  setState(() => _typeFilter = value);
                  _load();
                },
              ),
              const SizedBox(width: 8),
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
                  ? const Center(child: Text('台帳エントリがありません'))
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
                          title: Text(
                            '${item.type} — ¥${currency.format(item.amount.round())}',
                          ),
                          subtitle: Text(
                            '予約: ${item.reservationId}\n'
                            '${item.description ?? ''}\n'
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
