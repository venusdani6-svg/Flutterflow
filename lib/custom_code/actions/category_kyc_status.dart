// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String categoryKycStatus(String? category, String? kycLabel) {
  if (category != 'KYC状態') return '';
  switch (kycLabel) {
    case '未提出':
      return 'pending';
    case '審査中':
      return 'submitted';
    case '承認済み':
      return 'approved';
    case '却下':
      return 'rejected';
    default:
      return '';
  }
}
