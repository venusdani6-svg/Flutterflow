import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'banner_list_page_widget.dart' show BannerListPageWidget;
import 'package:flutter/material.dart';

class BannerListPageModel extends FlutterFlowModel<BannerListPageWidget> {
  ///  Local state fields for this page.

  bool isBannersLoaded = false;

  dynamic bannersResult1;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetBanners] action in BannerListPage widget.
  dynamic bannersResult;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
