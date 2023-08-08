import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddReaction implements Usecase<Unit, AddReactionParams> {
  final ChatRepository _repository;

  AddReaction(this._repository);
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _repository.addReaction(
      chatId: params.chatId,
      reaction: params.reaction,
    );
  }
}

class AddReactionParams extends Equatable {
  final String chatId;
  final String reaction;

  const AddReactionParams({
    required this.chatId,
    required this.reaction,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
