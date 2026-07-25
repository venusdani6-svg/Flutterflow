import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'payment_ledger_list_page_widget.dart' show PaymentLedgerListPageWidget;
import 'package:flutter/material.dart';

class PaymentLedgerListPageModel
    extends FlutterFlowModel<PaymentLedgerListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetLedger] action in PaymentLedgerListPage widget.
  dynamic ledgerFetchResult;
  // Stores action output result for [Custom Action - adminGetReservations] action in PaymentLedgerListPage widget.
  dynamic paymentFetchResult;
  // Stores action output result for [Custom Action - adminGetStripeLogs] action in PaymentLedgerListPage widget.
  dynamic stripeLogFetchResult;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

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
