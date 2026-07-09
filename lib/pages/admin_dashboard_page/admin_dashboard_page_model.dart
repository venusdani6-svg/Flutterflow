import '/flutter_flow/flutter_flow_util.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import '/index.dart';
import 'admin_dashboard_page_widget.dart' show AdminDashboardPageWidget;
import 'package:flutter/material.dart';

class AdminDashboardPageModel
    extends FlutterFlowModel<AdminDashboardPageWidget> {
  ///  Local state fields for this page.

  List<int> salesAmounts = [120000, 98000, 145000, 132000, 168000];
  void addToSalesAmounts(int item) => salesAmounts.add(item);
  void removeFromSalesAmounts(int item) => salesAmounts.remove(item);
  void removeAtIndexFromSalesAmounts(int index) => salesAmounts.removeAt(index);
  void insertAtIndexInSalesAmounts(int index, int item) =>
      salesAmounts.insert(index, item);
  void updateSalesAmountsAtIndex(int index, Function(int) updateFn) =>
      salesAmounts[index] = updateFn(salesAmounts[index]);

  List<String> monthLabels = ['1月', '2月', '3月', '4月', '5月'];
  void addToMonthLabels(String item) => monthLabels.add(item);
  void removeFromMonthLabels(String item) => monthLabels.remove(item);
  void removeAtIndexFromMonthLabels(int index) => monthLabels.removeAt(index);
  void insertAtIndexInMonthLabels(int index, String item) =>
      monthLabels.insert(index, item);
  void updateMonthLabelsAtIndex(int index, Function(String) updateFn) =>
      monthLabels[index] = updateFn(monthLabels[index]);

  List<int> userTypeValues = [450, 280, 45];
  void addToUserTypeValues(int item) => userTypeValues.add(item);
  void removeFromUserTypeValues(int item) => userTypeValues.remove(item);
  void removeAtIndexFromUserTypeValues(int index) =>
      userTypeValues.removeAt(index);
  void insertAtIndexInUserTypeValues(int index, int item) =>
      userTypeValues.insert(index, item);
  void updateUserTypeValuesAtIndex(int index, Function(int) updateFn) =>
      userTypeValues[index] = updateFn(userTypeValues[index]);

  List<String> userTypeLabels = ['ゲスト', 'キャスト', 'スタッフ'];
  void addToUserTypeLabels(String item) => userTypeLabels.add(item);
  void removeFromUserTypeLabels(String item) => userTypeLabels.remove(item);
  void removeAtIndexFromUserTypeLabels(int index) =>
      userTypeLabels.removeAt(index);
  void insertAtIndexInUserTypeLabels(int index, String item) =>
      userTypeLabels.insert(index, item);
  void updateUserTypeLabelsAtIndex(int index, Function(String) updateFn) =>
      userTypeLabels[index] = updateFn(userTypeLabels[index]);

  dynamic testResult;

  ///  State fields for stateful widgets in this page.

  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // Stores action output result for [Custom Action - adminGetDashboardStats] action in Button widget.
  dynamic apiResult;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
  }
}
