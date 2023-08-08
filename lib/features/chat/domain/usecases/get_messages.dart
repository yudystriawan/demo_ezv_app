import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/chat/domain/entities/entity.dart';
import 'package:demo_ezv_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';

@injectable
class GetMessages implements Usecase<KtList<Chat>, GetMessagesParams> {
  final ChatRepository _repository;

  GetMessages(this._repository);
  @override
  Future<Either<Failure, KtList<Chat>>> call(params) async {
    return await _repository.getMessages(params.roomId);
  }
}

class GetMessagesParams extends Equatable {
  final String roomId;

  const GetMessagesParams(this.roomId);

  @override
  List<Object> get props => [roomId];
}
