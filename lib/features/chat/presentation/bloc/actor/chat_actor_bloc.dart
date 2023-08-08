import 'package:bloc/bloc.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/features/chat/domain/usecases/add_reaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chat_actor_bloc.freezed.dart';
part 'chat_actor_event.dart';
part 'chat_actor_state.dart';

@injectable
class ChatActorBloc extends Bloc<ChatActorEvent, ChatActorState> {
  final AddReaction _addReaction;
  ChatActorBloc(
    this._addReaction,
  ) : super(const ChatActorState.initial()) {
    on<_ReactionAdded>(_onReactionAdded);
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
}
