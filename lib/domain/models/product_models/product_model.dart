import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 2)
class ProductModels extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  num discountPercentage;
  @HiveField(4)
  num price;
  @HiveField(5)
  num rating;
  @HiveField(6)
  String shippingInformation;
  @HiveField(7)
  List<dynamic> images;
  @HiveField(8)
  String thumbnail;
  @HiveField(9)
  int quantity;
  @HiveField(10)
  bool isFav;

  ProductModels({
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.price,
    required this.rating,
    required this.shippingInformation,
    required this.images,
    required this.thumbnail,
    this.quantity = 0,
    this.isFav = false,
  });

  factory ProductModels.fromJson({required Map json}) {
    return ProductModels(
      description: json["description"] ?? "",
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      discountPercentage: json["discountPercentage"] ?? 0,
      price: json["price"] ?? 0,
      rating: json["rating"] ?? 0,
      shippingInformation: json["shippingInformation"] ?? "",
      // images: [],
      images: json["images"].map((e) => e).toList(),
      thumbnail: json["thumbnail"] ?? "",
    );
  }
}
