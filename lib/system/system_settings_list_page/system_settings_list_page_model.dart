import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/main_menu_comp/main_menu_comp_widget.dart';
import 'system_settings_list_page_widget.dart'
    show SystemSettingsListPageWidget;
import 'package:flutter/material.dart';

class SystemSettingsListPageModel
    extends FlutterFlowModel<SystemSettingsListPageWidget> {
  ///  Local state fields for this page.

  bool isConfigLoaded = false;

  bool areaTokyoActive = false;

  bool areaChibaActive = false;

  bool areaKanagawaActive = false;

  bool areaGifuActive = false;

  bool areaAichiActive = false;

  bool areaKyotoActive = false;

  bool areaOsakaActive = false;

  bool areaHyogoActive = false;

  bool areaOkayamaActive = false;

  bool areaHiroshimaActive = false;

  bool areaFukuokaActive = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - adminGetSystemConfig] action in SystemSettingsListPage widget.
  dynamic systemConfigResult;
  // Model for Main_Menu_Comp component.
  late MainMenuCompModel mainMenuCompModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for ExtensionLimitCountController widget.
  int? extensionLimitCountControllerValue;
  // State field(s) for MaxTotalHoursController widget.
  int? maxTotalHoursControllerValue;
  // State field(s) for TaxRateField widget.
  FocusNode? taxRateFieldFocusNode;
  TextEditingController? taxRateFieldTextController;
  String? Function(BuildContext, String?)? taxRateFieldTextControllerValidator;
  // State field(s) for ChatCloseSecField widget.
  FocusNode? chatCloseSecFieldFocusNode;
  TextEditingController? chatCloseSecFieldTextController;
  String? Function(BuildContext, String?)?
      chatCloseSecFieldTextControllerValidator;
  // State field(s) for NightSlot1Checkbox widget.
  bool? nightSlot1CheckboxValue;
  // State field(s) for NightSlot2Checkbox widget.
  bool? nightSlot2CheckboxValue;
  // State field(s) for NightSlot3Checkbox widget.
  bool? nightSlot3CheckboxValue;
  // State field(s) for NightSlot4Checkbox widget.
  bool? nightSlot4CheckboxValue;
  // State field(s) for SecurityStaffSwitch widget.
  bool? securityStaffSwitchValue;
  // State field(s) for TransportStaffSwitch widget.
  bool? transportStaffSwitchValue;
  // State field(s) for AffiliateSwitch widget.
  bool? affiliateSwitchValue;
  // State field(s) for CocotenSwitch widget.
  bool? cocotenSwitchValue;
  // State field(s) for WorkBoardSwitch widget.
  bool? workBoardSwitchValue;
  // Stores action output result for [Custom Action - adminUpdateBasicSettings] action in Button widget.
  dynamic saveBasicSettingsResult;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;
  // State field(s) for DropDown widget.
  String? dropDownValue5;
  FormFieldController<String>? dropDownValueController5;
  // State field(s) for DropDown widget.
  String? dropDownValue6;
  FormFieldController<String>? dropDownValueController6;
  // State field(s) for DropDown widget.
  String? dropDownValue7;
  FormFieldController<String>? dropDownValueController7;
  // State field(s) for DropDown widget.
  String? dropDownValue8;
  FormFieldController<String>? dropDownValueController8;
  // State field(s) for DropDown widget.
  String? dropDownValue9;
  FormFieldController<String>? dropDownValueController9;
  // State field(s) for DropDown widget.
  String? dropDownValue10;
  FormFieldController<String>? dropDownValueController10;
  // Stores action output result for [Custom Action - adminUpdateCastRewardSettings] action in Button widget.
  dynamic saveCastRewardResult;
  // State field(s) for DropDown widget.
  String? dropDownValue11;
  FormFieldController<String>? dropDownValueController11;
  // State field(s) for DropDown widget.
  String? dropDownValue12;
  FormFieldController<String>? dropDownValueController12;
  // State field(s) for DropDown widget.
  String? dropDownValue13;
  FormFieldController<String>? dropDownValueController13;
  // Stores action output result for [Custom Action - adminUpdateAffiliateSettings] action in Button widget.
  dynamic saveAffiliateResult;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // State field(s) for Switch widget.
  bool? switchValue4;
  // State field(s) for Switch widget.
  bool? switchValue5;
  // State field(s) for Switch widget.
  bool? switchValue6;
  // State field(s) for Switch widget.
  bool? switchValue7;
  // State field(s) for Switch widget.
  bool? switchValue8;
  // State field(s) for Switch widget.
  bool? switchValue9;
  // State field(s) for Switch widget.
  bool? switchValue10;
  // State field(s) for Switch widget.
  bool? switchValue11;
  // Stores action output result for [Custom Action - adminUpdateServiceAreaSettings] action in Button widget.
  dynamic saveServiceAreaResult;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // Stores action output result for [Custom Action - adminUpdateTaxiSettings] action in Button widget.
  dynamic saveTaxiResult;

  @override
  void initState(BuildContext context) {
    mainMenuCompModel = createModel(context, () => MainMenuCompModel());
  }

  @override
  void dispose() {
    mainMenuCompModel.dispose();
    tabBarController?.dispose();
    taxRateFieldFocusNode?.dispose();
    taxRateFieldTextController?.dispose();

    chatCloseSecFieldFocusNode?.dispose();
    chatCloseSecFieldTextController?.dispose();

    textFieldFocusNode1?.dispose();
    textController3?.dispose();

    textFieldFocusNode2?.dispose();
    textController4?.dispose();
  }
}
