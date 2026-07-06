import '/backend/cloud_functions/mobile_calls.dart';
import '/backend/mobile/mobile_app_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

/// Admin-side preview of mobile APIs (getAppHomeData / getAppFeatureFlags).
class MobileIntegrationPreviewWidget extends StatefulWidget {
  const MobileIntegrationPreviewWidget({super.key});

  @override
  State<MobileIntegrationPreviewWidget> createState() =>
      _MobileIntegrationPreviewWidgetState();
}

class _MobileIntegrationPreviewWidgetState
    extends State<MobileIntegrationPreviewWidget> {
  final _service = MobileAppService();
  bool _loading = true;
  String? _error;
  AppHomeData? _home;
  AppFeatureFlags? _flags;
  Map<String, dynamic>? _connectStatus;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final results = await Future.wait([
        _service.fetchHomeData(),
        _service.fetchFeatureFlags(),
        getStripeConnectStatus(),
      ]);
      if (!mounted) {
        return;
      }
      setState(() {
        _home = results[0] as AppHomeData;
        _flags = results[1] as AppFeatureFlags;
        _connectStatus = results[2] as Map<String, dynamic>?;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Widget _flagChip(String label, bool enabled) {
    return Chip(
      label: Text(label),
      backgroundColor: enabled ? Colors.green.shade100 : Colors.grey.shade200,
      avatar: Icon(
        enabled ? Icons.check_circle : Icons.cancel,
        color: enabled ? Colors.green : Colors.grey,
        size: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('API エラー', style: theme.titleMedium),
            const SizedBox(height: 8),
            Text(_error!, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _refresh,
              icon: const Icon(Icons.refresh),
              label: const Text('再試行'),
            ),
          ],
        ),
      );
    }

    final home = _home!;
    final flags = _flags!;

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'モバイル API プレビュー',
                  style: theme.headlineSmall,
                ),
              ),
              IconButton(
                onPressed: _refresh,
                icon: const Icon(Icons.refresh),
                tooltip: '再取得',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '管理画面の変更がモバイルにどう見えるか確認します。'
            '本番ではモバイルアプリが同じ Callable を呼び出します。',
            style: theme.bodySmall,
          ),
          const SizedBox(height: 24),
          Text('機能フラグ（タブ表示）', style: theme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _flagChip('cocoten', flags.cocoten),
              _flagChip('staff', flags.staff),
              _flagChip('staff_shuttle', flags.staffShuttle),
              _flagChip('affiliate', flags.affiliate),
            ],
          ),
          if (flags.chatCloseSec != null) ...[
            const SizedBox(height: 8),
            Text('chat_close_sec: ${flags.chatCloseSec}'),
          ],
          const Divider(height: 32),
          Text('Home バナー（active）', style: theme.titleMedium),
          const SizedBox(height: 8),
          if (home.banners.isEmpty)
            const Text('有効なバナーはありません')
          else
            ...home.banners.map(
              (b) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: (b['image_url'] as String?)?.isNotEmpty == true
                    ? Image.network(
                        b['image_url'] as String,
                        width: 64,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      )
                    : const Icon(Icons.image),
                title: Text(b['title'] as String? ?? '(無題)'),
                subtitle: Text(
                  'sort: ${b['sort_order']} · ${b['link_url'] ?? ''}',
                ),
              ),
            ),
          const Divider(height: 32),
          Text('お知らせ（直近）', style: theme.titleMedium),
          const SizedBox(height: 8),
          if (home.announcements.isEmpty)
            const Text('公開中のお知らせはありません')
          else
            ...home.announcements.map(
              (a) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(a['title'] as String? ?? '(無題)'),
                subtitle: Text(a['body'] as String? ?? ''),
              ),
            ),
          const Divider(height: 32),
          Text('Stripe Connect（現在のログインユーザー）', style: theme.titleMedium),
          const SizedBox(height: 8),
          if (_connectStatus == null)
            const Text('状態を取得できませんでした')
          else
            Text(
              'hasAccount: ${_connectStatus!['hasAccount']}\n'
              'onboardingComplete: ${_connectStatus!['onboardingComplete']}\n'
              'chargesEnabled: ${_connectStatus!['chargesEnabled']}\n'
              'payoutsEnabled: ${_connectStatus!['payoutsEnabled']}',
            ),
          if (home.generatedAt != null) ...[
            const SizedBox(height: 24),
            Text(
              '最終取得: ${home.generatedAt}',
              style: theme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
