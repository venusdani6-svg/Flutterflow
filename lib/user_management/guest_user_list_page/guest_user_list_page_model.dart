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

  List<String> selectedIds = [];
  void addToSelectedIds(String item) => selectedIds.add(item);
  void removeFromSelectedIds(String item) => selectedIds.remove(item);
  void removeAtIndexFromSelectedIds(int index) => selectedIds.removeAt(index);
  void insertAtIndexInSelectedIds(int index, String item) =>
      selectedIds.insert(index, item);
  void updateSelectedIdsAtIndex(int index, Function(String) updateFn) =>
      selectedIds[index] = updateFn(selectedIds[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetUsers] action in GuestUserListPage widget.
  dynamic usersResult;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - adminBulkToggleFreeze] action in BulkFreeze widget.
  dynamic bulkFreezeResult;
  // Stores action output result for [Custom Action - adminGetUsers] action in BulkFreeze widget.
  dynamic bulkReloadResult;
  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap = {};
  List<dynamic> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

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
