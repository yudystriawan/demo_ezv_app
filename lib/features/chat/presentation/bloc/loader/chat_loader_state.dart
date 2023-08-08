part of 'chat_loader_bloc.dart';

@freezed
class ChatLoaderState with _$ChatLoaderState {
  const factory ChatLoaderState({
    required Option<Failure> failureOption,
    required KtList<Chat> messages,
    @Default(false) bool isLoading,
  }) = _ChatLoaderState;

  factory ChatLoaderState.initial() => ChatLoaderState(
        failureOption: none(),
        messages: const KtList.empty(),
      );
}
