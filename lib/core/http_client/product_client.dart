import 'package:demo_ezv_app/core/http_client/base_http_client.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ProductClient extends BaseHttpClient {
  ProductClient() : super(baseUrl: 'https://dummyjson.com');
}
