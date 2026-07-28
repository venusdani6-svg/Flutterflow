import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'affiliate_list_page_widget.dart' show AffiliateListPageWidget;
import 'package:flutter/material.dart';

class AffiliateListPageModel extends FlutterFlowModel<AffiliateListPageWidget> {
  ///  Local state fields for this page.

  dynamic affiliateOverviewResult;

  bool isOverviewLoaded = false;

  String selectedAffiliatorUid = '';

  String selectedAffiliatorNickname = '';

  bool isOverviewLoaded1 = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetAffiliateOverview] action in AffiliateListPage widget.
  dynamic affiliateOverviewResult1;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - adminUpdateAffiliateRate] action in Button widget.
  dynamic saveRateResult;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    tabBarController?.dispose();
  }
}
