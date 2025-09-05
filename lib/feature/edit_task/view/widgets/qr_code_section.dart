import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/helper/api_endpoint.dart';

class QrCodeWidget extends StatelessWidget {
  final String taskId;

  const QrCodeWidget({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppWidthHeight.persantageOfHeight(16 / 812 * 100)),
      child: QrImageView(
        data: "${ApiBaseUrl.baseUrl}${ApiEndpoint.newTasks}/$taskId",
        version: QrVersions.auto,
        size: AppWidthHeight.persantageOfWidth(310 / 375 * 100),
        backgroundColor: Colors.white,
      ),
    );
  }
}
