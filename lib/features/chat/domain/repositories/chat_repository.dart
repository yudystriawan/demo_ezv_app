import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

import '../../../../core/errors/failure.dart';
import '../entities/entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Unit>> create({
    required String roomId,
    required String message,
  });
  Future<Either<Failure, Unit>> addReaction({
    required String chatId,
    required String reaction,
  });
  Future<Either<Failure, KtList<Chat>>> getMessages(String roomId);
}
