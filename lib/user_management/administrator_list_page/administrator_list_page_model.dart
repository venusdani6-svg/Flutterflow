import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'administrator_list_page_widget.dart' show AdministratorListPageWidget;
import 'package:flutter/material.dart';

class AdministratorListPageModel
    extends FlutterFlowModel<AdministratorListPageWidget> {
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

  // Stores action output result for [Custom Action - adminGetUserListItems] action in AdministratorListPage widget.
  List<AdminUserListItemStruct>? administratorListInitRaw;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - guestListHasSelection] action in AdminBulkFreezeButton widget.
  bool? bulkFreezeHasSelection;
  // Stores action output result for [Custom Action - adminBulkToggleFreeze] action in AdminBulkFreezeButton widget.
  dynamic bulkFreezeResult;
  // Stores action output result for [Custom Action - guestListHasSelection] action in AdminBulkUnfreezeButton widget.
  bool? bulkUnfreezeHasSelection;
  // Stores action output result for [Custom Action - adminBulkToggleFreeze] action in AdminBulkUnfreezeButton widget.
  dynamic bulkUnfreezeResult;
  // State field(s) for Checkbox widget.
  Map<AdminUserListItemStruct, bool> checkboxValueMap = {};
  List<AdminUserListItemStruct> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // State field(s) for AdminBulkFreezeReasonField widget.
  FocusNode? adminBulkFreezeReasonFieldFocusNode;
  TextEditingController? adminBulkFreezeReasonFieldTextController;
  String? Function(BuildContext, String?)?
      adminBulkFreezeReasonFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    adminBulkFreezeReasonFieldFocusNode?.dispose();
    adminBulkFreezeReasonFieldTextController?.dispose();
  }
}
