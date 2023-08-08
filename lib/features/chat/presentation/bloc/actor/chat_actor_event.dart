part of 'chat_actor_bloc.dart';

@freezed
class ChatActorEvent with _$ChatActorEvent {
  const factory ChatActorEvent.reactionAdded({
    required String chatId,
    required String reaction,
  }) = _ReactionAdded;
  const factory ChatActorEvent.chatCleared() = _ChatCleared;
}
