import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';

class TaskTextSection extends StatelessWidget {
  final String title;
  final String description;

  const TaskTextSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.regularB24,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textScaler: _textScaler(),
        ),
        Text(
          description,
          style: AppTextStyle.regular14,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          textScaler: _textScaler(),
        ),
      ],
    );
  }

  TextScaler _textScaler() {
    return TextScaler.linear(AppWidthHeight.persantageOfWidth(1 / 375 * 100));
  }
}
