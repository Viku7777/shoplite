import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplite/utils/colors/app_colors.dart';

class AppTheme {
  // Light theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColorDark: Colors.black,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueColor),
    textTheme: Typography.englishLike2021.apply(
      fontSizeFactor: 1.sp,
      bodyColor: Colors.black87,
    ),
  );

  // Dark theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black87,
    textTheme: Typography.englishLike2021.apply(
      fontSizeFactor: 1.sp,
      bodyColor: Colors.white,
    ),
    primaryColorDark: Colors.white,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blueColor,
      brightness: Brightness.dark,
    ),
  );
}
