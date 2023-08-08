part of 'entity.dart';

@freezed
class Chat with _$Chat {
  const Chat._();
  const factory Chat({
    required String id,
    required String message,
    required String createdBy,
    String? reaction,
  }) = _Chat;

  bool get hasReaction => reaction != null;

  factory Chat.empty() => const Chat(id: '', message: '', createdBy: '');
}
