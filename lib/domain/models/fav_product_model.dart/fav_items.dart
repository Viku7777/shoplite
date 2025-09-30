import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';

part 'fav_items.g.dart';

@HiveType(typeId: 5)
class FavItemsModel extends HiveObject {
  @HiveField(0)
  ProductModels productModel;

  @HiveField(1)
  bool isFav;
  @HiveField(2)
  String id;

  FavItemsModel(this.productModel, this.isFav, this.id);
}
