import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/function/app_delay.dart';
import 'package:to_do_app/feature/auth/register/data/repo/register_repo.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // form widget
  GlobalKey<FormState> globalKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isPasswordVisible = false;
  String? phoneError;

  String? phoneNumber;
  TextEditingController displayNameController = TextEditingController();
  TextEditingController experienceYearsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<String> experienceLevels = ['fresh', 'junior', 'midLevel', 'senior'];
  String? selectedExperienceLevel;
  // controller
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // repo
  RegisterRepo registerRepo = RegisterRepo();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged(isPasswordVisible));
  }

  // validation
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter name !";
    }
    return null;
  }

  void validatePhone(String phone) {
    phoneNumber = phone;

    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    final digitsWithoutCountryCode = digitsOnly.replaceFirst('20', '');

    if (digitsWithoutCountryCode.isEmpty) {
      phoneError = 'Phone number is required';
    } else if (digitsWithoutCountryCode.length < 7) {
      phoneError = 'Please enter a valid phone number';
    } else {
      phoneError = null;
    }
    emit(RegisterPhoneValidationState());
  }

  bool isValidPhone(String phone) {
    return phone.length >= 10;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter password !";
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter password !";
    }
    if (passwordController.text != value) {
      return "not match with password";
    }
    return null;
  }

  // button function
  void onTap() async {
    emit(RegisterLoadingState());
    await AppDelay.delayLoading();

    final phone = phoneNumber;
    final password = passwordController.text;
    final displayName = displayNameController.text;
    final address = addressController.text;
    final level = selectedExperienceLevel;
    final experienceText = experienceYearsController.text;

    if (globalKey.currentState!.validate() && phone != null && level != null) {
      final experienceYears = int.tryParse(experienceText) ?? 0;
      final response = await registerRepo.register(
        phone: phone,
        password: password,
        displayName: displayName,
        experienceYears: experienceYears,
        address: address,
        level: level,
      );

      response.fold(
        (error) {
          emit(RegisterFailingState(errMessage: error));
        },
        (success) {
          emit(RegisterSuccessState(message: success));
        },
      );
    } else {
      autovalidateMode = AutovalidateMode.always;
      emit(RegisterNotValidateState());
    }
  }
}
