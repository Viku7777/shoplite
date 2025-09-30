import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String slug;
  @HiveField(1)
  String name;
  @HiveField(2)
  String url;

  CategoryModel(this.slug, this.name, this.url);

  factory CategoryModel.fromJson({required Map json}) {
    return CategoryModel(
      json["slug"] ?? "",
      json["name"] ?? "",
      json["url"] ?? "",
    );
  }
}
