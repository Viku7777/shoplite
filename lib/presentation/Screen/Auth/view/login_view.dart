import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/domain/models/auth_models/user_model.dart';
import 'package:shoplite/presentation/Components/common_textfields.dart';
import 'package:shoplite/presentation/Components/stackLoading.dart';
import 'package:shoplite/presentation/Screen/Auth/components/login_view_compoents.dart';
import 'package:shoplite/presentation/Screen/Auth/controller/auth_controller.dart';
import 'package:shoplite/utils/assets/app_svgs.dart';
import 'package:shoplite/utils/buttons/app_buttons.dart';
import 'package:shoplite/utils/colors/app_colors.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';
import 'package:shoplite/utils/toasts/app_toast.dart';

class LoginView extends ConsumerStatefulWidget {
  final Box<UserModel> box;
  const LoginView({super.key, required this.box});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordNode = FocusNode();
  ValueNotifier checkboxState = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final autoref = ref.watch(authStateProvider);
    // final autoref = ref.watch(authStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          // here is the background
          LoginViewCompoents.loginViewBackground(context),
          SafeArea(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                24.vs,
                SvgPicture.asset(AppSvgs.appIconSmallSize),
                14.vs,
                Text(
                  "Sign in to your \nAccount",
                  textAlign: TextAlign.center,
                  style: AppTextstyle.bodyLarge.copyWith(color: Colors.white),
                ),
                6.vs,
                Text(
                  "Enter your email and password to log in ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                10.vs,
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: .5,
                      ),
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      8.vs,
                      // Continue With Google Button
                      LoginViewCompoents.continueWithGoogleButton(),
                      15.vs,
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          12.hs,
                          Text(
                            "Or login with",
                            style: AppTextstyle.semibold14.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                          12.hs,
                          Expanded(child: Divider()),
                        ],
                      ),
                      15.vs,
                      CommonTextfields.simpleOutlineBorderTextField(
                        controller: emailController,
                        hint: "Username",
                        focusNode: emailNode,
                      ),
                      12.vs,
                      CommonOutlinePasswordTextField(
                        controller: passwordController,
                        hint: "Password",
                        node: passwordNode,
                      ),
                      12.vs,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: checkboxState,
                                builder:
                                    (context, value, child) => Checkbox(
                                      value: value,
                                      activeColor: AppColors.blueColor,
                                      onChanged: (value) {
                                        checkboxState.value = value;
                                      },
                                    ),
                              ),
                              Text(
                                "Remember me",
                                style: AppTextstyle.semibold14,
                              ),
                            ],
                          ),
                          Text(
                            "Forgot Password ?",
                            style: AppTextstyle.semibold14.copyWith(
                              color: AppColors.blueColor,
                            ),
                          ),
                        ],
                      ),
                      12.vs,
                      AppButtons.primaryButton(
                        title: "Log In",
                        ontap: () {
                          var read = ref.read(authStateProvider.notifier);
                          read.login(
                            context: context,
                            username: emailController.text,
                            password: passwordController.text,
                            box: widget.box,
                          );
                        },
                      ),
                      10.vs,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an account?"),
                          5.hs,
                          Text(
                            "Sign Up",
                            style: AppTextstyle.semibold14.copyWith(
                              color: AppColors.blueColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final autoref = ref.watch(authStateProvider);
              return Stackloading(showLoading: autoref.isloading);
            },
          ),
        ],
      ),
    );
  }
}
