part of 'entity.dart';

@freezed
class ChatRoom with _$ChatRoom {
  const ChatRoom._();
  const factory ChatRoom({
    required String id,
    required KtList<Chat> messages,
  }) = _ChatRoom;
}
