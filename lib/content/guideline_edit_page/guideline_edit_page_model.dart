import '/backend/cloud_functions/admin_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'guideline_edit_page_widget.dart' show GuidelineEditPageWidget;
import 'package:flutter/material.dart';

class GuidelineEditPageModel extends FlutterFlowModel<GuidelineEditPageWidget> {
  final contentController = TextEditingController();
  bool isLoading = false;
  bool isSaving = false;

  @override
  void dispose() {
    contentController.dispose();
  }

  Future<void> load() async {
    isLoading = true;
    try {
      final result = await adminGetGuideline();
      contentController.text = '${result?['content'] ?? ''}';
    } finally {
      isLoading = false;
    }
  }

  Future<String?> save() async {
    isSaving = true;
    try {
      await adminUpdateGuideline(content: contentController.text);
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      isSaving = false;
    }
  }
}
