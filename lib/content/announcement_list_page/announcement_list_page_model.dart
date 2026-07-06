import '/flutter_flow/flutter_flow_util.dart';
import 'announcement_list_page_widget.dart' show AnnouncementListPageWidget;
import 'package:flutter/material.dart';

class AnnouncementListPageModel
    extends FlutterFlowModel<AnnouncementListPageWidget> {
  List<Map<String, dynamic>> items = [];
  bool isLoading = false;
  String? error;
}
