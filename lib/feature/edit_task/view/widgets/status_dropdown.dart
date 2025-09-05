import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/function/home_function.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';

class StatusDropdown extends StatelessWidget {
  final String? value;
  final void Function(String?) onChanged;
  final List<Map<String, String>> items;

  const StatusDropdown({
    super.key,
    this.value,
    required this.onChanged,
    this.items = const [
      {'label': 'Waiting', 'value': 'waiting'},
      {'label': 'In Progress', 'value': 'inProgress'},
      {'label': 'Finished', 'value': 'finished'},
    ],
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      icon: AppSvgImage.showSvgImage(
        path: AppIcon.tArrowdown,
        width: AppWidthHeight.persantageOfWidth(24 / 375 * 100),
        height: AppWidthHeight.persantageOfHeight(24 / 812 * 100),
      ),
      items: items.map((item) {
        final label = item['label']!;
        final value = item['value']!;
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              SizedBox(width: AppWidthHeight.persantageOfWidth(6 / 375 * 100)),
              Text(
                label,
                style: AppTextStyle.priority16(
                  color: getStatusTextColor(value.capitalizeFirst!),
                ),
                textScaler: _textScaler(),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: _dropdownDecoration(),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      fillColor: AppLightColor.homegreyContainer,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppWidthHeight.persantageOfWidth(12 / 375 * 100),
        vertical: AppWidthHeight.persantageOfHeight(12 / 812 * 100),
      ),
    );
  }

  TextScaler _textScaler() {
    return TextScaler.linear(AppWidthHeight.persantageOfWidth(1 / 375 * 100));
  }
}
