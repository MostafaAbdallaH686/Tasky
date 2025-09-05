import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:to_do_app/core/constants/login_constants.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_cubit.dart';

class LoginPhoneField extends StatelessWidget {
  final LoginCubit cubit;

  const LoginPhoneField({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        hintText: AppString.numberhint,
        hintStyle: AppTextStyle.extraLight14(AppLightColor.grey),
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoginConstants.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppLightColor.greyBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(LoginConstants.borderRadius),
          borderSide: BorderSide(color: AppLightColor.greyBorder, width: 1.2),
        ),
      ),
      flagsButtonPadding: const EdgeInsets.only(left: 5),
      dropdownIcon: const Icon(Icons.keyboard_arrow_down_outlined),
      dropdownIconPosition: IconPosition.trailing,
      dropdownDecoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15)),
      initialCountryCode: 'EG',
      onChanged: (phone) {
        cubit.phoneController.text = phone.completeNumber;
      },
    );
  }
}
