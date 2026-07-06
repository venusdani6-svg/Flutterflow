import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_list_query_state.dart';
import '/components/admin_common/admin_pagination_bar.dart';
import '/components/admin_common/admin_timestamp_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CocotenShopListItem {
  CocotenShopListItem({
    required this.id,
    required this.name,
    required this.prefecture,
    required this.active,
    this.createdAt,
  });

  final String id;
  final String name;
  final String prefecture;
  final bool active;
  final DateTime? createdAt;

  factory CocotenShopListItem.fromMap(Map<String, dynamic> map) {
    return CocotenShopListItem(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? map['shop_name'] as String? ?? '(無題)',
      prefecture: map['prefecture'] as String? ?? '-',
      active: map['active'] == true,
      createdAt: parseAdminTimestamp(map['created_at']),
    );
  }
}

/// Cocoten shop list (features_enabled.cocoten ON 時).
class CocotenListBodyWidget extends StatefulWidget {
  const CocotenListBodyWidget({super.key});

  @override
  State<CocotenListBodyWidget> createState() => _CocotenListBodyWidgetState();
}

class _CocotenListBodyWidgetState extends State<CocotenListBodyWidget> {
  final _query = AdminListQueryState();
  List<CocotenShopListItem> _items = [];
  int _total = 0;
  bool _isLoading = false;
  String? _error;
  String? _selectedId;
  final _nameController = TextEditingController();
  final _prefectureController = TextEditingController();
  bool _active = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _prefectureController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetCocotenShops(
        limit: _query.pageSize,
        offset: _query.offset,
      );
      final raw = (result?['shops'] as List?) ?? [];
      setState(() {
        _items = raw
            .map((e) => CocotenShopListItem.fromMap(
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

  void _select(CocotenShopListItem item) {
    setState(() {
      _selectedId = item.id;
      _nameController.text = item.name;
      _prefectureController.text = item.prefecture == '-' ? '' : item.prefecture;
      _active = item.active;
    });
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await adminUpsertCocotenShop(
        shopId: _selectedId,
        payload: {
          'name': _nameController.text.trim(),
          'prefecture': _prefectureController.text.trim(),
          'active': _active,
        },
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ココ店を保存しました')),
      );
      setState(() => _selectedId = null);
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失敗: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
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
          flex: 2,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _items.isEmpty
                  ? const Center(child: Text('ココ店がありません'))
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ListTile(
                          selected: item.id == _selectedId,
                          title: Text(item.name),
                          subtitle: Text('${item.prefecture} · ${item.active ? "有効" : "無効"}'),
                          onTap: () => _select(item),
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
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '店舗名',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _prefectureController,
                decoration: const InputDecoration(
                  labelText: '都道府県',
                  border: OutlineInputBorder(),
                ),
              ),
              SwitchListTile(
                title: const Text('有効'),
                value: _active,
                onChanged: (v) => setState(() => _active = v),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: _isSaving ? null : _save,
                  child: Text(_selectedId == null ? '新規作成' : '更新'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
