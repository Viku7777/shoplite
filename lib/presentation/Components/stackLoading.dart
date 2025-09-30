import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoplite/utils/colors/app_colors.dart';

class Stackloading extends StatelessWidget {
  final bool showLoading;
  const Stackloading({super.key, required this.showLoading});

  @override
  Widget build(BuildContext context) {
    if (showLoading) {
      return Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: Colors.black54,
        alignment: Alignment.center,
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.blueColor,
          size: 40.sp,
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
