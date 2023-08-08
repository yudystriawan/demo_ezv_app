part of 'chat_loader_bloc.dart';

@freezed
class ChatLoaderEvent with _$ChatLoaderEvent {
  const factory ChatLoaderEvent.fetched(String roomId) = _Fetched;
}
