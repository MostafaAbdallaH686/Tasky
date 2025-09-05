import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/constants/login_constants.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_cubit.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_state.dart';
import 'package:to_do_app/feature/auth/login/view/widgets/login_background.dart';
import 'package:to_do_app/feature/auth/login/view/widgets/login_button.dart';
import 'package:to_do_app/feature/auth/login/view/widgets/login_form.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = LoginCubit.get(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            const LoginBackground(),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: LoginConstants.columnSpacing,
              children: [
                SizedBox(height: LoginConstants.topSpacing),
                _buildFormSection(cubit),
                _buildButtonSection(cubit),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection(LoginCubit cubit) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: LoginConstants.horizontalPadding),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return LoginForm(cubit: cubit);
        },
      ),
    );
  }

  Widget _buildButtonSection(LoginCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: LoginConstants.buttonHorizontalPadding),
      child: LoginButtonSection(cubit: cubit),
    );
  }
}
