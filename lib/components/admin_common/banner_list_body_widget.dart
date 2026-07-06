import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_confirm_dialog.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class BannerListItem {
  BannerListItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.linkUrl,
    required this.active,
    required this.sortOrder,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String linkUrl;
  final bool active;
  final int sortOrder;

  factory BannerListItem.fromMap(Map<String, dynamic> map) {
    return BannerListItem(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      imageUrl: map['image_url'] as String? ?? '',
      linkUrl: map['link_url'] as String? ?? '',
      active: map['active'] == true,
      sortOrder: (map['sort_order'] as num?)?.toInt() ?? 0,
    );
  }
}

/// Banner list + inline editor wired to [adminGetBanners] / [adminUpsertBanner].
class BannerListBodyWidget extends StatefulWidget {
  const BannerListBodyWidget({super.key});

  @override
  State<BannerListBodyWidget> createState() => _BannerListBodyWidgetState();
}

class _BannerListBodyWidgetState extends State<BannerListBodyWidget> {
  List<BannerListItem> _items = [];
  bool _isLoading = true;
  String? _error;
  String? _selectedId;
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _linkUrlController = TextEditingController();
  bool _active = true;
  int _sortOrder = 0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _linkUrlController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetBanners();
      final raw = (result?['banners'] as List?) ?? [];
      setState(() {
        _items = raw
            .map((e) => BannerListItem.fromMap(
                  Map<String, dynamic>.from(e as Map),
                ))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _select(BannerListItem? item) {
    setState(() {
      _selectedId = item?.id;
      _titleController.text = item?.title ?? '';
      _imageUrlController.text = item?.imageUrl ?? '';
      _linkUrlController.text = item?.linkUrl ?? '';
      _active = item?.active ?? true;
      _sortOrder = item?.sortOrder ?? 0;
    });
  }

  void _newBanner() {
    setState(() {
      _selectedId = null;
      _titleController.clear();
      _imageUrlController.clear();
      _linkUrlController.clear();
      _active = true;
      _sortOrder = _items.length;
    });
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await adminUpsertBanner(
        bannerId: _selectedId,
        payload: {
          'title': _titleController.text.trim(),
          'image_url': _imageUrlController.text.trim(),
          'link_url': _linkUrlController.text.trim(),
          'active': _active,
          'sort_order': _sortOrder,
        },
      );
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('バナーを保存しました')),
        );
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(_error!, style: TextStyle(color: theme.error)),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _newBanner,
                  icon: const Icon(Icons.add),
                  label: const Text('新規バナー'),
                ),
              ),
              Expanded(
                child: _items.isEmpty
                    ? const Center(child: Text('バナーがありません'))
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return ListTile(
                            selected: item.id == _selectedId,
                            title: Text(item.title.isEmpty ? '(無題)' : item.title),
                            subtitle: Text(
                              '${item.active ? "公開" : "非公開"} / 順序: ${item.sortOrder}',
                            ),
                            onTap: () => _select(item),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('バナー編集', style: theme.titleMedium),
                const SizedBox(height: 12),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'タイトル',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    labelText: '画像URL（Storage URL）',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _linkUrlController,
                  decoration: const InputDecoration(
                    labelText: 'リンクURL',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('公開'),
                  value: _active,
                  onChanged: (v) => setState(() => _active = v),
                ),
                Row(
                  children: [
                    const Text('表示順: '),
                    IconButton(
                      onPressed: () => setState(() => _sortOrder--),
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$_sortOrder'),
                    IconButton(
                      onPressed: () => setState(() => _sortOrder++),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('保存'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
