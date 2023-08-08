import 'package:injectable/injectable.dart';

import '../http_client/base_http_client.dart';

@module
abstract class AppModules {
  @lazySingleton
  BaseHttpClient get httpClient => BaseHttpClient();
}
