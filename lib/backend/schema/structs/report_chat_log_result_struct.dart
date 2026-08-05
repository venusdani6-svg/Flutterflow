// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Combined result of adminGetReportChatLog.
class ReportChatLogResultStruct extends FFFirebaseStruct {
  ReportChatLogResultStruct({
    /// ReportChatLogResult.messages
    List<ChatMessageItemStruct>? messages,

    /// ReportChatLogResult.noChatReason
    String? noChatReason,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _messages = messages,
        _noChatReason = noChatReason,
        super(firestoreUtilData);

  // "messages" field.
  List<ChatMessageItemStruct>? _messages;
  List<ChatMessageItemStruct> get messages => _messages ?? const [];
  set messages(List<ChatMessageItemStruct>? val) => _messages = val;

  void updateMessages(Function(List<ChatMessageItemStruct>) updateFn) {
    updateFn(_messages ??= []);
  }

  bool hasMessages() => _messages != null;

  // "noChatReason" field.
  String? _noChatReason;
  String get noChatReason => _noChatReason ?? '';
  set noChatReason(String? val) => _noChatReason = val;

  bool hasNoChatReason() => _noChatReason != null;

  static ReportChatLogResultStruct fromMap(Map<String, dynamic> data) =>
      ReportChatLogResultStruct(
        messages: getStructList(
          data['messages'],
          ChatMessageItemStruct.fromMap,
        ),
        noChatReason: data['noChatReason'] as String?,
      );

  static ReportChatLogResultStruct? maybeFromMap(dynamic data) => data is Map
      ? ReportChatLogResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'messages': _messages?.map((e) => e.toMap()).toList(),
        'noChatReason': _noChatReason,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'messages': serializeParam(
          _messages,
          ParamType.DataStruct,
          isList: true,
        ),
        'noChatReason': serializeParam(
          _noChatReason,
          ParamType.String,
        ),
      }.withoutNulls;

  static ReportChatLogResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ReportChatLogResultStruct(
        messages: deserializeStructParam<ChatMessageItemStruct>(
          data['messages'],
          ParamType.DataStruct,
          true,
          structBuilder: ChatMessageItemStruct.fromSerializableMap,
        ),
        noChatReason: deserializeParam(
          data['noChatReason'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ReportChatLogResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ReportChatLogResultStruct &&
        listEquality.equals(messages, other.messages) &&
        noChatReason == other.noChatReason;
  }

  @override
  int get hashCode => const ListEquality().hash([messages, noChatReason]);
}

ReportChatLogResultStruct createReportChatLogResultStruct({
  String? noChatReason,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ReportChatLogResultStruct(
      noChatReason: noChatReason,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ReportChatLogResultStruct? updateReportChatLogResultStruct(
  ReportChatLogResultStruct? reportChatLogResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    reportChatLogResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addReportChatLogResultStructData(
  Map<String, dynamic> firestoreData,
  ReportChatLogResultStruct? reportChatLogResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (reportChatLogResult == null) {
    return;
  }
  if (reportChatLogResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && reportChatLogResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final reportChatLogResultData =
      getReportChatLogResultFirestoreData(reportChatLogResult, forFieldValue);
  final nestedData =
      reportChatLogResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      reportChatLogResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getReportChatLogResultFirestoreData(
  ReportChatLogResultStruct? reportChatLogResult, [
  bool forFieldValue = false,
]) {
  if (reportChatLogResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(reportChatLogResult.toMap());

  // Add any Firestore field values
  mapToFirestore(reportChatLogResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getReportChatLogResultListFirestoreData(
  List<ReportChatLogResultStruct>? reportChatLogResults,
) =>
    reportChatLogResults
        ?.map((e) => getReportChatLogResultFirestoreData(e, true))
        .toList() ??
    [];
