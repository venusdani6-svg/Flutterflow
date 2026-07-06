import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'payment_ledger_management_page_widget.dart'
    show PaymentLedgerManagementPageWidget;
import 'package:flutter/material.dart';

class PaymentLedgerManagementPageModel
    extends FlutterFlowModel<PaymentLedgerManagementPageWidget> {
  ///  State fields for stateful widgets in this page.

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
