import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_confirm_dialog.dart';
import '/components/admin_common/admin_csv_export.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_list_toolbar.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/components/admin_common/admin_user_list_card.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class AdminUserListConfig {
  const AdminUserListConfig({
    this.role,
    this.roleAdmin,
    required this.detailRouteName,
    required this.csvPrefix,
    this.emptyMessage = 'ユーザーが見つかりません',
  });

  final int? role;
  final String? roleAdmin;
  final String detailRouteName;
  final String csvPrefix;
  final String emptyMessage;
}

/// Generic user list body wired to [adminGetUsers].
class AdminUserListBodyWidget extends StatefulWidget {
  const AdminUserListBodyWidget({super.key, required this.config});

  final AdminUserListConfig config;

  @override
  State<AdminUserListBodyWidget> createState() =>
      _AdminUserListBodyWidgetState();
}

class _AdminUserListBodyWidgetState extends State<AdminUserListBodyWidget> {
  final _query = AdminListQueryState();
  List<AdminUserListItem> _users = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetUsers(
        role: widget.config.role,
        roleAdmin: widget.config.roleAdmin,
        kycStatus: _query.filter.kycStatus,
        search: _query.search.isNotEmpty ? _query.search : null,
        orderBy: _query.sortField,
        orderDirection: _query.sortDescending ? 'desc' : 'asc',
        isFrozen: _query.filter.isFrozen,
        limit: _query.pageSize,
        offset: _query.offset,
      );
      if (result == null) {
        throw Exception('ユーザー一覧の取得に失敗しました');
      }

      final rawUsers = (result['users'] as List?) ?? [];
      final items = rawUsers
          .map(
            (e) => AdminUserListItem.fromMap(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();

      setState(() {
        _users = items;
        _total = _asInt(result['total'], fallback: items.length);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  int _asInt(dynamic value, {int fallback = 0}) {
    if (value is int) {
      return value;
    }
    if (value is double) {
      return value.round();
    }
    return fallback;
  }

  Future<void> _exportCsv() async {
    final csv = buildCsv(
      headers: ['ID', '表示名', 'メール', '種別', '登録日', 'KYC', '状態'],
      rows: _users
          .map(
            (u) => [
              u.id,
              u.displayName,
              u.email,
              u.roleLabel,
              u.createdAtLabel,
              u.kycStatus ?? '',
              u.isFrozen ? '凍結' : '有効',
            ],
          )
          .toList(),
    );
    await downloadCsvFile(
      filename:
          '${widget.config.csvPrefix}_${DateTime.now().millisecondsSinceEpoch}.csv',
      csvContent: csv,
    );
  }

  Future<void> _bulkFreeze() async {
    if (_query.selectedIds.isEmpty) {
      return;
    }
    final confirmed = await showAdminConfirmDialog(
      context,
      title: '一括凍結',
      message: '${_query.selectedIds.length} 件のユーザーを凍結しますか？',
    );
    if (!confirmed) {
      return;
    }
    for (final id in _query.selectedIds) {
      await adminToggleFreeze(userId: id, frozen: true);
    }
    _query.clearSelection();
    await _loadUsers();
  }

  void _openDetails(AdminUserListItem user) {
    context.pushNamed(
      widget.config.detailRouteName,
      queryParameters: {'userId': user.id},
      extra: <String, dynamic>{
        '__transition_info__': TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration.zero,
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdminListToolbar(
          query: _query,
          onQueryChanged: _loadUsers,
          onExportCsv: _exportCsv,
          onBulkFreeze: _bulkFreeze,
          bulkActionLabel: '選択を凍結',
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _error!,
              style: TextStyle(color: FlutterFlowTheme.of(context).error),
            ),
          ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _users.isEmpty
                  ? Center(child: Text(widget.config.emptyMessage))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return AdminUserListCard(
                          user: user,
                          selected: _query.selectedIds.contains(user.id),
                          onSelectedChanged: (selected) {
                            setState(() {
                              if (selected) {
                                _query.selectedIds.add(user.id);
                              } else {
                                _query.selectedIds.remove(user.id);
                              }
                            });
                          },
                          onTap: () => _openDetails(user),
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
              _loadUsers();
            }
          },
          onNext: () {
            if ((_query.page + 1) * _query.pageSize < _total) {
              setState(() => _query.page++);
              _loadUsers();
            }
          },
        ),
      ],
    );
  }
}
