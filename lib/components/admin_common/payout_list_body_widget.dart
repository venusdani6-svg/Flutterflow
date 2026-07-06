import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_confirm_dialog.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PayoutListItem {
  PayoutListItem({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    this.createdAt,
  });

  final String id;
  final String userId;
  final double amount;
  final String status;
  final DateTime? createdAt;

  factory PayoutListItem.fromMap(Map<String, dynamic> map) {
    DateTime? created;
    final raw = map['created_at'];
    if (raw is Map && raw['_seconds'] != null) {
      created = DateTime.fromMillisecondsSinceEpoch(
        (raw['_seconds'] as int) * 1000,
      );
    } else if (raw is String) {
      created = DateTime.tryParse(raw);
    }
    return PayoutListItem(
      id: map['id'] as String? ?? '',
      userId: map['user_id'] as String? ?? '-',
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      status: map['status'] as String? ?? 'pending',
      createdAt: created,
    );
  }

  String get createdLabel {
    if (createdAt == null) {
      return '-';
    }
    return DateFormat('yyyy/MM/dd HH:mm').format(createdAt!);
  }

  String get statusLabel => switch (status) {
        'pending' => '申請中',
        'approved' => '承認済み',
        'on_hold' => '保留',
        'rejected' => '否認',
        _ => status,
      };
}

/// Payout request list wired to [adminGetPayoutRequests] + [adminApprovePayout].
class PayoutListBodyWidget extends StatefulWidget {
  const PayoutListBodyWidget({super.key});

  @override
  State<PayoutListBodyWidget> createState() => _PayoutListBodyWidgetState();
}

class _PayoutListBodyWidgetState extends State<PayoutListBodyWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _query = AdminListQueryState();
  List<PayoutListItem> _items = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;

  static const _statusTabs = [
    ('pending', '申請中'),
    ('approved', '承認済み'),
    ('on_hold', '保留'),
    ('rejected', '否認'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _statusTabs.length, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) {
          _query.page = 0;
          _load();
        }
      });
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String get _currentStatus => _statusTabs[_tabController.index].$1;

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetPayoutRequests(
        status: _currentStatus,
        limit: _query.pageSize,
        offset: _query.offset,
      );
      if (result == null) {
        throw Exception('出金申請一覧の取得に失敗しました');
      }
      final raw = (result['payouts'] as List?) ?? [];
      setState(() {
        _items = raw
            .map(
              (e) => PayoutListItem.fromMap(
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

  Future<void> _updateStatus(PayoutListItem item, String newStatus) async {
    final label = switch (newStatus) {
      'approved' => '承認',
      'on_hold' => '保留',
      'rejected' => '否認',
      _ => newStatus,
    };
    final confirmed = await showAdminConfirmDialog(
      context,
      title: '出金申請を$label',
      message: '¥${item.amount.round()} の申請を$labelしますか？',
    );
    if (!confirmed) {
      return;
    }
    await adminApprovePayout(payoutId: item.id, status: newStatus);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final currency = NumberFormat('#,###');
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: _statusTabs.map((t) => Tab(text: t.$2)).toList(),
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
                  ? Center(child: Text('${_statusTabs[_tabController.index].$2}の申請はありません'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              '¥${currency.format(item.amount.round())}',
                            ),
                            subtitle: Text(
                              'ユーザー: ${item.userId}\n'
                              '状態: ${item.statusLabel}\n'
                              '申請日: ${item.createdLabel}',
                            ),
                            isThreeLine: true,
                            trailing: _currentStatus == 'pending'
                                ? Wrap(
                                    spacing: 4,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            _updateStatus(item, 'rejected'),
                                        child: const Text('否認'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            _updateStatus(item, 'on_hold'),
                                        child: const Text('保留'),
                                      ),
                                      FilledButton(
                                        onPressed: () =>
                                            _updateStatus(item, 'approved'),
                                        child: const Text('承認'),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
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
