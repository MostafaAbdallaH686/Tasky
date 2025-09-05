import 'package:flutter/material.dart';
import 'package:to_do_app/core/constants/login_constants.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/default_text_form_filed.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_cubit.dart';
import 'package:to_do_app/feature/auth/login/view/widgets/login_phone_field.dart';

class LoginForm extends StatelessWidget {
  final LoginCubit cubit;

  const LoginForm({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.globalKey,
      autovalidateMode: cubit.autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: LoginConstants.formSpacing,
        children: [
          _buildTitle(),
          LoginPhoneField(cubit: cubit),
          _buildPasswordField(cubit),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppString.tLogin,
      textScaler: LoginConstants.textScaler,
      style: AppTextStyle.regular24,
    );
  }

  Widget _buildPasswordField(LoginCubit cubit) {
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
