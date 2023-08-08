import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/features/products/presentation/bloc/loader/product_loader_bloc.dart';
import 'package:demo_ezv_app/features/products/presentation/widgets/list_products.dart';
import 'package:demo_ezv_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductOverviewPage extends StatelessWidget implements AutoRouteWrapper {
  const ProductOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ListProductWidget(),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProductLoaderBloc>()..add(const ProductLoaderEvent.fetched()),
      child: this,
    );
  }
}
