import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/function/home_function.dart';
import 'package:to_do_app/core/utils/app_image.dart';

Widget buildTaskImage(String? image, double width, double height) {
  final imageUrl = getFullImageUrl(image);

  if (imageUrl != null) {
    return Image.network(
      imageUrl,
      width: AppWidthHeight.persantageOfWidth((width / 375) * 100),
      height: AppWidthHeight.persantageOfHeight((height / 812) * 100),
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          AppImage.tcart,
          width: AppWidthHeight.persantageOfWidth((width / 375) * 100),
          height: AppWidthHeight.persantageOfHeight((height / 812) * 100),
          fit: BoxFit.contain,
        );
      },
    );
  } else {
    return Image.asset(
      AppImage.tcart,
      width: AppWidthHeight.persantageOfWidth((width / 375) * 100),
      height: AppWidthHeight.persantageOfHeight((height / 812) * 100),
      fit: BoxFit.contain,
    );
  }
}
