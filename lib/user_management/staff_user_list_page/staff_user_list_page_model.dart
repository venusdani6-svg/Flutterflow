import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'staff_user_list_page_widget.dart' show StaffUserListPageWidget;
import 'package:flutter/material.dart';

class StaffUserListPageModel extends FlutterFlowModel<StaffUserListPageWidget> {
  ///  Local state fields for this page.

  List<String> selectedIds = [];
  void addToSelectedIds(String item) => selectedIds.add(item);
  void removeFromSelectedIds(String item) => selectedIds.remove(item);
  void removeAtIndexFromSelectedIds(int index) => selectedIds.removeAt(index);
  void insertAtIndexInSelectedIds(int index, String item) =>
      selectedIds.insert(index, item);
  void updateSelectedIdsAtIndex(int index, Function(String) updateFn) =>
      selectedIds[index] = updateFn(selectedIds[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetUserListItems] action in StaffUserListPage widget.
  List<AdminUserListItemStruct>? staffListInitRaw;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - guestListHasSelection] action in StaffBulkFreezeButton widget.
  bool? bulkFreezeHasSelection;
  // Stores action output result for [Custom Action - adminBulkToggleFreeze] action in StaffBulkFreezeButton widget.
  dynamic bulkFreezeResult;
  // Stores action output result for [Custom Action - guestListHasSelection] action in StaffBulkUnfreezeButton widget.
  bool? bulkUnfreezeHasSelection;
  // Stores action output result for [Custom Action - adminBulkToggleFreeze] action in StaffBulkUnfreezeButton widget.
  dynamic bulkUnfreezeResult;
  // State field(s) for Checkbox widget.
  Map<AdminUserListItemStruct, bool> checkboxValueMap = {};
  List<AdminUserListItemStruct> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // State field(s) for StaffBulkFreezeReasonField widget.
  FocusNode? staffBulkFreezeReasonFieldFocusNode;
  TextEditingController? staffBulkFreezeReasonFieldTextController;
  String? Function(BuildContext, String?)?
      staffBulkFreezeReasonFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    staffBulkFreezeReasonFieldFocusNode?.dispose();
    staffBulkFreezeReasonFieldTextController?.dispose();
  }
}
