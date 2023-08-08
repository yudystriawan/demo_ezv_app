part of 'model.dart';

@freezed
class ChatModel with _$ChatModel {
  const ChatModel._();
  const factory ChatModel({
    String? id,
    String? roomId,
    String? message,
    String? createdBy,
    String? reaction,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  factory ChatModel.fromLocal(local.ChatModel model) {
    return ChatModel(
      id: model.id,
      roomId: model.roomId,
      message: model.message,
      createdBy: model.createdBy,
      reaction: model.reaction,
    );
  }

  local.ChatModel toLocal() {
    return local.ChatModel(
      id: id,
      roomId: roomId,
      message: message,
      createdBy: createdBy,
      reaction: reaction,
    );
  }

  Chat toDomain() {
    final empty = Chat.empty();
    return Chat(
      id: id ?? empty.id,
      message: message ?? empty.message,
      createdBy: createdBy ?? empty.createdBy,
      reaction: reaction ?? empty.reaction,
    );
  }
}
