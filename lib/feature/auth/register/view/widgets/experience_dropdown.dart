import 'package:flutter/material.dart';
import 'package:to_do_app/core/constants/register_constants.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_cubit.dart';

class ExperienceDropdown extends StatelessWidget {
  final RegisterCubit cubit;

  const ExperienceDropdown({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      decoration: InputDecoration(
        hintText: AppString.experienceLevelHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppLightColor.greyBorder),
        ),
        filled: true,
        fillColor: AppLightColor.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RegisterConstants.borderRadius),
          borderSide: BorderSide(color: AppLightColor.greyBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RegisterConstants.borderRadius),
          borderSide: BorderSide(color: AppLightColor.greyBorder, width: 1.2),
        ),
      ),
      value: cubit.selectedExperienceLevel,
      items: cubit.experienceLevels.map((level) {
        return DropdownMenuItem(
          value: level,
          child: Text(level),
        );
      }).toList(),
      onChanged: (value) {
        cubit.selectedExperienceLevel = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your experience level';
        }
        return null;
      },
    );
  }
}
