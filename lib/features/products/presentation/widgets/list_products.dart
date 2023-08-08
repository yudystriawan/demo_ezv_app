import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/core/helpers/number_formatter.dart';
import 'package:demo_ezv_app/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../bloc/loader/product_loader_bloc.dart';

class ListProductWidget extends StatelessWidget {
  const ListProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductLoaderBloc, ProductLoaderState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => const SizedBox(),
          loadFailure: (_) => const Center(
            child: Text('error'),
          ),
          loadInProgress: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          loadSuccess: (value) {
            final products = value.products;
            return MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: products.size,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () =>
                      context.pushRoute(ProductDetailRoute(product: product)),
                  behavior: HitTestBehavior.opaque,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          15), // Set card's rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Column(
                        children: [
                          Hero(
                            tag: product.thumbnailUrl,
                            child: Image.network(product.thumbnailUrl),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            child: Column(
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
                                          product.discountedPrice
                                              .toCurrencyFormatted(),
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
