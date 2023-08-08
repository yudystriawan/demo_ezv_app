part of 'chat_actor_bloc.dart';

@freezed
class ChatActorState with _$ChatActorState {
  const factory ChatActorState.initial() = _Initial;
  const factory ChatActorState.actionInProgress() = _ActionInProgress;
  const factory ChatActorState.actionFailure(Failure failure) = _ActionFailure;
  const factory ChatActorState.addReactionSuccess() = _AddReactionSuccess;
}
