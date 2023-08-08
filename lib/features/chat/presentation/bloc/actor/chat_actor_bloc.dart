import 'package:bloc/bloc.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/chat/domain/usecases/add_reaction.dart';
import 'package:demo_ezv_app/features/chat/domain/usecases/clear_chat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_actor_bloc.freezed.dart';
part 'chat_actor_event.dart';
part 'chat_actor_state.dart';

@injectable
class ChatActorBloc extends Bloc<ChatActorEvent, ChatActorState> {
  final AddReaction _addReaction;
  final ClearChat _clearChat;
  ChatActorBloc(
    this._addReaction,
    this._clearChat,
  ) : super(const ChatActorState.initial()) {
    on<_ReactionAdded>(_onReactionAdded);
    on<_ChatCleared>(_onChatCleared);
  }

  void _onReactionAdded(
    _ReactionAdded event,
    Emitter<ChatActorState> emit,
  ) async {
    emit(const ChatActorState.actionInProgress());

    final failureOrSuccess = await _addReaction(AddReactionParams(
      chatId: event.chatId,
      reaction: event.reaction,
    ));

    emit(failureOrSuccess.fold(
      (f) => ChatActorState.actionFailure(f),
      (_) => const ChatActorState.addReactionSuccess(),
    ));
  }

  void _onChatCleared(
    _ChatCleared event,
    Emitter<ChatActorState> emit,
  ) async {
    emit(const ChatActorState.actionInProgress());

    final failureOrSuccess = await _clearChat(const NoParams());

    emit(failureOrSuccess.fold(
      (f) => ChatActorState.actionFailure(f),
      (_) => const ChatActorState.clearSuccess(),
    ));
  }
}
