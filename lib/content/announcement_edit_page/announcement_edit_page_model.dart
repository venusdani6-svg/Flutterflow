import '/backend/cloud_functions/admin_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'announcement_edit_page_widget.dart' show AnnouncementEditPageWidget;
import 'package:flutter/material.dart';

class AnnouncementEditPageModel
    extends FlutterFlowModel<AnnouncementEditPageWidget> {
  String? announcementId;
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  bool published = true;
  bool isLoading = false;
  bool isSaving = false;

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
  }

  Future<void> load() async {
    if (announcementId == null) {
      return;
    }
    isLoading = true;
    try {
      final result = await adminGetAnnouncements(limit: 100);
      final list = (result?['announcements'] as List?) ?? [];
      final match = list.cast<Map>().firstWhere(
            (e) => e['id'] == announcementId,
            orElse: () => {},
          );
      if (match.isNotEmpty) {
        titleController.text = '${match['title'] ?? ''}';
        bodyController.text = '${match['body'] ?? match['content'] ?? ''}';
        published = match['published'] == true || match['active'] == true;
      }
    } finally {
      isLoading = false;
    }
  }

  Future<String?> save() async {
    isSaving = true;
    try {
      await adminUpsertAnnouncement(
        announcementId: announcementId,
        payload: {
          'title': titleController.text.trim(),
          'body': bodyController.text.trim(),
          'published': published,
          'active': published,
        },
      );
      return null;
    } catch (e) {
      return e.toString();
    } finally {
      isSaving = false;
    }
  }
}
