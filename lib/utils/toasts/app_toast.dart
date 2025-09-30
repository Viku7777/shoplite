import 'package:flutter/material.dart';
import 'package:shoplite/utils/colors/app_colors.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static simpleToast({
    required BuildContext context,
    String? title,
    ToastificationType? type,
    required String message,
  }) {
    return toastification.show(
      context: context, // optional if you use ToastificationWrapper
      type: type ?? ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(milliseconds: 1500),
      title: Text(title ?? "Alert !"),
      // you can also use RichText widget for title and description parameters
      description: RichText(
        text: TextSpan(text: message, style: TextStyle(color: Colors.black)),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      primaryColor: AppColors.blueColor,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),

      showProgressBar: true,

      applyBlurEffect: true,
    );
  }
}
