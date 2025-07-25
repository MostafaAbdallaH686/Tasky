import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/failure/dio_exception.dart';
import 'package:to_do_app/core/network/api_endpoint.dart';
import 'package:to_do_app/core/network/api_helper.dart';
import 'package:to_do_app/core/network/api_keypoint.dart';
import 'package:to_do_app/features/add_task/data/model/task_model.dart';

class AddTaskRepo {
  final ApiHelper apiHelper = ApiHelper();
  Future<Either<String, String>> uploadImage(File file) async {
    try {
      final response = await apiHelper.uploadFile(
        endPoint: ApiEndpoint.uploadphoto,
        isAuth: true,
        file: file,
        fileField: ApiKeypoint.image,
      );

      if (response != null &&
          response is Map<String, dynamic> &&
          response.containsKey(ApiKeypoint.image) &&
          response[ApiKeypoint.image] != null &&
          response[ApiKeypoint.image].toString().isNotEmpty) {
        final imagePath = response[ApiKeypoint.image];
        return right(imagePath);
      } else {
        return left("Invalid image upload response.");
      }
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Image upload error: ${e.toString()}");
    }
  }

  Future<Either<String, String>> addTask(
      {required String title,
      required String desc,
      required String priority,
      required String image,
      required String dueDate}) async {
    try {
      final task = TaskModel(
        dueDate: dueDate,
        title: title,
        desc: desc,
        priority: priority,
        image: image,
      );

      final response = await apiHelper.post(
        endPoint: ApiEndpoint.newTasks,
        data: task.toMap(),
        isAuth: true,
      );

      final message =
          response[ApiKeypoint.message] ?? "Task created successfully";
      return right(message);
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Unexpected error: ${e.toString()}");
    }
  }
}
