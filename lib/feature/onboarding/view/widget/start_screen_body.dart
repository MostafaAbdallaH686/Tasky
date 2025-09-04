import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/core/utils/app_image.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/default_custom_buttong.dart';
import 'package:to_do_app/feature/auth/login/view/login_screen.dart';

class StartScreenBody extends StatelessWidget {
  const StartScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                stops: [0.9, 1.1],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              AppImage.tauth,
              width: AppWidthHeight.persantageOfWidth((408 / 375) * 100),
              height: AppWidthHeight.persantageOfHeight((438 / 812) * 100),
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: AppWidthHeight.persantageOfHeight((462 / 812) * 100),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        AppWidthHeight.persantageOfWidth((24.5 / 375) * 100)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppWidthHeight.persantageOfHeight((2 / 812) * 100),
                  children: [
                    Column(
                      children: [
                        Text(
                          AppString.kStartScreenTitle1,
                          style: AppTextStyle.regular24,
                        ),
                        Text(
                          AppString.kStartScreenTitle2,
                          style: AppTextStyle.regular24,
                        ),
                      ],
                    ),
                    Text(
                      AppString.kStartScreenSubTitle,
                      style: AppTextStyle.grey14,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      AppString.kStartScreenSubTitle2,
                      style: AppTextStyle.grey14,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      AppString.kStartScreenSubTitle3,
                      style: AppTextStyle.grey14,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height:
                          AppWidthHeight.persantageOfHeight((22 / 812) * 100),
                    ),
                    DefaultCustomButtong(
                      text: AppString.kLetisStart,
                      icon: AppIcon.tArrowF,
                      onTap: () {
                        AppRoute.navigateTo(const LoginScreen());
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
