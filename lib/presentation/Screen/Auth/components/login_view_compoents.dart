import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoplite/utils/assets/app_svgs.dart';
import 'package:shoplite/utils/colors/app_colors.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class LoginViewCompoents {
  static Widget loginViewBackground(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Container(color: AppColors.blueColor)),
        Expanded(
          child: Container(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ],
    );
  }

  static Widget continueWithGoogleButton() => Container(
    height: 45.h,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: .5),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppSvgs.googleIcon),
        5.hs,
        Text(
          "Continue with Google",
          style: AppTextstyle.semibold14.copyWith(color: Colors.black),
        ),
      ],
    ),
  );
}
