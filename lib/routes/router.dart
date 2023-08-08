import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        page: ProductOverviewRoute.page,
        initial: true,
      ),
      AutoRoute(
        page: ProductDetailRoute.page,
      )
    ];
  }
}
