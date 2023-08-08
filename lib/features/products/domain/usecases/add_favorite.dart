import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/products/domain/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

import '../entities/product/product.dart';

class AddFavorite implements Usecase<Unit, AddFavoriteParams> {
  final ProductRepository _repository;

  AddFavorite(this._repository);
  @override
  Future<Either<Failure, Unit>> call(AddFavoriteParams params) async {
    return await _repository.addFavorite(params.product);
  }
}

class AddFavoriteParams extends Equatable {
  final Product product;

  const AddFavoriteParams({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}
