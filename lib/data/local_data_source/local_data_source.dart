import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/domain/models/auth_models/user_model.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/cart_fav_item_model.dart';
import 'package:shoplite/domain/models/category_model.dart/category_model.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/fav_items.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';

class LocalDataSource {
  static Future<void> initLocalDataSource() async {
    // ✅ init Hive
    await Hive.initFlutter();
    // ✅ open box (global)
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(LocalDataSource.authBox);

    Hive.registerAdapter(CategoryModelAdapter());
    await Hive.openBox<CategoryModel>(LocalDataSource.categoryBox);

    Hive.registerAdapter(ProductModelsAdapter());
    await Hive.openBox<ProductModels>(LocalDataSource.productBox);

    Hive.registerAdapter(CartFavItemModelAdapter());
    await Hive.openBox<CartFavItemModel>(LocalDataSource.cartBox);

    Hive.registerAdapter(FavItemsModelAdapter());
    await Hive.openBox<FavItemsModel>(LocalDataSource.favItemBox);
  }

  // box names

  static final String authBox = "authBox";
  static final String categoryBox = "categoryBox";
  static final String productBox = "productBox";
  static final String cartBox = "cartBox";
  static final String favItemBox = "favItemBox";
}
