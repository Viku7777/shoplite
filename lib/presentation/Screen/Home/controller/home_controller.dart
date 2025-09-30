// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/domain/models/category_model.dart/category_model.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/domain/repositories/home_repo/home_repo.dart';
import 'package:shoplite/utils/di_injections.dart';
import 'package:shoplite/utils/toasts/app_toast.dart';
import 'dart:developer';

final homeStateProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState(categories: [], products: [], search: []));

  var homeRepo = sI<HomeRepo>();

  Future<void> getCategories({
    required BuildContext context,
    required Box<CategoryModel> box,
    bool showError = true,
  }) async {
    state = state.copyWith(loading: true);

    await homeRepo
        .getCategories()
        .then((e) async {
          await box.clear();
          await box.addAll(e);
          state = state.copyWith(categories: e, loading: false);
        })
        .catchError((e) {
          if (showError) {
            AppToast.simpleToast(context: context, message: e.toString());
          }
          state = state.copyWith(
            loading: false,
            categories: box.values.toList(),
          );
          throw "";
        });
  }

  Future<void> getProducts({
    required BuildContext context,
    required Box<ProductModels> box,
    bool clearOldItems = true,
    int index = 0,
  }) async {
    state = state.copyWith(loading: true);
    log("call API => $index");
    await homeRepo
        .getProducts(index: index)
        .then((e) async {
          if (clearOldItems) {
            await box.clear();
          }
          await box.addAll(e);
          state = state.copyWith(products: e, loading: false);
        })
        .catchError((e) {
          AppToast.simpleToast(context: context, message: e.toString());
          state = state.copyWith(loading: false, products: box.values.toList());
        });
  }

  Future<void> getProductViaSearch({
    required BuildContext context,
    required String query,
  }) async {
    state = state.copyWith(loading: true);
    await homeRepo
        .productSearch(query: query)
        .then((e) async {
          log(e.length.toString());
          state = state.copyWith(search: e, loading: false);
        })
        .catchError((e) {
          AppToast.simpleToast(context: context, message: e.toString());
          state = state.copyWith(loading: false);
        });
  }

  Future<void> clearSearchTime() async {
    state = state.copyWith(search: []);
  }
}

class HomeState {
  List<CategoryModel> categories;
  List<ProductModels> products;
  List<ProductModels> search;

  bool isloading;
  HomeState({
    required this.categories,
    required this.products,
    required this.search,
    this.isloading = false,
  });

  copyWith({
    List<CategoryModel>? categories,
    List<ProductModels>? products,
    List<ProductModels>? search,
    bool? loading,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isloading: loading ?? isloading,
      products: products ?? this.products,
      search: search ?? this.search,
    );
  }
}
