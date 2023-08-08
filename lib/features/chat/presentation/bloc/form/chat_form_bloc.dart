import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/features/chat/domain/usecases/create_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failure.dart';

part 'chat_form_bloc.freezed.dart';
part 'chat_form_event.dart';
part 'chat_form_state.dart';

@injectable
class ChatFormBloc extends Bloc<ChatFormEvent, ChatFormState> {
  final CreateMessage _createMessage;

  ChatFormBloc(
    this._createMessage,
  ) : super(ChatFormState.initial()) {
    on<_MessageChanged>(_onMessageChanged);
    on<_Submitted>(_onSubmitted);
  }

  void _onMessageChanged(
    _MessageChanged event,
    Emitter<ChatFormState> emit,
  ) async {
    emit(state.copyWith(messsage: event.message));
  }

  void _onSubmitted(
    _Submitted event,
    Emitter<ChatFormState> emit,
  ) async {
    emit(state.copyWith(
      isSending: true,
      failureOrSuccessFailure: none(),
    ));

    final failureOrSuccess = await _createMessage(
      CreateMessageParams(
        roomId: event.roomId,
        message: state.messsage,
      ),
    );

    emit(state.copyWith(
      failureOrSuccessFailure: optionOf(failureOrSuccess),
    ));
  }
}
