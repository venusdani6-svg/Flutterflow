import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'guest_userdetails_page_widget.dart' show GuestUserdetailsPageWidget;
import 'package:flutter/material.dart';

class GuestUserdetailsPageModel
    extends FlutterFlowModel<GuestUserdetailsPageWidget> {
  ///  Local state fields for this page.

  dynamic guestDetail;

  List<ReservationHistoryItemStruct> reservationsList = [];
  void addToReservationsList(ReservationHistoryItemStruct item) =>
      reservationsList.add(item);
  void removeFromReservationsList(ReservationHistoryItemStruct item) =>
      reservationsList.remove(item);
  void removeAtIndexFromReservationsList(int index) =>
      reservationsList.removeAt(index);
  void insertAtIndexInReservationsList(
          int index, ReservationHistoryItemStruct item) =>
      reservationsList.insert(index, item);
  void updateReservationsListAtIndex(
          int index, Function(ReservationHistoryItemStruct) updateFn) =>
      reservationsList[index] = updateFn(reservationsList[index]);

  bool? isReservationsLoaded = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetUsers] action in GuestUserdetailsPage widget.
  dynamic userDetailResult;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Custom Action - adminGetGuestReservationsList] action in TabBar widget.
  List<ReservationHistoryItemStruct>? reservationsRawList;
  // State field(s) for ForceDeleteUserReasonField widget.
  FocusNode? forceDeleteUserReasonFieldFocusNode;
  TextEditingController? forceDeleteUserReasonFieldTextController;
  String? Function(BuildContext, String?)?
      forceDeleteUserReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminForceDeleteUser] action in ForceDeleteUserButton widget.
  dynamic forceDeleteUserResult;
  // State field(s) for FreezeUserReasonField widget.
  FocusNode? freezeUserReasonFieldFocusNode;
  TextEditingController? freezeUserReasonFieldTextController;
  String? Function(BuildContext, String?)?
      freezeUserReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - adminToggleFreeze] action in FreezeUserButton widget.
  dynamic freezeUserResult;
  // Stores action output result for [Custom Action - adminToggleFreeze] action in UnfreezeUserButton widget.
  dynamic unfreezeUserResult;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    tabBarController?.dispose();
    forceDeleteUserReasonFieldFocusNode?.dispose();
    forceDeleteUserReasonFieldTextController?.dispose();

    freezeUserReasonFieldFocusNode?.dispose();
    freezeUserReasonFieldTextController?.dispose();
  }
}
