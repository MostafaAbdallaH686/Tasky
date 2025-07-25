import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_padding.dart';

class DefaultCustomButtong extends StatelessWidget {
  const DefaultCustomButtong(
      {super.key, required this.text, this.onTap, this.icon});
  final String text;
  final void Function()? onTap;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPadding.buttonVerticalPadding10,
        decoration: BoxDecoration(
          color: AppLightColor.blue,
          borderRadius: BorderRadius.circular(
              AppWidthHeight.persantageOfWidth((10 / 375) * 100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textScaler: TextScaler.linear(
                AppWidthHeight.persantageOfWidth((1 / 375) * 100),
              ),
              text,
              style: AppTextStyle.regular16,
            ),
            if (icon != null) ...[
              SizedBox(
                  width: AppWidthHeight.persantageOfWidth((8 / 375) * 100)),
              SvgPicture.asset(
                icon!,
                width: AppWidthHeight.persantageOfWidth((20 / 375) * 100),
                height: AppWidthHeight.persantageOfHeight((20 / 812) * 100),
                // ignore: deprecated_member_use
                color: AppLightColor.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
