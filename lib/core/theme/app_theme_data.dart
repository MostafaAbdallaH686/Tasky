import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';

abstract class AppThemeData {
  static final ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: AppLightColor.white,
    fontFamily: "DM Sans",
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: true,
  );
}
