import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/constants/register_constants.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_cubit.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_state.dart';
import 'package:to_do_app/feature/auth/register/view/widgets/register_background.dart';
import 'package:to_do_app/feature/auth/register/view/widgets/register_button.dart';
import 'package:to_do_app/feature/auth/register/view/widgets/register_form.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = RegisterCubit.get(context);

    return SingleChildScrollView(
      child: Stack(
        children: [
          const RegisterBackground(),
          Column(
            spacing: RegisterConstants.columnSpacing,
            children: [
              SizedBox(height: RegisterConstants.topSpacing),
              _buildFormSection(cubit),
              _buildButtonSection(cubit),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(RegisterCubit cubit) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: RegisterConstants.horizontalPadding),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return RegisterForm(cubit: cubit);
        },
      ),
    );
  }

  Widget _buildButtonSection(RegisterCubit cubit) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: RegisterConstants.horizontalPadding),
      child: RegisterButtonSection(cubit: cubit),
    );
  }
}
