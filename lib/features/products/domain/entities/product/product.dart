import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  factory Product({
    required String id,
    required String title,
    required String description,
    required double price,
    required double discountPercentage,
    required double rating,
    required double stock,
    required String brand,
    required String category,
    required String thumbnailUrl,
    required KtList<String> urlImages,
  }) = _Product;

  factory Product.empty() => Product(
        id: '',
        title: '',
        description: '',
        price: 0,
        discountPercentage: 0,
        rating: 0,
        stock: 0,
        brand: '',
        category: '',
        thumbnailUrl: '',
        urlImages: const KtList.empty(),
      );
}
