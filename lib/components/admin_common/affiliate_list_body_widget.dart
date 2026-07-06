import '/backend/cloud_functions/admin_calls.dart';
import '/components/admin_common/admin_confirm_dialog.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Affiliate overview (3 tabs) wired to [adminGetAffiliateOverview].
class AffiliateListBodyWidget extends StatefulWidget {
  const AffiliateListBodyWidget({super.key});

  @override
  State<AffiliateListBodyWidget> createState() =>
      _AffiliateListBodyWidgetState();
}

class _AffiliateListBodyWidgetState extends State<AffiliateListBodyWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _affiliates = [];
  List<Map<String, dynamic>> _monthlyRewards = [];
  String? _selectedUserId;
  double _selectedRate = 10;
  bool _isSavingRate = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final result = await adminGetAffiliateOverview();
      setState(() {
        _affiliates = ((result?['affiliates'] as List?) ?? [])
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
        _monthlyRewards = ((result?['monthlyRewards'] as List?) ?? [])
            .map((e) => Map<String, dynamic>.from(e as Map))
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

  Future<void> _saveRate() async {
    if (_selectedUserId == null) {
      return;
    }
    final ok = await showAdminConfirmDialog(
      context,
      title: '報酬率を更新',
      message: '報酬率を ${_selectedRate.round()}% に設定しますか？',
    );
    if (!ok) {
      return;
    }
    setState(() => _isSavingRate = true);
    try {
      await adminUpdateAffiliateRate(
        userId: _selectedUserId!,
        rate: _selectedRate,
      );
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('報酬率を保存しました')),
        );
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isSavingRate = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final currency = NumberFormat('#,###');
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        if (_error != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(_error!, style: TextStyle(color: theme.error)),
          ),
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '月次報酬一覧'),
            Tab(text: 'アフィリエイター一覧'),
            Tab(text: '報酬率設定'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _monthlyRewards.isEmpty
                  ? const Center(child: Text('月次報酬データがありません'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _monthlyRewards.length,
                      itemBuilder: (context, index) {
                        final row = _monthlyRewards[index];
                        return ListTile(
                          title: Text('${row['month'] ?? row['id'] ?? '-'}'),
                          subtitle: Text(
                            'ユーザー: ${row['user_id'] ?? '-'}\n'
                            '報酬: ¥${currency.format((row['amount'] as num?)?.round() ?? 0)}',
                          ),
                          isThreeLine: true,
                        );
                      },
                    ),
              _affiliates.isEmpty
                  ? const Center(child: Text('アフィリエイターがいません'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _affiliates.length,
                      itemBuilder: (context, index) {
                        final a = _affiliates[index];
                        final id = a['id'] as String? ?? '';
                        return ListTile(
                          title: Text(
                            a['display_name'] as String? ??
                                a['email'] as String? ??
                                id,
                          ),
                          subtitle: Text(
                            'ID: $id\n'
                            '報酬率: ${a['affiliate_rate'] ?? '-'}%',
                          ),
                          isThreeLine: true,
                          onTap: () {
                            setState(() {
                              _selectedUserId = id;
                              _selectedRate =
                                  (a['affiliate_rate'] as num?)?.toDouble() ??
                                      10;
                            });
                            _tabController.animateTo(2);
                          },
                        );
                      },
                    ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('対象ユーザー: ${_selectedUserId ?? "一覧から選択"}'),
                    const SizedBox(height: 16),
                    Text('報酬率: ${_selectedRate.round()}%'),
                    Slider(
                      value: _selectedRate,
                      min: 5,
                      max: 30,
                      divisions: 25,
                      label: '${_selectedRate.round()}%',
                      onChanged: _selectedUserId == null
                          ? null
                          : (v) => setState(() => _selectedRate = v),
                    ),
                    FilledButton(
                      onPressed:
                          _selectedUserId == null || _isSavingRate ? null : _saveRate,
                      child: _isSavingRate
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('報酬率を保存'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
