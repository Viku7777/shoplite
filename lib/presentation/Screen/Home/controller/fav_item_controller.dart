import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shoplite/data/local_data_source/local_data_source.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/cart_fav_item_model.dart';
import 'package:shoplite/domain/models/fav_product_model.dart/fav_items.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/utils/toasts/app_toast.dart';
import 'package:toastification/toastification.dart';

final favItemProvider = StateNotifierProvider<FavItemNotifier, FavItemState>((
  ref,
) {
  return FavItemNotifier();
});

Box<CartFavItemModel> get cartBox =>
    Hive.box<CartFavItemModel>(LocalDataSource.cartBox);
Box<FavItemsModel> get favItemBox =>
    Hive.box<FavItemsModel>(LocalDataSource.favItemBox);

class FavItemNotifier extends StateNotifier<FavItemState> {
  FavItemNotifier() : super(FavItemState([]));

  void addFav(ProductModels newItem) {
    List<ProductModels> favItems = state.favItems;
    if (favItems.any((e) => e.id == newItem.id)) {
      favItems.removeWhere((e) => e.id == newItem.id);
    } else {
      favItems.add(newItem);
    }
    List<FavItemsModel> storedData = favItemBox.values.toList();
    if (storedData.any((e) => e.id == newItem.id.toString())) {
      int index = storedData.indexWhere((e) => e.id == newItem.id.toString());
      storedData[index].isFav = !storedData[index].isFav;
      favItemBox.deleteAt(index);
    } else {
      newItem.isFav = true;
      favItemBox.add(FavItemsModel(newItem, true, newItem.id.toString()));
    }

    state = state.updateList(favItems);
  }

  void addItemToCart(ProductModels newItem, BuildContext context) {
    List<CartFavItemModel> storedData = cartBox.values.toList();
    if (storedData.any((e) => e.id == newItem.id.toString())) {
      AppToast.simpleToast(
        context: context,
        message: "This item is already Added in your cart",
        type: ToastificationType.error,
      );
      // int index = storedData.indexWhere((e) => e.id == newItem.id.toString());
      // storedData[index].isFav = !storedData[index].isFav;
      // cartBox.deleteAt(index);
    } else {
      cartBox.add(CartFavItemModel(newItem, 1, true, newItem.id.toString()));
      AppToast.simpleToast(
        context: context,
        message: "Item Added in your cart",
        type: ToastificationType.success,
        title: "Success",
      );
    }
  }

  void increaseQuantity(CartFavItemModel item) {
    int index = cartBox.values.toList().indexWhere((e) => e.id == item.id);
    CartFavItemModel item2 = item;
    item2.quantity += 1;
    cartBox.values.toList()[index] = item2;
    // cartBox.deleteAt(index);
    // cartBox.add(item2);
  }

  void decreareQuantity(CartFavItemModel item) {
    int index = cartBox.values.toList().indexWhere((e) => e.id == item.id);
    CartFavItemModel item2 = item;
    item2.quantity -= 1;
    cartBox.deleteAt(index);
    cartBox.add(item2);
  }

  void deleteProduct(CartFavItemModel item) {
    int index = cartBox.values.toList().indexWhere((e) => e.id == item.id);
    cartBox.deleteAt(index);
  }

  void updateList() {
    state = state.updateList(
      favItemBox.values.map((e) => e.productModel).toList(),
    );
  }
}

class FavItemState {
  List<ProductModels> favItems;
  FavItemState(this.favItems);

  FavItemState updateList(List<ProductModels> newItems) {
    return FavItemState(newItems);
  }
}
