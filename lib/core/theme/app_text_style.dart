import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';

abstract class AppTextStyle {
  static const TextStyle regular24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppLightColor.black,
  );
  static const TextStyle regularH24 = TextStyle(
    fontSize: 24,
    height: 3,
    fontWeight: FontWeight.w700,
    color: AppLightColor.black,
  );
  static final TextStyle bold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    // ignore: deprecated_member_use
    color: AppLightColor.cardsubtext.withOpacity(.4),
  );
  static final TextStyle cardtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    // ignore: deprecated_member_use
    color: AppLightColor.cardtitletext.withOpacity(.6),
  );

  static const TextStyle regular9 = TextStyle(
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: AppLightColor.grey,
  );
  static const TextStyle regular12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppLightColor.grey,
  );
  static const TextStyle regular19 = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    color: AppLightColor.statusInprogress,
  );
  static const TextStyle regular14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppLightColor.grey,
  );
  static const TextStyle titleaddtask = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppLightColor.titleaddtask,
  );
  static const TextStyle regular16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppLightColor.white,
  );

  static const TextStyle edit16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppLightColor.blackedit,
  );
  static const TextStyle regularB16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppLightColor.black,
  );
  static const TextStyle regularB24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppLightColor.black,
  );
  static const TextStyle regularBh16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppLightColor.black,
      height: 24);
  static const TextStyle grey14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppLightColor.grey,
  );
  static const TextStyle blue14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppLightColor.blue,
  );
  static const TextStyle blue12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppLightColor.blue,
  );
  static const TextStyle blue16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppLightColor.blue,
  );
  static TextStyle bold19({Color color = AppLightColor.white}) => TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w700,
        color: color,
      );
  static TextStyle priority12({Color color = AppLightColor.white}) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      );
  static TextStyle priority16({Color color = AppLightColor.white}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color,
      );
  static TextStyle status12({Color color = AppLightColor.white}) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static const TextStyle light14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppLightColor.black,
  );
  static const TextStyle regularB14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppLightColor.black,
  );
  static const TextStyle bold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppLightColor.grey,
  );
  static const TextStyle boldB16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppLightColor.black,
  );
  static const TextStyle light16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppLightColor.black,
  );
  static const TextStyle lightw12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppLightColor.black,
  );

  static TextStyle dotsdrawer({Color color = AppLightColor.kTextblack}) =>
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );
  static TextStyle extraLight14(Color color) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      );
}
