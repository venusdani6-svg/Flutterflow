import '/flutter_flow/flutter_flow_util.dart';
import 'profile_edit_dialog_comp_widget.dart' show ProfileEditDialogCompWidget;
import 'package:flutter/material.dart';

class ProfileEditDialogCompModel
    extends FlutterFlowModel<ProfileEditDialogCompWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for SelfIntroductionField widget.
  FocusNode? selfIntroductionFieldFocusNode;
  TextEditingController? selfIntroductionFieldTextController;
  String? Function(BuildContext, String?)?
      selfIntroductionFieldTextControllerValidator;
  // State field(s) for ProfileEditReasonField widget.
  FocusNode? profileEditReasonFieldFocusNode;
  TextEditingController? profileEditReasonFieldTextController;
  String? Function(BuildContext, String?)?
      profileEditReasonFieldTextControllerValidator;
  // Stores action output result for [Custom Action - profileEditHasChanges] action in SaveProfileEditButton widget.
  bool? profileEditHasChangesResult;
  // Stores action output result for [Custom Action - adminUpdateUserProfile] action in SaveProfileEditButton widget.
  dynamic updateProfileResult;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    selfIntroductionFieldFocusNode?.dispose();
    selfIntroductionFieldTextController?.dispose();

    profileEditReasonFieldFocusNode?.dispose();
    profileEditReasonFieldTextController?.dispose();
  }
}
