import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'k_y_c_review_list_page_widget.dart' show KYCReviewListPageWidget;
import 'package:flutter/material.dart';

class KYCReviewListPageModel extends FlutterFlowModel<KYCReviewListPageWidget> {
  ///  Local state fields for this page.

  List<KycUserItemStruct> kycUserListTyped = [];
  void addToKycUserListTyped(KycUserItemStruct item) =>
      kycUserListTyped.add(item);
  void removeFromKycUserListTyped(KycUserItemStruct item) =>
      kycUserListTyped.remove(item);
  void removeAtIndexFromKycUserListTyped(int index) =>
      kycUserListTyped.removeAt(index);
  void insertAtIndexInKycUserListTyped(int index, KycUserItemStruct item) =>
      kycUserListTyped.insert(index, item);
  void updateKycUserListTypedAtIndex(
          int index, Function(KycUserItemStruct) updateFn) =>
      kycUserListTyped[index] = updateFn(kycUserListTyped[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetKycUsersList] action in KYCReviewListPage widget.
  List<KycUserItemStruct>? kycListTypedInitRaw;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - adminGetKycUsersList] action in Container widget.
  List<KycUserItemStruct>? kycListTypedOrphanRaw;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
