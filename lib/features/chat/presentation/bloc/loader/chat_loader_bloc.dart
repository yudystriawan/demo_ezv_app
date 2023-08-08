import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/features/chat/domain/usecases/get_messages.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/entity.dart';

part 'chat_loader_bloc.freezed.dart';
part 'chat_loader_event.dart';
part 'chat_loader_state.dart';

@injectable
class ChatLoaderBloc extends Bloc<ChatLoaderEvent, ChatLoaderState> {
  final GetMessages _getMessages;
  ChatLoaderBloc(
    this._getMessages,
  ) : super(ChatLoaderState.initial()) {
    on<_Fetched>(_onFetched);
  }

  void _onFetched(
    _Fetched event,
    Emitter<ChatLoaderState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      failureOption: none(),
    ));

    final failureOrSuccess =
        await _getMessages(GetMessagesParams(event.roomId));

    emit(failureOrSuccess.fold(
      (f) => state.copyWith(isLoading: false, failureOption: optionOf(f)),
      (messages) => state.copyWith(isLoading: false, messages: messages),
    ));
  }
}
