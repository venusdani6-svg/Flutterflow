// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

/// One chat message for the report chat-log viewer.
class ChatMessageItemStruct extends FFFirebaseStruct {
  ChatMessageItemStruct({
    /// ChatMessageItem.sender_nickname
    String? senderNickname,

    /// ChatMessageItem.text
    String? text,

    /// ChatMessageItem.created_at_display
    String? createdAtDisplay,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _senderNickname = senderNickname,
        _text = text,
        _createdAtDisplay = createdAtDisplay,
        super(firestoreUtilData);

  // "sender_nickname" field.
  String? _senderNickname;
  String get senderNickname => _senderNickname ?? '';
  set senderNickname(String? val) => _senderNickname = val;

  bool hasSenderNickname() => _senderNickname != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  // "created_at_display" field.
  String? _createdAtDisplay;
  String get createdAtDisplay => _createdAtDisplay ?? '';
  set createdAtDisplay(String? val) => _createdAtDisplay = val;

  bool hasCreatedAtDisplay() => _createdAtDisplay != null;

  static ChatMessageItemStruct fromMap(Map<String, dynamic> data) =>
      ChatMessageItemStruct(
        senderNickname: data['sender_nickname'] as String?,
        text: data['text'] as String?,
        createdAtDisplay: data['created_at_display'] as String?,
      );

  static ChatMessageItemStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatMessageItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'sender_nickname': _senderNickname,
        'text': _text,
        'created_at_display': _createdAtDisplay,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'sender_nickname': serializeParam(
          _senderNickname,
          ParamType.String,
        ),
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
        'created_at_display': serializeParam(
          _createdAtDisplay,
          ParamType.String,
        ),
      }.withoutNulls;

  static ChatMessageItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChatMessageItemStruct(
        senderNickname: deserializeParam(
          data['sender_nickname'],
          ParamType.String,
          false,
        ),
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
        createdAtDisplay: deserializeParam(
          data['created_at_display'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ChatMessageItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChatMessageItemStruct &&
        senderNickname == other.senderNickname &&
        text == other.text &&
        createdAtDisplay == other.createdAtDisplay;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([senderNickname, text, createdAtDisplay]);
}

ChatMessageItemStruct createChatMessageItemStruct({
  String? senderNickname,
  String? text,
  String? createdAtDisplay,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChatMessageItemStruct(
      senderNickname: senderNickname,
      text: text,
      createdAtDisplay: createdAtDisplay,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChatMessageItemStruct? updateChatMessageItemStruct(
  ChatMessageItemStruct? chatMessageItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chatMessageItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChatMessageItemStructData(
  Map<String, dynamic> firestoreData,
  ChatMessageItemStruct? chatMessageItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (chatMessageItem == null) {
    return;
  }
  if (chatMessageItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chatMessageItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final chatMessageItemData =
      getChatMessageItemFirestoreData(chatMessageItem, forFieldValue);
  final nestedData =
      chatMessageItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = chatMessageItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChatMessageItemFirestoreData(
  ChatMessageItemStruct? chatMessageItem, [
  bool forFieldValue = false,
]) {
  if (chatMessageItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(chatMessageItem.toMap());

  // Add any Firestore field values
  mapToFirestore(chatMessageItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChatMessageItemListFirestoreData(
  List<ChatMessageItemStruct>? chatMessageItems,
) =>
    chatMessageItems
        ?.map((e) => getChatMessageItemFirestoreData(e, true))
        .toList() ??
    [];
