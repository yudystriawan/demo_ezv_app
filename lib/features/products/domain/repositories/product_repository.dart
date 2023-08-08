import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:kt_dart/collection.dart';

import '../entities/product/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, KtList<Product>>> getProducts();
  Future<Either<Failure, KtList<Product>>> getFavoriteProducts();
  Future<Either<Failure, Unit>> addFavorite(Product product);
}
