import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';

class CustomCardProfile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showSvg;
  const CustomCardProfile({
    super.key,
    required this.title,
    required this.subtitle,
    this.showSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppLightColor.cardcolor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(
          vertical: AppWidthHeight.persantageOfHeight((8 / 812) * 100),
          horizontal: AppWidthHeight.persantageOfWidth((22.5 / 375) * 100)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthHeight.persantageOfWidth((15 / 375) * 100),
            vertical: AppWidthHeight.persantageOfHeight((12 / 812) * 100)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.cardtitle),
                  Text(subtitle, style: AppTextStyle.bold18),
                ],
              ),
            ),
            if (showSvg)
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: subtitle));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Copied to clipboard"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: AppSvgImage.showSvgImage(
                  path: AppIcon.tprofile,
                  width: 50,
                  height: 50,
                  fit: BoxFit.scaleDown,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
