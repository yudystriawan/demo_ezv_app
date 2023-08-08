import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateMessage implements Usecase<Unit, CreateMessageParams> {
  final ChatRepository _chatRepository;

  CreateMessage(this._chatRepository);
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _chatRepository.create(
      roomId: params.roomId,
      message: params.message,
    );
  }
}

class CreateMessageParams extends Equatable {
  final String roomId;
  final String message;

  const CreateMessageParams({
    required this.roomId,
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
