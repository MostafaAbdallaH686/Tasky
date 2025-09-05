import 'package:flutter/material.dart';
import 'package:to_do_app/core/constants/login_constants.dart';
import 'package:to_do_app/core/utils/app_image.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LoginConstants.shaderGradient.createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(
        AppImage.tauth,
        width: LoginConstants.imageWidth,
        height: LoginConstants.imageHeight,
        fit: BoxFit.fill,
      ),
    );
  }
}
