import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:to_do_app/core/constants/add_task_constants.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/function/home_function.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/feature/add_task/cubit/add_task_cubit.dart';

class PriorityDropdown extends StatelessWidget {
  final AddTaskCubit cubit;
  final ValueChanged<String> onChanged;

  const PriorityDropdown({
    super.key,
    required this.cubit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: cubit.selectedPriority,
      icon: _buildDropdownIcon(),
      items: AddTaskConstants.priorityItems.map(_buildDropdownItem).toList(),
      onChanged: (value) => value != null ? onChanged(value) : null,
      decoration: _buildInputDecoration(),
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(Map<String, String> item) {
    final label = item['label']!;
    final value = item['value']!;

    return DropdownMenuItem<String>(
      value: value,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Row(
          children: [
            AppSvgImage.showSvgImage(
              path: getPriorityIcon(value.capitalizeFirst!),
              width: AddTaskConstants.iconSize,
              height: AddTaskConstants.iconSize,
            ),
            SizedBox(width: _spacing),
            Text(
              label,
              textScaler: AddTaskConstants.textScaler,
              style: AppTextStyle.priority16(
                color: getPriorityTextColor(value.capitalizeFirst!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      fillColor: AppLightColor.homegreyContainer,
      filled: true,
      border: _inputBorder,
      enabledBorder: _inputBorder,
      focusedBorder: _inputBorder,
      contentPadding: EdgeInsets.symmetric(
        horizontal: _contentHorizontalPadding,
        vertical: _contentVerticalPadding,
      ),
    );
  }

  Widget _buildDropdownIcon() {
    return AppSvgImage.showSvgImage(
      path: AppIcon.tArrowdown,
      width: AddTaskConstants.iconSize,
      height: AddTaskConstants.iconSize,
    );
  }

  // Local constants
  double get _spacing => AppWidthHeight.persantageOfWidth((10 / 375) * 100);
  double get _horizontalPadding =>
      AppWidthHeight.persantageOfWidth((8 / 375) * 100);
  double get _contentHorizontalPadding =>
      AppWidthHeight.persantageOfWidth((12 / 375) * 100);
  double get _contentVerticalPadding =>
      AppWidthHeight.persantageOfHeight((12 / 812) * 100);

  InputBorder get _inputBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppLightColor.greyBorder),
      );
}
