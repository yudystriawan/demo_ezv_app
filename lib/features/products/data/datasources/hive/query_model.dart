import 'package:hive/hive.dart';

part 'query_model.g.dart';

@HiveType(typeId: 1)
class QueryModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  double? price;
  @HiveField(4)
  double? discountPercentage;
  @HiveField(5)
  double? rating;
  @HiveField(6)
  double? stock;
  @HiveField(7)
  String? brand;
  @HiveField(8)
  String? category;
  @HiveField(9)
  String? thumbnail;
  @HiveField(10)
  List<String>? images;

  QueryModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });
}
