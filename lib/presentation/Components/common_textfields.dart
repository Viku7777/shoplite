import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplite/utils/colors/app_colors.dart';
import 'package:shoplite/utils/textstyle/app_textstyle.dart';

class CommonTextfields {
  static TextFormField simpleOutlineBorderTextField({
    required TextEditingController controller,
    required String hint,
    FocusNode? focusNode,
    Function(String)? onChanged,
    bool? enabled,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        hintText: hint,
        hintStyle: AppTextstyle.semibold14,

        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

class CommonOutlinePasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? node;
  final String hint;
  const CommonOutlinePasswordTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.node,
  });

  @override
  State<CommonOutlinePasswordTextField> createState() =>
      _CommonOutlinePasswordTextFieldState();
}

class _CommonOutlinePasswordTextFieldState
    extends State<CommonOutlinePasswordTextField> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: showPassword,
      controller: widget.controller,
      focusNode: widget.node,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        hintText: widget.hint,
        suffixIcon: IconButton(
          onPressed: () {
            showPassword = !showPassword;
            setState(() {});
          },
          icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
        ),
        hintStyle: AppTextstyle.semibold14,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
