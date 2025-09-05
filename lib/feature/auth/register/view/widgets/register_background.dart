import 'package:flutter/material.dart';
import 'package:to_do_app/core/constants/register_constants.dart';
import 'package:to_do_app/core/utils/app_image.dart';

class RegisterBackground extends StatelessWidget {
  const RegisterBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: RegisterConstants.horizontalImagePadding),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return RegisterConstants.shaderGradient.createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          AppImage.tauth,
          width: RegisterConstants.imageWidth,
          height: RegisterConstants.imageHeight,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
