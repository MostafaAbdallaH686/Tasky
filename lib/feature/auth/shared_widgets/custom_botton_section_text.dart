import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';

class CustomBottonSectionText extends StatelessWidget {
  const CustomBottonSectionText(
      {super.key,
      required this.startText,
      required this.buttonText,
      this.onPressed});
  final String startText;
  final String buttonText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: AppWidthHeight.persantageOfHeight((4 / 812) * 100),
      children: [
        Text(
          startText,
          style: AppTextStyle.regular14,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: AppTextStyle.blue14.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
