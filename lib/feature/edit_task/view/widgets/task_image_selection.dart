import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/feature/home/view/widgets/image_widget.dart';

class TaskImageSection extends StatelessWidget {
  final String? imagePath;

  const TaskImageSection({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildTaskImage(
        imagePath,
        AppWidthHeight.persantageOfWidth(100),
        AppWidthHeight.persantageOfHeight((225 / 812) * 100),
      ),
    );
  }
}
