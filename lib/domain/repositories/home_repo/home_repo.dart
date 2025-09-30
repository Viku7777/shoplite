import 'dart:convert';

import 'package:shoplite/data/network/exceptions.dart';
import 'package:shoplite/data/network/network_api_services.dart';
import 'package:shoplite/domain/models/category_model.dart/category_model.dart';
import 'package:shoplite/domain/models/product_models/product_model.dart';
import 'package:shoplite/utils/const/app_urls.dart';
import 'package:shoplite/utils/di_injections.dart';

class HomeRepo {
  NetworkApiServices networkApiServices = sI<NetworkApiServices>();

  Future<List<CategoryModel>> getCategories() async {
    try {
      var data = await networkApiServices.getApi(
        url: "${AppUrls.baseUrl}${AppUrls.categories}",
      );
      return (data as List)
          .map((e) => CategoryModel.fromJson(json: e))
          .toList();
    } catch (e) {
      if (e is OtherException) {
        Map error = jsonDecode(e.toString());
        throw (error["message"]);
      } else {
        throw e.toString();
      }
    }
  }

  Future<List<ProductModels>> getProducts({int index = 0}) async {
    try {
      var data = await networkApiServices.getApi(
        url: "${AppUrls.baseUrl}${AppUrls.products}$index",
      );

      return (data["products"] as List)
          .map((e) => ProductModels.fromJson(json: e))
          .toList();
    } catch (e) {
      if (e is OtherException) {
        Map error = jsonDecode(e.toString());
        throw (error["message"]);
      } else {
        throw e.toString();
      }
    }
  }

  Future<List<ProductModels>> productSearch({required String query}) async {
    try {
      var data = await networkApiServices.getApi(
        url: "${AppUrls.baseUrl}${AppUrls.productsSearchApi}$query",
      );

      return (data["products"] as List)
          .map((e) => ProductModels.fromJson(json: e))
          .toList();
    } catch (e) {
      if (e is OtherException) {
        Map error = jsonDecode(e.toString());
        throw (error["message"]);
      } else {
        throw e.toString();
      }
    }
  }
}


// https://dummyjson.com/products?limit=20&skip=10