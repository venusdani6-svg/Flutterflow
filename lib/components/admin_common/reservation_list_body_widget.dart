import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationListItem {
  ReservationListItem({
    required this.id,
    required this.guestId,
    required this.castId,
    required this.status,
    this.scheduledAt,
  });

  final String id;
  final String guestId;
  final String castId;
  final String status;
  final DateTime? scheduledAt;

  factory ReservationListItem.fromMap(Map<String, dynamic> map) {
    DateTime? scheduled;
    final raw = map['scheduled_at'];
    if (raw is Map) {
      final sec = raw['_seconds'] ?? raw['seconds'];
      if (sec != null) {
        scheduled = DateTime.fromMillisecondsSinceEpoch((sec as int) * 1000);
      }
    } else if (raw is String) {
      scheduled = DateTime.tryParse(raw);
    }
    return ReservationListItem(
      id: map['id'] as String? ?? '',
      guestId: map['guest_id'] as String? ?? '-',
      castId: map['cast_id'] as String? ?? '-',
      status: map['status'] as String? ?? '-',
      scheduledAt: scheduled,
    );
  }

  String get scheduledLabel {
    if (scheduledAt == null) {
      return '-';
    }
    return DateFormat('yyyy/MM/dd HH:mm').format(scheduledAt!);
  }
}

/// Reservation list wired to [adminGetReservations].
class ReservationListBodyWidget extends StatefulWidget {
  const ReservationListBodyWidget({super.key});

  @override
  State<ReservationListBodyWidget> createState() =>
      _ReservationListBodyWidgetState();
}

class _ReservationListBodyWidgetState extends State<ReservationListBodyWidget> {
  final _query = AdminListQueryState();
  final _searchController = TextEditingController();
  List<ReservationListItem> _items = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;
  String? _statusFilter;

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadReservations() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetReservations(
        status: _statusFilter,
        search: _query.search.isNotEmpty ? _query.search : null,
        limit: _query.pageSize,
        offset: _query.offset,
      );
      if (result == null) {
        throw Exception('予約一覧の取得に失敗しました');
      }
      final raw = (result['reservations'] as List?) ?? [];
      setState(() {
        _items = raw
            .map(
              (e) => ReservationListItem.fromMap(
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

  void _openDetails(ReservationListItem item) {
    context.pushNamed(
      ReservationdetailsPageWidget.routeName,
      queryParameters: {'reservationId': item.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
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
                    hintText: '予約ID・ゲスト・キャストで検索',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: (value) {
                    _query.search = value;
                    _query.page = 0;
                    _loadReservations();
                  },
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String?>(
                value: _statusFilter,
                hint: const Text('ステータス'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('すべて')),
                  DropdownMenuItem(value: 'pending', child: Text('pending')),
                  DropdownMenuItem(value: 'confirmed', child: Text('confirmed')),
                  DropdownMenuItem(value: 'completed', child: Text('completed')),
                  DropdownMenuItem(value: 'cancelled', child: Text('cancelled')),
                ],
                onChanged: (value) {
                  setState(() {
                    _statusFilter = value;
                    _query.page = 0;
                  });
                  _loadReservations();
                },
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _query.search = _searchController.text;
                  _query.page = 0;
                  _loadReservations();
                },
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
                  ? const Center(child: Text('予約が見つかりません'))
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
                          title: Text('予約ID: ${item.id}'),
                          subtitle: Text(
                            'ゲスト: ${item.guestId} / キャスト: ${item.castId}\n'
                            '日時: ${item.scheduledLabel} / 状態: ${item.status}',
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _openDetails(item),
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
              _loadReservations();
            }
          },
          onNext: () {
            if ((_query.page + 1) * _query.pageSize < _total) {
              setState(() => _query.page++);
              _loadReservations();
            }
          },
        ),
      ],
    );
  }
}
