import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_confirm_dialog.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/components/admin_common/admin_user_list_card.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';

/// KYC pending review list wired to [adminGetUsers] + [adminApproveKYC].
class KycReviewListBodyWidget extends StatefulWidget {
  const KycReviewListBodyWidget({super.key});

  @override
  State<KycReviewListBodyWidget> createState() =>
      _KycReviewListBodyWidgetState();
}

class _KycReviewListBodyWidgetState extends State<KycReviewListBodyWidget> {
  final _query = AdminListQueryState();
  final _searchController = TextEditingController();
  List<AdminUserListItem> _users = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetUsers(
        kycStatus: 'pending',
        search: _query.search.isNotEmpty ? _query.search : null,
        orderBy: 'created_time',
        orderDirection: 'desc',
        limit: _query.pageSize,
        offset: _query.offset,
      );
      if (result == null) {
        throw Exception('KYC審査一覧の取得に失敗しました');
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
        _total = (result['total'] as int?) ?? items.length;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _reviewUser(AdminUserListItem user, bool approved) async {
    final action = approved ? '承認' : '却下';
    final confirmed = await showAdminConfirmDialog(
      context,
      title: 'KYC $action',
      message: '${user.displayName} を$actionしますか？',
    );
    if (!confirmed) {
      return;
    }
    await adminApproveKYC(userId: user.id, approved: approved);
    await _loadUsers();
  }

  void _openUserDetails(AdminUserListItem user) {
    final routeName = switch (user.role) {
      1 => CastUserdetailsPageWidget.routeName,
      2 => StaffUserdetailsPageWidget.routeName,
      _ => GuestUserdetailsPageWidget.routeName,
    };
    context.pushNamed(
      routeName,
      queryParameters: {'userId': user.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'メール・表示名で検索',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: (value) {
                    _query.search = value;
                    _query.page = 0;
                    _loadUsers();
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _query.search = _searchController.text;
                  _query.page = 0;
                  _loadUsers();
                },
                child: const Text('検索'),
              ),
            ],
          ),
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
                  ? const Center(child: Text('審査待ちユーザーはありません'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return Card(
                          child: Column(
                            children: [
                              AdminUserListCard(
                                user: user,
                                selected: false,
                                onSelectedChanged: (_) {},
                                onTap: () => _openUserDetails(user),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  12,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          _reviewUser(user, false),
                                      child: const Text('却下'),
                                    ),
                                    const SizedBox(width: 8),
                                    FilledButton(
                                      onPressed: () =>
                                          _reviewUser(user, true),
                                      child: const Text('承認'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
