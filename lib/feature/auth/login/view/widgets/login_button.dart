import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/constants/login_constants.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_snak_bar.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/custom_circle_progress_inicator.dart';
import 'package:to_do_app/core/widgets/default_custom_buttong.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_cubit.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_state.dart';
import 'package:to_do_app/feature/auth/register/view/register_screen.dart';
import 'package:to_do_app/feature/auth/shared_widgets/custom_botton_section_text.dart';
import 'package:to_do_app/feature/home/view/home_screen.dart';

class LoginButtonSection extends StatelessWidget {
  final LoginCubit cubit;

  const LoginButtonSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: LoginConstants.buttonSpacing,
      children: [
        _buildLoginButton(context),
        _buildRegisterButton(),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        _handleLoginState(context, state);
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return const CustomCircleProgressInicator();
        }
        return DefaultCustomButtong(
          text: AppString.kLogin,
          onTap: cubit.onTap,
        );
      },
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: LoginConstants.buttonWidth,
      child: CustomBottonSectionText(
        startText: AppString.loginScreenNoAcount,
        buttonText: AppString.loginScreenCreateAcount,
        onPressed: () {
          AppRoute.navigateTo(const RegisterScreen());
        },
      ),
    );
  }

  void _handleLoginState(BuildContext context, LoginState state) {
    if (state is LoginFailingState) {
      AppSnakBar.showSnakBar(title: "Error", message: state.errMessage);
    } else if (state is LoginSuccessState) {
      debugPrint("Success Login");
      AppRoute.navigateTo(const HomeScreen());
      debugPrint("Success Login");
    }
  }
}
