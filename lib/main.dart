import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:to_do_app/core/cache/cache_helper.dart';
import 'package:to_do_app/core/theme/app_theme_data.dart';
import 'package:to_do_app/feature/onboarding/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      theme: AppThemeData.lightThemeData,
      home: SplashScreen(),
    );
  }
}
