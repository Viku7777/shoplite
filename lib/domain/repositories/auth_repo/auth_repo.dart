import 'dart:convert';

import 'package:shoplite/data/network/exceptions.dart';
import 'package:shoplite/data/network/network_api_services.dart';
import 'package:shoplite/domain/models/auth_models/login_model.dart';
import 'package:shoplite/utils/const/app_urls.dart';
import 'package:shoplite/utils/di_injections.dart';

class AuthRepo {
  NetworkApiServices networkApiServices = sI<NetworkApiServices>();

  Future<dynamic> login({
    required String username,
    required String password,
  }) async {
    try {
      LoginModel loginDetails = LoginModel(
        username: username,
        password: password,
      );
      var data = await networkApiServices.postApi(
        url: "${AppUrls.baseUrl}${AppUrls.login}",
        body: loginDetails.toJson(),
      );
      return data["accessToken"];
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
