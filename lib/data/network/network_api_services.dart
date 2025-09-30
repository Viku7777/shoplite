import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shoplite/data/network/baseApiServices.dart';
import 'package:shoplite/data/network/exceptions.dart';
import 'package:shoplite/main.dart';
import 'package:shoplite/utils/app_const.dart';

class NetworkApiServices extends BaseApiServices {
  final _dio = Dio();
  @override
  Future<dynamic> getApi({required String url}) async {
    try {
      is_connect_with_internet(true);
      Response res = await _dio.get(url).timeout(Duration(seconds: 10));
      return res.data;
    } on SocketException {
      log("SOcket Exception");
      throw FetchDataException();
    } on TimeoutException {
      throw TimeoutException();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        is_connect_with_internet(false);
        throw NetworkException();
      } else {
        throw OtherException(jsonEncode((e.response?.data ?? "")));
      }
    }
  }

  @override
  Future<dynamic> postApi({required String url, required body}) async {
    try {
      is_connect_with_internet(true);
      Response res = await _dio
          .post(url, data: body)
          .timeout(Duration(seconds: 10));
      return res.data;
    } on SocketException {
      throw FetchDataException();
    } on TimeoutException {
      throw TimeoutException();
    } on DioException catch (e) {
      is_connect_with_internet(false);
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException();
      } else {
        throw OtherException(jsonEncode((e.response?.data ?? "")));
      }
    }
  }

  void is_connect_with_internet(bool value) {
    providerContainer
        .read(AppConst.IS_DEVICE_CONNECT_WITH_INTERNET.notifier)
        .state = value;
  }
}
