import 'package:demo_ezv_app/features/products/data/models/product.dart';

abstract class ProductLocalDataSource {
  Future<void> addFavorite(ProductModel product);
  Future<void> removeFavorite(String productId);
  Future<List<ProductModel>?> fetchFavaoriteProducts();
}
