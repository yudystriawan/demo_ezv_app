import 'package:dio/dio.dart';

class BaseHttpClient with DioMixin implements Dio {
  final String baseUrl;

  BaseHttpClient({
    required this.baseUrl,
  }) {
    options = options.copyWith(baseUrl: baseUrl);
    httpClientAdapter = HttpClientAdapter();
  }
}
