import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/components/admin_common/admin_timestamp_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuditLogListItem {
  AuditLogListItem({
    required this.id,
    required this.action,
    required this.targetType,
    required this.targetId,
    required this.actorUid,
    this.targetUserName,
    this.createdAt,
  });

  final String id;
  final String action;
  final String targetType;
  final String targetId;
  final String actorUid;
  final String? targetUserName;
  final DateTime? createdAt;

  factory AuditLogListItem.fromMap(Map<String, dynamic> map) {
    return AuditLogListItem(
      id: map['id'] as String? ?? '',
      action: map['action'] as String? ?? '',
      targetType: map['target_type'] as String? ?? '',
      targetId: map['target_id'] as String? ?? '',
      actorUid: map['actor_uid'] as String? ?? '',
      targetUserName: map['target_user_name'] as String?,
      createdAt: parseAdminTimestamp(map['created_at']),
    );
  }

  String get createdLabel {
    if (createdAt == null) {
      return '-';
    }
    return DateFormat('yyyy/MM/dd HH:mm').format(createdAt!);
  }
}

class AuditLogListBodyWidget extends StatefulWidget {
  const AuditLogListBodyWidget({super.key});

  @override
  State<AuditLogListBodyWidget> createState() => _AuditLogListBodyWidgetState();
}

class _AuditLogListBodyWidgetState extends State<AuditLogListBodyWidget> {
  final _query = AdminListQueryState();
  List<AuditLogListItem> _items = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;

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
      final result = await adminGetAuditLogs(
        limit: _query.pageSize,
        offset: _query.offset,
      );
      final raw = (result?['logs'] as List?) ?? [];
      setState(() {
        _items = raw
            .map((e) => AuditLogListItem.fromMap(
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

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Column(
      children: [
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(_error!, style: TextStyle(color: theme.error)),
          ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _items.isEmpty
                  ? const Center(child: Text('監査ログがありません'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: _items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ListTile(
                          tileColor: theme.secondaryBackground,
                          title: Text(item.action),
                          subtitle: Text(
                            '${item.targetType} / ${item.targetUserName ?? item.targetId}\n'
                            'by ${item.actorUid} · ${item.createdLabel}',
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
