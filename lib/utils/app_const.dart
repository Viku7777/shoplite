// ignore_for_file: non_constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConst {
  static final String appname = "Shop Lite";
  static final IS_DEVICE_CONNECT_WITH_INTERNET = StateProvider((ref) {
    return false;
  });
}
