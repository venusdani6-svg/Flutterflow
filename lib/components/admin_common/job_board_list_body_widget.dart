import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/components/admin_common/admin_timestamp_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobBoardListItem {
  JobBoardListItem({
    required this.id,
    required this.title,
    required this.prefecture,
    required this.status,
    this.createdAt,
  });

  final String id;
  final String title;
  final String prefecture;
  final String status;
  final DateTime? createdAt;

  factory JobBoardListItem.fromMap(Map<String, dynamic> map) {
    return JobBoardListItem(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '(無題)',
      prefecture: map['prefecture'] as String? ?? '-',
      status: map['status'] as String? ?? 'open',
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

class JobBoardListBodyWidget extends StatefulWidget {
  const JobBoardListBodyWidget({super.key});

  @override
  State<JobBoardListBodyWidget> createState() => _JobBoardListBodyWidgetState();
}

class _JobBoardListBodyWidgetState extends State<JobBoardListBodyWidget> {
  final _query = AdminListQueryState();
  List<JobBoardListItem> _items = [];
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
      final result = await adminGetJobBoardPosts(
        limit: _query.pageSize,
        offset: _query.offset,
      );
      final raw = (result?['posts'] as List?) ?? [];
      setState(() {
        _items = raw
            .map((e) => JobBoardListItem.fromMap(
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
                  ? const Center(child: Text('掲示板投稿がありません'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: _items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4),
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ListTile(
                          tileColor: theme.secondaryBackground,
                          title: Text(item.title),
                          subtitle: Text(
                            '${item.prefecture} · ${item.status}\n${item.createdLabel}',
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
