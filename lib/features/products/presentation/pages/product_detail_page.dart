import 'package:auto_route/auto_route.dart';
import 'package:demo_ezv_app/core/helpers/number_formatter.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product/product.dart';

@RoutePage()
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Hero(
              tag: product.thumbnailUrl,
              child: Image.network(product.thumbnailUrl),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12).copyWith(bottom: 0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(product.title),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Row(
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
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Text(product.description),
            ),
          ),
        ],
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: product.urlImages.size,
          itemBuilder: (BuildContext context, int index) {
            final urlImage = product.urlImages[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black87,
              ),
              child: Image.network(
                urlImage,
              ),
            );
          },
        ),
      ),
    );
  }
}
