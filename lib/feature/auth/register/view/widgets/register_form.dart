import 'package:flutter/material.dart';
import 'package:to_do_app/core/constants/register_constants.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/default_text_form_filed.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_cubit.dart';
import 'package:to_do_app/feature/auth/register/view/widgets/experience_dropdown.dart';
import 'package:to_do_app/feature/auth/register/view/widgets/register_phone_field.dart';

class RegisterForm extends StatelessWidget {
  final RegisterCubit cubit;

  const RegisterForm({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.globalKey,
      autovalidateMode: cubit.autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: RegisterConstants.formSpacing,
        children: [
          _buildTitle(),
          _buildNameField(cubit),
          RegisterPhoneField(cubit: cubit),
          _buildExperienceField(cubit),
          ExperienceDropdown(cubit: cubit),
          _buildAddressField(cubit),
          _buildPasswordField(cubit),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppString.tLogin,
      textScaler: RegisterConstants.textScaler,
      style: AppTextStyle.regular24,
    );
  }

  Widget _buildNameField(RegisterCubit cubit) {
    return DefaultTextFormFiled(
      hint: AppString.userNamehint,
      controller: cubit.displayNameController,
      validator: cubit.nameValidator,
    );
  }

  Widget _buildExperienceField(RegisterCubit cubit) {
    return DefaultTextFormFiled(
      hint: AppString.experiencehint,
      controller: cubit.experienceYearsController,
    );
  }

  Widget _buildAddressField(RegisterCubit cubit) {
    return DefaultTextFormFiled(
      hint: AppString.addressHint,
      controller: cubit.addressController,
    );
  }

  Widget _buildPasswordField(RegisterCubit cubit) {
    return DefaultTextFormFiled(
      hint: AppString.passwordhint,
      controller: cubit.passwordController,
      validator: cubit.passwordValidator,
      obscureText: !cubit.isPasswordVisible,
      passwordSuffixIcon: Icon(
        cubit.isPasswordVisible
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        color: AppLightColor.grey,
      ),
      onTapSuffixIcon: () {
        cubit.togglePasswordVisibility();
      },
    );
  }
}
