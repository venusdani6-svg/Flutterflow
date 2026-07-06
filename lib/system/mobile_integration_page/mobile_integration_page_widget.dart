import '/auth/admin_auth_util.dart';
import '/components/admin_common/mobile_integration_preview_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'mobile_integration_page_model.dart';
export 'mobile_integration_page_model.dart';

class MobileIntegrationPageWidget extends StatefulWidget {
  const MobileIntegrationPageWidget({super.key});

  static String routeName = 'MobileIntegrationPage';
  static String routePath = '/mobileIntegrationPage';

  @override
  State<MobileIntegrationPageWidget> createState() =>
      _MobileIntegrationPageWidgetState();
}

class _MobileIntegrationPageWidgetState
    extends State<MobileIntegrationPageWidget> {
  late MobileIntegrationPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MobileIntegrationPageModel());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await guardAdminAccess(context);
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
        title: const Text('モバイル連携プレビュー'),
      ),
      body: const MobileIntegrationPreviewWidget(),
    );
  }
}
