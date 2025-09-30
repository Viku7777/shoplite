import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';

part 'cart_fav_item_model.g.dart';

@HiveType(typeId: 3)
class CartFavItemModel extends HiveObject {
  @HiveField(0)
  ProductModels productModel;
  @HiveField(1)
  int quantity;
  @HiveField(2)
  bool isFav;
  @HiveField(3)
  String id;

  CartFavItemModel(this.productModel, this.quantity, this.isFav, this.id);
}
