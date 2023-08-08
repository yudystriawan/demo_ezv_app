part of 'chat_form_bloc.dart';

@freezed
class ChatFormEvent with _$ChatFormEvent {
  const factory ChatFormEvent.messageChanged(String message) = _MessageChanged;
  const factory ChatFormEvent.submitted(String roomId) = _Submitted;
}
