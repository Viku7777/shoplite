// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoplite/data/local_data_source/local_data_source.dart';
import 'package:shoplite/domain/models/auth_models/user_model.dart';
import 'package:shoplite/presentation/Screen/Auth/view/login_view.dart';
import 'package:shoplite/presentation/Screen/Home/view/home_screen_view.dart';
import 'package:shoplite/utils/colors/app_colors.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Box<UserModel> get userBox => Hive.box<UserModel>(LocalDataSource.authBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text("Shop Lite", style: AppTextstyle.bodyLarge),
            ),
          ),
          LoadingAnimationWidget.staggeredDotsWave(
            color: AppColors.blueColor,
            size: 40.sp,
          ),
          40.vs,
        ],
      ),
    );
  }

  @override
  void initState() {
    checkUserLoggedInOrNot();
    super.initState();
  }

  void checkUserLoggedInOrNot() async {
    await Future.delayed(Duration(milliseconds: 1500), () {
      UserModel? currentUser =
          userBox.values.isNotEmpty ? userBox.values.first : null;

      if (currentUser == null) {
        context.removeUntilNextScreen(LoginView(box: userBox));
      } else {
        context.removeUntilNextScreen(HomeScreenView());
      }
    });
  }
}
