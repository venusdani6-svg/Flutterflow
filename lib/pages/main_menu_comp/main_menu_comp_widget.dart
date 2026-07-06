import '/components/admin_common/admin_side_menu_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'main_menu_comp_model.dart';
export 'main_menu_comp_model.dart';

class MainMenuCompWidget extends StatefulWidget {
  const MainMenuCompWidget({super.key});

  @override
  State<MainMenuCompWidget> createState() => _MainMenuCompWidgetState();
}

class _MainMenuCompWidgetState extends State<MainMenuCompWidget> {
  late MainMenuCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      height: 600.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Stack(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              const AdminSideMenuWidget(),
            ].divide(const SizedBox(height: 16.0)).around(const SizedBox(height: 16.0)),
          ),
        ),
      ),
    );
  }
}
