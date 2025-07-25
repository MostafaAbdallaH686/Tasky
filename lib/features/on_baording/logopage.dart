import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/cache/cache_helper.dart';
import 'package:to_do_app/core/cache/shared_preferenece_key.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/features/auth/login/presentation/login_screen.dart';
import 'package:to_do_app/features/home/presentation/home_screen.dart';
import 'package:to_do_app/features/on_baording/start_screen/presentation/start_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      final cacheHelper = CacheHelper();

      final isFirstTime =
          cacheHelper.getData(key: SharedPrefereneceKey.isFirstTime) as bool? ??
              true;
      final isLoggedIn =
          cacheHelper.getData(key: SharedPrefereneceKey.isLogin) as bool? ??
              false;

      if (isFirstTime) {
        await cacheHelper.saveData(
            key: SharedPrefereneceKey.isFirstTime, value: false);
        AppRoute.navigateToAndNoBack(const StartScreen());
      } else if (isLoggedIn) {
        AppRoute.navigateToAndNoBack(const HomeScreen());
      } else {
        AppRoute.navigateToAndNoBack(const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppLightColor.blue),
        child: Center(child: SvgPicture.asset(AppIcon.tSplash)),
      ),
    );
  }
}
