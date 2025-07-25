import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/utils/app_icon.dart';

// Status container background color
Color getStatusContainerColor(String status) {
  switch (status.toLowerCase()) {
    case 'waiting':
      return AppLightColor.statusWaitingContainer;
    case 'inprogress':
      return AppLightColor.statusInprogressContainer;
    case 'finished':
      return AppLightColor.statusFinisheContainer;
    default:
      return Colors.grey;
  }
}

String? getFullImageUrl(String? image) {
  if (image != null && image.toLowerCase() != "null") {
    final cleanImage = image.trim().replaceAll(RegExp(r'[<>]'), '');

    return 'https://todo.iraqsapp.com/images/$cleanImage';
  }
  return null;
}

// Status container background color
double getStatusContainerwidth(String status) {
  switch (status.toLowerCase()) {
    case 'waiting':
      return AppWidthHeight.persantageOfWidth((55 / 375) * 100);
    case 'inprogress':
      return AppWidthHeight.persantageOfWidth((72 / 375) * 100);
    case 'finished':
      return AppWidthHeight.persantageOfWidth((60 / 375) * 100);
    default:
      return AppWidthHeight.persantageOfWidth((60 / 375) * 100);
  }
}

// Status text color
Color getStatusTextColor(String status) {
  switch (status.toLowerCase()) {
    case 'waiting':
      return AppLightColor.statusWaiting;
    case 'inprogress':
      return AppLightColor.statusInprogress;
    case 'finished':
      return AppLightColor.statusFinished;
    default:
      return Colors.black;
  }
}

// Flag icon based on priority
String getPriorityIcon(String priority) {
  switch (priority.toLowerCase()) {
    case 'low':
      return AppIcon.tFlagLow;
    case 'medium':
      return AppIcon.tFlagmedium;
    case 'high':
      return AppIcon.tFlaghigh;
    default:
      return AppIcon.tFlagLow;
  }
}

// Priority text color
Color getPriorityTextColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'low':
      return AppLightColor.statusFinished;
    case 'medium':
      return AppLightColor.statusInprogress;
    case 'high':
      return AppLightColor.statusWaiting;
    default:
      return Colors.black;
  }
}
