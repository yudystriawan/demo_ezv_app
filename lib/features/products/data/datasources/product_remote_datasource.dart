import 'package:demo_ezv_app/core/errors/failure.dart';
import 'package:demo_ezv_app/core/http_client/api_path.dart';
import 'package:demo_ezv_app/core/http_client/product_client.dart';
import 'package:demo_ezv_app/features/products/data/models/product.dart';
import 'package:dio/dio.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>?> fetchProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ProductClient _client;

  ProductRemoteDataSourceImpl(this._client);

  @override
  Future<List<ProductModel>?> fetchProducts() async {
    try {
      final response = await _client.get(ApiPath.products);

      if (response.statusCode != 200) {
        throw Failure.serverError(
          code: response.statusCode,
          message: response.statusMessage,
        );
      }

      final data = response.data['products'] as List;
      final products = data.map((json) => ProductModel.fromJson(json)).toList();

      return products;
    } on DioException catch (e) {
      throw Failure.serverError(
        message: e.response?.statusMessage,
        code: e.response?.statusCode,
      );
    } catch (e) {
      throw const Failure.unexpectedError();
    }
  }
}
