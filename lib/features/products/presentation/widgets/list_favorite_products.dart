import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/core/helpers/number_formatter.dart';
import 'package:demo_ezv_app/features/products/domain/entities/product/product.dart';
import 'package:demo_ezv_app/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_actor/product_actor_bloc.dart';
import '../bloc/loader/product_loader_bloc.dart';

class ListFavoriteProductWidget extends StatelessWidget {
  const ListFavoriteProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductLoaderBloc, ProductLoaderState>(
      buildWhen: (p, c) => p.isLoading != c.isLoading,
      builder: (context, state) {
        final products = state.favoriteProducts;
        return ListView.separated(
          itemCount: products.size,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 12,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];
            return ProductItemWidget(product: product);
          },
        );
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(ProductDetailRoute(product: product)),
      behavior: HitTestBehavior.opaque,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Set card's rounded corners
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 150,
                    child: Image.network(
                      product.thumbnailUrl,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<ProductActorBloc>()
                            .add(ProductActorEvent.productRemoved(product.id));
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            product.price.toCurrencyFormatted(),
                            style: TextStyle(
                              decoration: product.hasDiscount
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          if (product.hasDiscount) ...[
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                product.discountedPrice.toCurrencyFormatted(),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
