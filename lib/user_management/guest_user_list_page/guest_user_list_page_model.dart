import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'guest_user_list_page_widget.dart' show GuestUserListPageWidget;
import 'package:flutter/material.dart';

class GuestUserListPageModel extends FlutterFlowModel<GuestUserListPageWidget> {
  ///  Local state fields for this page.

  List<dynamic> userList = [];
  void addToUserList(dynamic item) => userList.add(item);
  void removeFromUserList(dynamic item) => userList.remove(item);
  void removeAtIndexFromUserList(int index) => userList.removeAt(index);
  void insertAtIndexInUserList(int index, dynamic item) =>
      userList.insert(index, item);
  void updateUserListAtIndex(int index, Function(dynamic) updateFn) =>
      userList[index] = updateFn(userList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetUsers] action in GuestUserListPage widget.
  dynamic usersResult;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - adminGetUsers] action in PreviousPageButton widget.
  dynamic prevSearchResult;
  // Stores action output result for [Custom Action - adminGetUsers] action in NextPageButton widget.
  dynamic searchResult;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
