import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';

class RegisterConstants {
  // Sizes and spacings
  static double get horizontalImagePadding =>
      AppWidthHeight.persantageOfWidth((61 / 375) * 100);
  static double get imageWidth =>
      AppWidthHeight.persantageOfWidth((375 / 375) * 100);
  static double get imageHeight =>
      AppWidthHeight.persantageOfHeight((300 / 812) * 100);
  static double get topSpacing =>
      AppWidthHeight.persantageOfHeight((188 / 812) * 100);
  static double get horizontalPadding =>
      AppWidthHeight.persantageOfWidth((24.5 / 375) * 100);
  static double get columnSpacing =>
      AppWidthHeight.persantageOfHeight((23 / 812) * 100);
  static double get formSpacing =>
      AppWidthHeight.persantageOfHeight((10 / 812) * 100);
  static double get buttonSpacing =>
      AppWidthHeight.persantageOfHeight((5 / 812) * 100);
  static double get borderRadius =>
      AppWidthHeight.persantageOfWidth((10 / 375) * 100);

  static TextScaler get textScaler => TextScaler.linear(
        AppWidthHeight.persantageOfWidth((1 / 375) * 100),
      );

  static const RadialGradient shaderGradient = RadialGradient(
    center: Alignment.center,
    radius: 0.55,
    colors: [Colors.white, Colors.transparent],
    stops: [0.8, 1.0],
  );
}
