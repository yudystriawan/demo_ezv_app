import 'package:demo_ezv_app/features/products/domain/entities/product/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();
  factory ProductModel({
    int? id,
    String? title,
    String? description,
    double? price,
    double? discountPercentage,
    double? rating,
    double? stock,
    String? brand,
    String? category,
    String? thumbnail,
    List<String>? images,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  factory ProductModel.fromDomain(Product entity) {
    return ProductModel(
      id: int.tryParse(entity.id),
      title: entity.title,
      description: entity.description,
      price: entity.price,
      discountPercentage: entity.discountPercentage,
      rating: entity.rating,
      stock: entity.stock,
      brand: entity.brand,
      category: entity.category,
      thumbnail: entity.thumbnailUrl,
      images: entity.urlImages.iter.map((urlImage) => urlImage).toList(),
    );
  }

  Product toDomain() {
    final empty = Product.empty();

    return Product(
      id: id.toString(),
      title: title ?? empty.title,
      description: description ?? empty.description,
      price: price ?? empty.price,
      discountPercentage: discountPercentage ?? empty.discountPercentage,
      rating: rating ?? empty.rating,
      stock: stock ?? empty.stock,
      brand: brand ?? empty.brand,
      category: category ?? empty.category,
      thumbnailUrl: thumbnail ?? empty.thumbnailUrl,
      urlImages: images?.toImmutableList() ?? empty.urlImages,
    );
  }
}
