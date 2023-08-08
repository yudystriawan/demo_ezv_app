import 'package:dartz/dartz.dart';
import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/features/products/data/datasources/product_local_datasource.dart';
import 'package:demo_ezv_app/features/products/data/datasources/product_remote_datasource.dart';
import 'package:demo_ezv_app/features/products/data/models/product.dart';
import 'package:demo_ezv_app/features/products/domain/entities/product/product.dart';
import 'package:demo_ezv_app/features/products/domain/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  ProductRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

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
  Future<Either<Failure, Unit>> addFavorite(Product product) async {
    try {
      final model = ProductModel.fromDomain(product);
      await _localDataSource.addFavorite(model);
      return right(unit);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(const Failure.unexpectedError());
    }
  }

  @override
  Future<Either<Failure, KtList<Product>>> getFavoriteProducts() async {
    try {
      final result = await _localDataSource.fetchFavaoriteProducts();

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
  Future<Either<Failure, Unit>> removeFavorite(String productId) async {
    try {
      await _localDataSource.removeFavorite(productId);
      return right(unit);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(const Failure.unexpectedError());
    }
  }
}
