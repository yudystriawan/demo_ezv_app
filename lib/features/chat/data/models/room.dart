part of 'model.dart';

@freezed
class ChatRoomModel with _$ChatRoomModel {
  const ChatRoomModel._();
  const factory ChatRoomModel({
    String? id,
    List<ChatModel>? messages,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}
