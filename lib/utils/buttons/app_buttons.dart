import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplite/utils/colors/app_colors.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class AppButtons {
  static Widget primaryButton({
    required String title,
    required VoidCallback ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 45.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.blueColor,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextstyle.medium16.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
