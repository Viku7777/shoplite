import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  void nextScreen(Widget newScreen) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => newScreen));
  }

  void removeUntilNextScreen(Widget newScreen) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => newScreen),
      (route) => false,
    );
  }

  void popScreen() {
    Navigator.of(this).pop();
  }
}

extension IntExtensions on int {
  Widget get vs => h.verticalSpace;
  Widget get hs => h.horizontalSpace;
}
