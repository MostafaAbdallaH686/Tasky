import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_image.dart';
import 'package:to_do_app/core/utils/app_string.dart';

class HomeScreenBodyNoData extends StatelessWidget {
  const HomeScreenBodyNoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      children: [
        SizedBox(height: 40),
        Text(
          AppString.textNoBodyHomeScreen,
          style: AppTextStyle.light16,
          textAlign: TextAlign.center,
        ),
        AppSvgImage.showSvgImage(
          path: AppImage.kHomeNoDataImage,
          width: double.infinity,
          height: AppWidthHeight.persantageOfHeight((268 / 812) * 100),
        )
      ],
    );
  }
}
