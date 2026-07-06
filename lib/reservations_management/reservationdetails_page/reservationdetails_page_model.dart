import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'reservationdetails_page_widget.dart' show ReservationdetailsPageWidget;
import 'package:flutter/material.dart';

class ReservationdetailsPageModel
    extends FlutterFlowModel<ReservationdetailsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;

  String reservationId = '';

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
