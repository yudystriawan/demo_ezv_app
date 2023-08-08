import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearChat implements Usecase<Unit, NoParams> {
  final ChatRepository _repository;

  ClearChat(this._repository);
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await _repository.clearLocal();
  }
}
