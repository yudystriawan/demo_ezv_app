import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/features/products/presentation/widgets/list_favorite_products.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProductFavoritePage extends StatelessWidget {
  const ProductFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListFavoriteProductWidget(),
    );
  }
}
