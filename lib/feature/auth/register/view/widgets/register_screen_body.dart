import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_snak_bar.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_image.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/custom_circle_progress_inicator.dart';
import 'package:to_do_app/core/widgets/default_custom_buttong.dart';
import 'package:to_do_app/core/widgets/default_text_form_filed.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_cubit.dart';
import 'package:to_do_app/feature/auth/register/cubit/register_state.dart';
import 'package:to_do_app/feature/auth/shared_widgets/custom_botton_section_text.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppWidthHeight.persantageOfWidth((61 / 375) * 100)),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return RadialGradient(
                  center: Alignment.center,
                  radius: 0.55,
                  colors: [
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.8, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                AppImage.tauth,
                width: AppWidthHeight.persantageOfWidth((375 / 375) * 100),
                height: AppWidthHeight.persantageOfHeight((300 / 812) * 100),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            spacing: AppWidthHeight.persantageOfHeight((23 / 812) * 100),
            children: [
              SizedBox(
                height: AppWidthHeight.persantageOfHeight((188 / 812) * 100),
              ),
              // center section
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        AppWidthHeight.persantageOfWidth((24.5 / 375) * 100)),
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return Form(
                      key: RegisterCubit.get(context).globalKey,
                      autovalidateMode:
                          RegisterCubit.get(context).autovalidateMode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing:
                            AppWidthHeight.persantageOfHeight((10 / 812) * 100),
                        children: [
                          Text(
                            textScaler: TextScaler.linear(
                              AppWidthHeight.persantageOfWidth((1 / 375) * 100),
                            ),
                            AppString.tLogin,
                            style: AppTextStyle.regular24,
                          ),
                          DefaultTextFormFiled(
                            hint: AppString.userNamehint,
                            controller: RegisterCubit.get(context)
                                .displayNameController,
                            validator: RegisterCubit.get(context).nameValidator,
                          ),
                          IntlPhoneField(
                            decoration: InputDecoration(
                              hintText: AppString.numberhint,
                              hintStyle:
                                  AppTextStyle.extraLight14(AppLightColor.grey),
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppWidthHeight.persantageOfWidth(
                                        (10 / 375) * 100)),
                                borderSide:
                                    BorderSide(color: AppLightColor.greyBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppWidthHeight.persantageOfWidth(
                                        (10 / 375) * 100)),
                                borderSide: BorderSide(
                                    color: AppLightColor.greyBorder,
                                    width: 1.2),
                              ),
                            ),
                            flagsButtonPadding: const EdgeInsets.only(left: 5),
                            dropdownIcon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            dropdownIconPosition: IconPosition.trailing,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppWidthHeight.persantageOfWidth(
                                      (10 / 375) * 100)),
                            ),
                            initialCountryCode: 'EG',
                            onChanged: (phone) {
                              RegisterCubit.get(context).phoneNumber =
                                  phone.completeNumber;
                            },
                          ),
                          DefaultTextFormFiled(
                            hint: AppString.experiencehint,
                            controller: RegisterCubit.get(context)
                                .experienceYearsController,
                          ),
                          DropdownButtonFormField<String>(
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            decoration: InputDecoration(
                              hintText: AppString.experienceLevelHint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: AppLightColor.greyBorder),
                              ),
                              filled: true,
                              fillColor: AppLightColor.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppWidthHeight.persantageOfWidth(
                                        (10 / 375) * 100)),
                                borderSide:
                                    BorderSide(color: AppLightColor.greyBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppWidthHeight.persantageOfWidth(
                                        (10 / 375) * 100)),
                                borderSide: BorderSide(
                                    color: AppLightColor.greyBorder,
                                    width: 1.2),
                              ),
                            ),
                            value: RegisterCubit.get(context)
                                .selectedExperienceLevel,
                            items: RegisterCubit.get(context)
                                .experienceLevels
                                .map((level) {
                              return DropdownMenuItem(
                                value: level,
                                child: Text(level),
                              );
                            }).toList(),
                            onChanged: (value) {
                              RegisterCubit.get(context)
                                  .selectedExperienceLevel = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select your experience level';
                              }
                              return null;
                            },
                          ),
                          DefaultTextFormFiled(
                            hint: AppString.addressHint,
                            controller:
                                RegisterCubit.get(context).addressController,
                          ),
                          DefaultTextFormFiled(
                            hint: AppString.passwordhint,
                            controller:
                                RegisterCubit.get(context).passwordController,
                            validator:
                                RegisterCubit.get(context).passwordValidator,
                            obscureText:
                                !RegisterCubit.get(context).isPasswordVisible,
                            passwordSuffixIcon: Icon(
                              RegisterCubit.get(context).isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppLightColor.grey,
                            ),
                            onTapSuffixIcon: () {
                              RegisterCubit.get(context)
                                  .togglePasswordVisibility();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // button section
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        AppWidthHeight.persantageOfWidth((24.5 / 375) * 100)),
                child: Column(
                  spacing: AppWidthHeight.persantageOfHeight((5 / 812) * 100),
                  children: [
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterFailingState) {
                          AppSnakBar.showSnakBar(
                              title: "Error", message: state.errMessage);
                        } else if (state is RegisterSuccessState) {
                          AppRoute.navigateBack();
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterLoadingState) {
                          return const CustomCircleProgressInicator();
                        }
                        return DefaultCustomButtong(
                          text: AppString.kRegister,
                          onTap: RegisterCubit.get(context).onTap,
                        );
                      },
                    ),
                    CustomBottonSectionText(
                      startText: AppString.registerHaveAreayAccount,
                      buttonText: AppString.registerHaveAccount,
                      onPressed: () {
                        AppRoute.navigateBack();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
