import 'package:demo_ezv_app/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:demo_ezv_app/features/chat/data/models/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/errors/failure.dart';
import 'query_model.dart' as local;

@Injectable(as: ChatLocalDataSource)
class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final _messageBox = 'messageBox';
  final _roomBox = 'roomBox';

  Future<Box<local.ChatModel>> _openChatBox() async {
    return Hive.openBox<local.ChatModel>(_messageBox);
  }

  Future<Box<local.RoomChatModel>> _openRoomChatBox() async {
    return Hive.openBox<local.RoomChatModel>(_roomBox);
  }

  @override
  Future<void> addReaction({required String chatId, required String reaction}) {
    // TODO: implement addReaction
    throw UnimplementedError();
  }

  @override
  Future<List<ChatModel>?> getMessages(String roomId) async {
    try {
      final box = await _openChatBox();

      final data = box.values.toList();

      final filteredData =
          data.where((element) => element.roomId == roomId).toList();

      final messages = filteredData.map((e) => ChatModel.fromLocal(e)).toList();

      return messages;
    } catch (e) {
      throw const Failure.unexpectedError();
    }
  }

  @override
  Future<void> insert(ChatModel chat) async {
    try {
      final box = await _openChatBox();

      await box.add(chat.toLocal());

      // add bot message
      final botChat = ChatModel(
        id: const Uuid().v4(),
        roomId: chat.roomId,
        message: 'this is a bot message',
        createdBy: 'bot',
      );
      await box.add(botChat.toLocal());
    } catch (e) {
      throw const Failure.unexpectedError();
    }
  }
}
