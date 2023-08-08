import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:demo_ezv_app/features/products/domain/entities/product/product.dart';
import 'package:demo_ezv_app/features/products/domain/repositories/product_repository.dart';
import 'package:kt_dart/collection.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, KtList<Product>>> getProducts() async {
    try {
      final result = await _remoteDataSource.fetchProducts();

      if (result == null) return right(const KtList.empty());

      final products = result.map((e) => e.toDomain()).toImmutableList();

      return right(products);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(const Failure.unexpectedError());
    }
  }

  @override
  Future<Either<Failure, Unit>> addFavorite(Product product) {
    // TODO: implement addFavorite
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, KtList<Product>>> getFavoriteProducts() {
    // TODO: implement getFavoriteProducts
    throw UnimplementedError();
  }
}
