import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';

class LoginConstants {
  // Sizes and spacings
  static double get imageWidth =>
      AppWidthHeight.persantageOfWidth((375 / 375) * 100);
  static double get imageHeight =>
      AppWidthHeight.persantageOfHeight((510 / 812) * 100);
  static double get topSpacing =>
      AppWidthHeight.persantageOfHeight((443 / 812) * 100);
  static double get horizontalPadding =>
      AppWidthHeight.persantageOfWidth((24.5 / 375) * 100);
  static double get buttonHorizontalPadding =>
      AppWidthHeight.persantageOfWidth((24 / 375) * 100);
  static double get columnSpacing =>
      AppWidthHeight.persantageOfHeight((23 / 812) * 100);
  static double get formSpacing =>
      AppWidthHeight.persantageOfHeight((15 / 812) * 100);
  static double get buttonSpacing =>
      AppWidthHeight.persantageOfHeight((4 / 812) * 100);
  static double get buttonWidth =>
      AppWidthHeight.persantageOfWidth((259 / 375) * 100);
  static double get borderRadius =>
      AppWidthHeight.persantageOfWidth((10 / 375) * 100);

  static TextScaler get textScaler => TextScaler.linear(
        AppWidthHeight.persantageOfWidth((1 / 375) * 100),
      );

  static const LinearGradient shaderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.white, Colors.transparent],
    stops: [0.9, 1.0],
  );
}
