// Constants for Add Task Screen
import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';

class AddTaskConstants {
  // Sizes and spacings
  static double get verticalPadding =>
      AppWidthHeight.persantageOfHeight((24 / 812) * 100);

  static double get horizontalPadding =>
      AppWidthHeight.persantageOfWidth((22 / 375) * 100);

  static double get smallSpacing =>
      AppWidthHeight.persantageOfWidth((8 / 375) * 100);

  static double get mediumSpacing =>
      AppWidthHeight.persantageOfHeight((16 / 812) * 100);

  static double get largeSpacing =>
      AppWidthHeight.persantageOfHeight((28.5 / 812) * 100);

  static double get smallContainerHeight =>
      AppWidthHeight.persantageOfHeight((56 / 812) * 100);

  static double get largeContainerHeight =>
      AppWidthHeight.persantageOfHeight((240 / 812) * 100);

  static double get iconSize =>
      AppWidthHeight.persantageOfWidth((24 / 375) * 100);

  static double get borderRadius =>
      AppWidthHeight.persantageOfWidth((12 / 375) * 100);

  static double get calendarHeight =>
      AppWidthHeight.persantageOfHeight((580 / 812) * 100);

  static TextScaler get textScaler =>
      TextScaler.linear(AppWidthHeight.persantageOfWidth((1 / 375) * 100));

  static BoxDecoration get containerDecoration => BoxDecoration(
        color: AppLightColor.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppLightColor.greyBorder),
      );

  static const List<Map<String, String>> priorityItems = [
    {'label': 'Low Priority', 'value': 'low'},
    {'label': 'Medium Priority', 'value': 'medium'},
    {'label': 'High Priority', 'value': 'high'},
  ];
}
