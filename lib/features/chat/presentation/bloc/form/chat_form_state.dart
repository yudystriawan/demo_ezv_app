part of 'chat_form_bloc.dart';

@freezed
class ChatFormState with _$ChatFormState {
  const factory ChatFormState({
    @Default(false) bool isSending,
    required String messsage,
    required Option<Either<Failure, Unit>> failureOrSuccessFailure,
  }) = _ChatFormState;

  factory ChatFormState.initial() => ChatFormState(
        messsage: '',
        failureOrSuccessFailure: none(),
      );
}
