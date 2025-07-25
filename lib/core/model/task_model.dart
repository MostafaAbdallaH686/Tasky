import 'package:to_do_app/core/network/api_keypoint.dart';

class TaskModel {
  final String id;
  final String? image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;
  final String createdAt;
  final String updatedAt;

  TaskModel({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json[ApiKeypoint.id],
      image:
          (json[ApiKeypoint.image] == null || json[ApiKeypoint.image] == "null")
              ? null
              : json[ApiKeypoint.image],
      title: json[ApiKeypoint.title],
      desc: json[ApiKeypoint.desc],
      priority: json[ApiKeypoint.priority],
      status: json[ApiKeypoint.status],
      user: json[ApiKeypoint.user],
      createdAt: json[ApiKeypoint.createdAt],
      updatedAt: json[ApiKeypoint.updatedAt],
    );
  }
}
