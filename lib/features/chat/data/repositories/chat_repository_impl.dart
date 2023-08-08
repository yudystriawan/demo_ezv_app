import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:demo_ezv_app/features/chat/domain/entities/entity.dart';
import 'package:demo_ezv_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:uuid/uuid.dart';

import '../models/model.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource _localDataSource;

  ChatRepositoryImpl(this._localDataSource);
  @override
  Future<Either<Failure, Unit>> addReaction({
    required String chatId,
    required String reaction,
  }) {
    // TODO: implement addReaction
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> create({
    required String roomId,
    required String message,
  }) async {
    try {
      final chatModel = ChatModel(
        id: const Uuid().v4(),
        roomId: roomId,
        message: message,
        createdBy: 'me',
      );
      await _localDataSource.insert(chatModel);
      return right(unit);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(const Failure.unexpectedError());
    }
  }

  @override
  Future<Either<Failure, KtList<Chat>>> getMessages(String roomId) async {
    try {
      final result = await _localDataSource.getMessages(roomId);

      if (result == null) return right(const KtList.empty());

      final messages = result.map((e) => e.toDomain()).toImmutableList();

      return right(messages);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(const Failure.unexpectedError());
    }
  }
}
