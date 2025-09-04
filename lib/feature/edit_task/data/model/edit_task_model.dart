import 'package:to_do_app/core/helper/api_keypoint.dart';

class EditTaskModel {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;

  EditTaskModel({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      ApiKeypoint.image: image,
      ApiKeypoint.title: title,
      ApiKeypoint.desc: desc,
      ApiKeypoint.priority: priority,
      ApiKeypoint.status: status,
      ApiKeypoint.user: user,
    };
  }
}
