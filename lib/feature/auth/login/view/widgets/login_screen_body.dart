import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_snak_bar.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_image.dart';
import 'package:to_do_app/core/utils/app_radius.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/custom_circle_progress_inicator.dart';
import 'package:to_do_app/core/widgets/default_custom_buttong.dart';
import 'package:to_do_app/core/widgets/default_text_form_filed.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_cubit.dart';
import 'package:to_do_app/feature/auth/login/cubit/login_state.dart';
import 'package:to_do_app/feature/auth/register/view/register_screen.dart';
import 'package:to_do_app/feature/auth/shared_widgets/custom_botton_section_text.dart';
import 'package:to_do_app/feature/home/view/home_screen.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.9, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                AppImage.tauth,
                width: AppWidthHeight.persantageOfWidth((375 / 375) * 100),
                height: AppWidthHeight.persantageOfHeight((510 / 812) * 100),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppWidthHeight.persantageOfHeight((23 / 812) * 100),
              children: [
                SizedBox(
                  height: AppWidthHeight.persantageOfHeight((443 / 812) * 100),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          AppWidthHeight.persantageOfWidth((24.5 / 375) * 100)),
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return Form(
                        key: LoginCubit.get(context).globalKey,
                        autovalidateMode:
                            LoginCubit.get(context).autovalidateMode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppWidthHeight.persantageOfHeight(
                              (15 / 812) * 100),
                          children: [
                            Text(
                              textScaler: TextScaler.linear(
                                AppWidthHeight.persantageOfWidth(
                                    (1 / 375) * 100),
                              ),
                              AppString.tLogin,
                              style: AppTextStyle.regular24,
                            ),
                            IntlPhoneField(
                              decoration: InputDecoration(
                                hintText: AppString.numberhint,
                                hintStyle: AppTextStyle.extraLight14(
                                    AppLightColor.grey),
                                counterText: "",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppWidthHeight.persantageOfWidth(
                                          (10 / 375) * 100)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: AppRadius.buttonRaduis,
                                  borderSide: BorderSide(
                                      color: AppLightColor.greyBorder),
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
                              flagsButtonPadding:
                                  const EdgeInsets.only(left: 5),
                              dropdownIcon:
                                  Icon(Icons.keyboard_arrow_down_outlined),
                              dropdownIconPosition: IconPosition.trailing,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: AppRadius.buttonRaduis,
                              ),
                              initialCountryCode: 'EG',
                              onChanged: (phone) {
                                LoginCubit.get(context).phoneController.text =
                                    phone.completeNumber;
                              },
                            ),
                            DefaultTextFormFiled(
                              hint: AppString.passwordhint,
                              controller:
                                  LoginCubit.get(context).passwordController,
                              validator:
                                  LoginCubit.get(context).passwordValidator,
                              obscureText:
                                  !LoginCubit.get(context).isPasswordVisible,
                              passwordSuffixIcon: Icon(
                                LoginCubit.get(context).isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppLightColor.grey,
                              ),
                              onTapSuffixIcon: () {
                                LoginCubit.get(context)
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
                        AppWidthHeight.persantageOfWidth((24 / 375) * 100),
                  ),
                  child: Column(
                    spacing: AppWidthHeight.persantageOfHeight((4 / 812) * 100),
                    children: [
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          log(state.toString());
                          if (state is LoginFailingState) {
                            AppSnakBar.showSnakBar(
                                title: "Error", message: state.errMessage);
                          } else if (state is LoginSuccessState) {
                            log("Success Login");
                            AppRoute.navigateTo(HomeScreen());
                            log("Success Login");
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return const CustomCircleProgressInicator();
                          }
                          return DefaultCustomButtong(
                            text: AppString.kLogin,
                            onTap: LoginCubit.get(context).onTap,
                          );
                        },
                      ),
                      SizedBox(
                        width:
                            AppWidthHeight.persantageOfWidth((259 / 375) * 100),
                        child: CustomBottonSectionText(
                          startText: AppString.loginScreenNoAcount,
                          buttonText: AppString.loginScreenCreateAcount,
                          onPressed: () {
                            AppRoute.navigateTo(const RegisterScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
