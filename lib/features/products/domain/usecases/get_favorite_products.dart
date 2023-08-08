import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/usecases/usecase.dart';
import 'package:demo_ezv_app/features/products/domain/repositories/product_repository.dart';
import 'package:kt_dart/collection.dart';

import '../entities/product/product.dart';

class GetFavoriteProducts implements Usecase<KtList<Product>, NoParams> {
  final ProductRepository _repository;

  GetFavoriteProducts(this._repository);
  @override
  Future<Either<Failure, KtList<Product>>> call(NoParams params) async {
    return await _repository.getFavoriteProducts();
  }
}
