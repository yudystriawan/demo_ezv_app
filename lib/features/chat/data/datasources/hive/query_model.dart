import 'package:hive/hive.dart';

part 'query_model.g.dart';

@HiveType(typeId: 2)
class ChatModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? roomId;

  @HiveField(2)
  String? message;

  @HiveField(3)
  String? reaction;

  @HiveField(4)
  String? createdBy;

  ChatModel({
    this.id,
    this.roomId,
    this.message,
    this.reaction,
    this.createdBy,
  });
}

@HiveType(typeId: 3)
class RoomChatModel extends HiveObject {
  @HiveField(0)
  String? id;

  RoomChatModel({
    this.id,
  });
}
