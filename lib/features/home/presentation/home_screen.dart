import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/cache/cache_helper.dart';
import 'package:to_do_app/core/cache/shared_preferenece_key.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/features/add_task/presentation/add_task_screen.dart';
import 'package:to_do_app/features/auth/login/presentation/login_screen.dart';
import 'package:to_do_app/features/home/manager/home_cubit.dart/home_cubit.dart';
import 'package:to_do_app/features/home/presentation/widget/home_screen_body.dart';
import 'package:to_do_app/features/profile/presentation/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppLightColor.white,
          automaticallyImplyLeading: false,
          titleSpacing: AppWidthHeight.persantageOfWidth((24 / 375) * 100),
          title: Text(
            textScaler: TextScaler.linear(
              AppWidthHeight.persantageOfWidth((1 / 375) * 100),
            ),
            AppString.kHomeScreen,
            style: AppTextStyle.regular24.copyWith(height: 1.0),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppWidthHeight.persantageOfWidth((16 / 375) * 100),
              ),
              child: Row(
                spacing: AppWidthHeight.persantageOfWidth((22 / 375) * 100),
                children: [
                  SizedBox(
                    width: AppWidthHeight.persantageOfWidth((24 / 375) * 100),
                  ),
                  GestureDetector(
                    child: AppSvgImage.showSvgImage(path: AppIcon.tperson),
                    onTap: () => AppRoute.navigateTo(const ProfileScreen()),
                  ),
                  GestureDetector(
                      child: AppSvgImage.showSvgImage(path: AppIcon.tArrrowgo),
                      onTap: () {
                        CacheHelper cacheHelper = CacheHelper();
                        AppRoute.navigateToAndDeleteAllPathRoute(
                            const LoginScreen());
                        cacheHelper.saveData(
                            key: SharedPrefereneceKey.isLogin, value: false);
                      })
                ],
              ),
            )
          ],
        ),
        body: Builder(builder: (context) {
          return HomeScreenBody();
        }),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'fab1',
                  onPressed: () {},
                  mini: true,
                  shape: const CircleBorder(),
                  tooltip: 'Add',
                  backgroundColor: AppLightColor.greyfloatingbuttom,
                  child: AppSvgImage.showSvgImage(path: AppIcon.tcatfloating),
                ),
                SizedBox(
                    height: AppWidthHeight.persantageOfHeight((7 / 812) * 100)),
                FloatingActionButton(
                  foregroundColor: AppLightColor.blue,
                  elevation: 10,
                  splashColor: AppLightColor.blue,
                  heroTag: 'fab2',
                  onPressed: () {
                    AppRoute.navigateTo(const AddTaskScreen());
                  },
                  shape: const CircleBorder(),
                  tooltip: 'add',
                  backgroundColor: AppLightColor.blue,
                  child: AppSvgImage.showSvgImage(path: AppIcon.taddfloating),
                ),
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
