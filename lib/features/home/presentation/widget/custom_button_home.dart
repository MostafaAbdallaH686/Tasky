import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';

class CustomButtonOfOhome extends StatelessWidget {
  const CustomButtonOfOhome({
    super.key,
    required this.title,
    required this.isActive,
    this.textSize = 16,
    this.onTap,
    required this.width,
  });
  final String title;
  final bool isActive;
  final double textSize;
  final double? width;

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: AppWidthHeight.persantageOfHeight((36 / 812) * 100),
        decoration: BoxDecoration(
          color:
              isActive ? AppLightColor.blue : AppLightColor.homegreyContainer,
          borderRadius: BorderRadius.circular(
              AppWidthHeight.persantageOfWidth((24 / 375) * 100)),
        ),
        child: Center(
          child: Text(
            textScaler: TextScaler.linear(
              AppWidthHeight.persantageOfWidth((1 / 375) * 100),
            ),
            title,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w400,
              color:
                  isActive ? AppLightColor.white : AppLightColor.homegreytext,
            ),
          ),
        ),
      ),
    );
  }
}
