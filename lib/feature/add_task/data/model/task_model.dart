import 'package:to_do_app/core/helper/api_keypoint.dart';

class TaskModel {
  final String title;
  final String desc;
  final String priority;
  final String image;
  final String dueDate;
  TaskModel({
    required this.title,
    required this.desc,
    required this.priority,
    required this.dueDate,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      ApiKeypoint.title: title,
      ApiKeypoint.desc: desc,
      ApiKeypoint.priority: priority,
      ApiKeypoint.image: image,
      ApiKeypoint.dueDate: dueDate,
    };
  }
}
