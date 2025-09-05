import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:to_do_app/core/constants/register_constants.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_cubit.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_state.dart';

class RegisterPhoneField extends StatelessWidget {
  final RegisterCubit cubit;

  const RegisterPhoneField({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => current is RegisterPhoneValidationState,
      builder: (context, state) {
        return IntlPhoneField(
          decoration: InputDecoration(
            hintText: AppString.numberhint,
            hintStyle: AppTextStyle.extraLight14(AppLightColor.grey),
            counterText: "",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(RegisterConstants.borderRadius),
              borderSide: BorderSide(color: AppLightColor.greyBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(RegisterConstants.borderRadius),
              borderSide:
                  BorderSide(color: AppLightColor.greyBorder, width: 1.2),
            ),
            errorText: cubit.phoneError,
          ),
          flagsButtonPadding: const EdgeInsets.only(left: 5),
          dropdownIcon: const Icon(Icons.keyboard_arrow_down_outlined),
          dropdownIconPosition: IconPosition.trailing,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RegisterConstants.borderRadius),
          ),
          initialCountryCode: 'EG',
          onChanged: (phone) {
            if (phone.completeNumber.isNotEmpty &&
                !phone.completeNumber.startsWith('+20')) {
              cubit.validatePhone(phone.completeNumber);
            }
          },
        );
      },
    );
  }
}
