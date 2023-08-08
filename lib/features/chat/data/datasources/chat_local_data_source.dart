import 'package:demo_ezv_app/features/chat/data/models/model.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatModel>?> getMessages(String roomId);
  Future<void> addReaction({
    required String chatId,
    required String reaction,
  });
  Future<void> insert(ChatModel chat);
  Future<void> clear();
}
