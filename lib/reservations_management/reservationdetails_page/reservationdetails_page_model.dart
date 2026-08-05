import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'reservationdetails_page_widget.dart' show ReservationdetailsPageWidget;
import 'package:flutter/material.dart';

class ReservationdetailsPageModel
    extends FlutterFlowModel<ReservationdetailsPageWidget> {
  ///  Local state fields for this page.

  dynamic reservationTipResult;

  ReservationExtrasResultStruct? reservationExtrasList;
  void updateReservationExtrasListStruct(
      Function(ReservationExtrasResultStruct) updateFn) {
    updateFn(reservationExtrasList ??= ReservationExtrasResultStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetReservationExtras] action in ReservationdetailsPage widget.
  ReservationExtrasResultStruct? reservationExtrasInit;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // State field(s) for ForceCancelReasonField widget.
  FocusNode? forceCancelReasonFieldFocusNode;
  TextEditingController? forceCancelReasonFieldTextController;
  String? Function(BuildContext, String?)?
      forceCancelReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminForceCancel] action in ForceCancelButton widget.
  dynamic forceCancelResult;
  // State field(s) for ManualRefundReasonField widget.
  FocusNode? manualRefundReasonFieldFocusNode;
  TextEditingController? manualRefundReasonFieldTextController;
  String? Function(BuildContext, String?)?
      manualRefundReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminManualRefund] action in ManualRefundButton widget.
  dynamic manualRefundResult;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    forceCancelReasonFieldFocusNode?.dispose();
    forceCancelReasonFieldTextController?.dispose();

    manualRefundReasonFieldFocusNode?.dispose();
    manualRefundReasonFieldTextController?.dispose();
  }
}
