import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplite/presentation/Screen/Home/view/home_screen_view.dart';
import 'package:shoplite/utils/buttons/app_buttons.dart';
import 'package:shoplite/utils/colors/app_colors.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class SuccessOrderBottomSheet extends StatefulWidget {
  const SuccessOrderBottomSheet({super.key});

  @override
  State<SuccessOrderBottomSheet> createState() =>
      _SuccessOrderBottomSheetState();
}

class _SuccessOrderBottomSheetState extends State<SuccessOrderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.shop, color: AppColors.blueColor, size: 60.sp),
        15.vs,
        Text(
          "Congrats! your order is place\n successfully",
          textAlign: TextAlign.center,
          style: AppTextstyle.medium16,
        ),
        10.vs,
        Text(
          "Track your order or just chat \ndirectly to the seller",
          textAlign: TextAlign.center,
          style: AppTextstyle.semibold14,
        ),
        20.vs,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: AppButtons.primaryButton(
            title: "Continue",
            ontap: () {
              context.removeUntilNextScreen(HomeScreenView());
            },
          ),
        ),
      ],
    );
  }
}
