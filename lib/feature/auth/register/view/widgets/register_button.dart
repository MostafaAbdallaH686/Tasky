import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/constants/register_constants.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_snak_bar.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/custom_circle_progress_inicator.dart';
import 'package:to_do_app/core/widgets/default_custom_buttong.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_cubit.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_state.dart';
import 'package:to_do_app/feature/auth/shared_widgets/custom_botton_section_text.dart';

class RegisterButtonSection extends StatelessWidget {
  final RegisterCubit cubit;

  const RegisterButtonSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: RegisterConstants.buttonSpacing,
      children: [
        _buildRegisterButton(context),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        _handleRegisterState(context, state);
      },
      builder: (context, state) {
        if (state is RegisterLoadingState) {
          return const CustomCircleProgressInicator();
        }
        return DefaultCustomButtong(
          text: AppString.kRegister,
          onTap: cubit.onTap,
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return CustomBottonSectionText(
      startText: AppString.registerHaveAreayAccount,
      buttonText: AppString.registerHaveAccount,
      onPressed: () {
        AppRoute.navigateBack();
      },
    );
  }

  void _handleRegisterState(BuildContext context, RegisterState state) {
    if (state is RegisterFailingState) {
      AppSnakBar.showSnakBar(title: "Error", message: state.errMessage);
    } else if (state is RegisterSuccessState) {
      AppRoute.navigateBack();
    }
  }
}
