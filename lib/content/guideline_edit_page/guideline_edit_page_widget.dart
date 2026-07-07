import '/auth/admin_auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'guideline_edit_page_model.dart';
export 'guideline_edit_page_model.dart';

class GuidelineEditPageWidget extends StatefulWidget {
  const GuidelineEditPageWidget({super.key});

  static String routeName = 'GuidelineEditPage';
  static String routePath = '/guidelineEditPage';

  @override
  State<GuidelineEditPageWidget> createState() =>
      _GuidelineEditPageWidgetState();
}

class _GuidelineEditPageWidgetState extends State<GuidelineEditPageWidget> {
  late GuidelineEditPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GuidelineEditPageModel());
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
      appBar: AppBar(
        title: const Text('ガイドライン編集'),
        actions: [
          TextButton(
            onPressed: _model.isSaving
                ? null
                : () async {
                    final err = await _model.save();
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(err ?? 'ガイドラインを保存しました'),
                      ),
                    );
                  },
            child: const Text('保存', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _model.contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: 'ガイドライン本文',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ),
    );
  }
}
