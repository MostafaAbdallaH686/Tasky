import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';

abstract class AppSnakBar {
  static void showSnakBar({required String title, required String message}) {
    Get.snackbar(title, message);
  }

  static void showSnakBar2({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          title,
          style: AppTextStyle.light16,
        ),
        messageText: Text(
          message,
          style: AppTextStyle.light14,
        ),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(
          seconds: 2,
        ),
        backgroundColor: AppLightColor.scaffoldBackground,
      ),
    );
  }
}
