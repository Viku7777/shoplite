// ignore_for_file: file_names

abstract class BaseApiServices {
  Future<dynamic> getApi({required String url});
  Future<dynamic> postApi({required String url, required dynamic body});
}
