import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'withdrawal_application_list_page_widget.dart'
    show WithdrawalApplicationListPageWidget;
import 'package:flutter/material.dart';

class WithdrawalApplicationListPageModel
    extends FlutterFlowModel<WithdrawalApplicationListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetPayoutRequests] action in WithdrawalApplicationListPage widget.
  dynamic payoutFetchResult;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - adminApprovePayout] action in Approved widget.
  dynamic payoutActionResult;
  // Stores action output result for [Custom Action - adminGetPayoutRequests] action in Approved widget.
  dynamic payoutRefreshResultApprove;
  // Stores action output result for [Custom Action - adminApprovePayout] action in Pending widget.
  dynamic payoutActionResultPending;
  // Stores action output result for [Custom Action - adminGetPayoutRequests] action in Pending widget.
  dynamic payoutRefreshResultHold;
  // Stores action output result for [Custom Action - adminApprovePayout] action in Rejected widget.
  dynamic payoutActionResultReject;
  // Stores action output result for [Custom Action - adminGetPayoutRequests] action in Rejected widget.
  dynamic payoutRefreshResultReject;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
