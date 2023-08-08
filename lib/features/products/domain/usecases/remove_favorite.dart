import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/products/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveFavorite implements Usecase<Unit, RemoveFavoriteParams> {
  final ProductRepository _repository;

  RemoveFavorite(this._repository);
  @override
  Future<Either<Failure, Unit>> call(RemoveFavoriteParams params) async {
    return await _repository.removeFavorite(params.productId);
  }
}

class RemoveFavoriteParams extends Equatable {
  final String productId;

  const RemoveFavoriteParams({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}
