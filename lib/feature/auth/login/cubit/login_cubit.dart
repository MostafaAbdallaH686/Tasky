import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/function/app_delay.dart';
import 'package:to_do_app/feature/auth/login/data/repo/login_repo.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  // login repo

  LoginRepo repo = LoginRepo();

  // form

  GlobalKey<FormState> globalKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // controller
  bool isPasswordVisible = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // validator

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter phone number !";
    } else {
      return null;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged(isPasswordVisible));
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter password !";
    } else {
      return null;
    }
  }

  void onTap() async {
    emit(LoginLoadingState());
    await AppDelay.delayLoading();

    if (globalKey.currentState!.validate()) {
      var resonse = await repo.login(
          phone: phoneController.text, password: passwordController.text);
      resonse.fold((error) {
        emit(LoginFailingState(errMessage: error));
      }, (r) {
        emit(LoginSuccessState(loginModel: r));
      });
    } else {
      autovalidateMode = AutovalidateMode.always;
      emit(LoginNotValidateState());
    }
  }
}
