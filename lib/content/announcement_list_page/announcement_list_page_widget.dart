import '/auth/admin_auth_util.dart';
import '/backend/cloud_functions/admin_calls.dart';
import '/content/announcement_edit_page/announcement_edit_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'announcement_list_page_model.dart';
export 'announcement_list_page_model.dart';

class AnnouncementListPageWidget extends StatefulWidget {
  const AnnouncementListPageWidget({super.key});

  static String routeName = 'AnnouncementListPage';
  static String routePath = '/announcementListPage';

  @override
  State<AnnouncementListPageWidget> createState() =>
      _AnnouncementListPageWidgetState();
}

class _AnnouncementListPageWidgetState extends State<AnnouncementListPageWidget> {
  late AnnouncementListPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnnouncementListPageModel());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await guardAdminAccess(context);
      await _load();
    });
  }

  Future<void> _load() async {
    setState(() => _model.isLoading = true);
    try {
      final result = await adminGetAnnouncements();
      _model.items = ((result?['announcements'] as List?) ?? [])
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    } catch (e) {
      _model.error = e.toString();
    } finally {
      setState(() => _model.isLoading = false);
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('お知らせ一覧'),
        actions: [
          IconButton(
            onPressed: () async {
              await context.pushNamed(AnnouncementEditPageWidget.routeName);
              await _load();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _model.items.isEmpty
              ? const Center(child: Text('お知らせがありません'))
              : ListView.builder(
                  itemCount: _model.items.length,
                  itemBuilder: (context, index) {
                    final item = _model.items[index];
                    return ListTile(
                      title: Text('${item['title'] ?? '(無題)'}'),
                      subtitle: Text(
                        item['published'] == true || item['active'] == true
                            ? '公開'
                            : '下書き',
                      ),
                      onTap: () async {
                        await context.pushNamed(
                          AnnouncementEditPageWidget.routeName,
                          queryParameters: {
                            'announcementId': '${item['id']}',
                          },
                        );
                        await _load();
                      },
                    );
                  },
                ),
    );
  }
}
