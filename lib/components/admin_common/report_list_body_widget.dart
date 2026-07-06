import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_confirm_dialog.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/components/admin_common/admin_timestamp_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportListItem {
  ReportListItem({
    required this.id,
    required this.reporterId,
    required this.reportedUserId,
    required this.reason,
    required this.status,
    this.createdAt,
  });

  final String id;
  final String reporterId;
  final String reportedUserId;
  final String reason;
  final String status;
  final DateTime? createdAt;

  factory ReportListItem.fromMap(Map<String, dynamic> map) {
    return ReportListItem(
      id: map['id'] as String? ?? '',
      reporterId: map['reporter_id'] as String? ?? '-',
      reportedUserId: map['reported_user_id'] as String? ?? '-',
      reason: map['reason'] as String? ?? '',
      status: map['status'] as String? ?? 'pending',
      createdAt: parseAdminTimestamp(map['created_at']),
    );
  }

  String get statusLabel => switch (status) {
        'pending' => '未対応',
        'in_progress' => '対応中',
        'resolved' => '解決済',
        _ => status,
      };

  String get createdLabel {
    if (createdAt == null) {
      return '-';
    }
    return DateFormat('yyyy/MM/dd HH:mm').format(createdAt!);
  }
}

/// Report list wired to [adminGetReports] / [adminResolveReport].
class ReportListBodyWidget extends StatefulWidget {
  const ReportListBodyWidget({super.key});

  @override
  State<ReportListBodyWidget> createState() => _ReportListBodyWidgetState();
}

class _ReportListBodyWidgetState extends State<ReportListBodyWidget> {
  final _query = AdminListQueryState();
  List<ReportListItem> _items = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;
  String? _statusFilter;

  static const _statusOptions = {
    null: 'すべて',
    'pending': '未対応',
    'in_progress': '対応中',
    'resolved': '解決済',
  };

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetReports(
        status: _statusFilter,
        limit: _query.pageSize,
        offset: _query.offset,
      );
      final raw = (result?['reports'] as List?) ?? [];
      setState(() {
        _items = raw
            .map((e) => ReportListItem.fromMap(
                  Map<String, dynamic>.from(e as Map),
                ))
            .toList();
        _total = (result?['total'] as int?) ?? _items.length;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _resolve(ReportListItem item, String resolution) async {
    final label = _statusOptions[resolution] ?? resolution;
    final ok = await showAdminConfirmDialog(
      context,
      title: '通報を$labelにする',
      message: 'この通報のステータスを変更しますか？',
    );
    if (!ok) {
      return;
    }
    await adminResolveReport(reportId: item.id, resolution: resolution);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              DropdownButton<String?>(
                value: _statusFilter,
                items: _statusOptions.entries
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    _statusFilter = v;
                    _query.page = 0;
                  });
                  _load();
                },
              ),
              const Spacer(),
              IconButton(onPressed: _load, icon: const Icon(Icons.refresh)),
            ],
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(_error!, style: TextStyle(color: theme.error)),
          ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _items.isEmpty
                  ? const Center(child: Text('通報はありません'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: _items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Card(
                          child: ListTile(
                            title: Text(item.reason.isEmpty ? '(理由なし)' : item.reason),
                            subtitle: Text(
                              '通報者: ${item.reporterId}\n'
                              '対象: ${item.reportedUserId}\n'
                              '状態: ${item.statusLabel} / ${item.createdLabel}',
                            ),
                            isThreeLine: true,
                            trailing: item.status != 'resolved'
                                ? Wrap(
                                    spacing: 4,
                                    children: [
                                      if (item.status != 'in_progress')
                                        TextButton(
                                          onPressed: () =>
                                              _resolve(item, 'in_progress'),
                                          child: const Text('対応中'),
                                        ),
                                      FilledButton(
                                        onPressed: () =>
                                            _resolve(item, 'resolved'),
                                        child: const Text('解決'),
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
