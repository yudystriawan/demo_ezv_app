import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/features/products/data/datasources/hive/query_model.dart';
import 'package:demo_ezv_app/features/products/data/datasources/product_local_datasource.dart';
import 'package:demo_ezv_app/features/products/data/models/product.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductLocalDataSource)
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final _productFavoriteBox = 'productFavoriteBox';

  Future<Box<QueryModel>> _openBox() async {
    return Hive.openBox<QueryModel>(_productFavoriteBox);
  }

  @override
  Future<void> addFavorite(ProductModel product) async {
    try {
      final box = await _openBox();
      await box.add(product.toLocal());
    } catch (e) {
      throw const Failure.unexpectedError();
    }
  }

  @override
  Future<List<ProductModel>?> fetchFavaoriteProducts() async {
    try {
      final box = await _openBox();
      final data = box.values.toList();

      final products = data.map((e) => ProductModel.fromLocal(e)).toList();

      return products;
    } catch (e) {
      throw const Failure.unexpectedError();
    }
  }

  @override
  Future<void> removeFavorite(String productId) async {
    final box = await _openBox();
    final histories = box.toMap();

    for (var history in histories.entries) {
      if (history.value.id.toString() == productId) {
        await box.delete(history.key);
      }
    }
  }
}
