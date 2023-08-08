import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/features/products/presentation/widgets/list_products.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ListProductWidget(),
      ),
    );
  }
}
