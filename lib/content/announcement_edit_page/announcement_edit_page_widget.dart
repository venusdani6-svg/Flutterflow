import '/auth/admin_auth_util.dart';
import '/backend/cloud_functions/admin_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'package:flutter/material.dart';
import 'announcement_edit_page_model.dart';
export 'announcement_edit_page_model.dart';

class AnnouncementEditPageWidget extends StatefulWidget {
  const AnnouncementEditPageWidget({super.key});

  static String routeName = 'AnnouncementEditPage';
  static String routePath = '/announcementEditPage';

  @override
  State<AnnouncementEditPageWidget> createState() =>
      _AnnouncementEditPageWidgetState();
}

class _AnnouncementEditPageWidgetState extends State<AnnouncementEditPageWidget> {
  late AnnouncementEditPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnnouncementEditPageModel());
    _model.announcementId =
        GoRouterState.of(context).uri.queryParameters['announcementId'];
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await guardAdminAccess(context);
      await _model.load();
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(_model.announcementId == null ? 'お知らせ作成' : 'お知らせ編集'),
        actions: [
          TextButton(
            onPressed: _model.isSaving
                ? null
                : () async {
                    final err = await _model.save();
                    if (err != null && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(err)),
                      );
                    } else if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('保存しました')),
                      );
                      context.safePop();
                    }
                  },
            child: const Text('保存', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _model.titleController,
                    decoration: const InputDecoration(
                      labelText: 'タイトル',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: TextField(
                      controller: _model.bodyController,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        labelText: '本文',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('公開'),
                    value: _model.published,
                    onChanged: (v) => setState(() => _model.published = v),
                  ),
                ],
              ),
            ),
    );
  }
}
