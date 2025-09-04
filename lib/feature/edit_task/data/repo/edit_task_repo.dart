import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/dio/dio_exception.dart';
import 'package:to_do_app/feature/home/data/model/home_model.dart';
import 'package:to_do_app/core/helper/api_endpoint.dart';
import 'package:to_do_app/core/helper/api_helper.dart';
import 'package:to_do_app/core/helper/api_keypoint.dart';
import 'package:to_do_app/feature/edit_task/data/model/edit_task_model.dart';

class EditTaskRepo {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<String, String>> uploadImage(File file) async {
    try {
      final response = await apiHelper.uploadFile(
        endPoint: ApiEndpoint.uploadphoto,
        isAuth: true,
        file: file,
        fileField: ApiKeypoint.image,
      );

      final imagePath = response[ApiKeypoint.image];
      if (imagePath != null && imagePath.toString().isNotEmpty) {
        return right(imagePath);
      } else {
        return left("Image upload failed.");
      }
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Unexpected error: ${e.toString()}");
    }
  }

  Future<Either<String, String>> updateTask({
    required String taskId,
    required EditTaskModel task,
  }) async {
    try {
      final response = await apiHelper.put(
        endPoint: "${ApiEndpoint.newTasks}/$taskId",
        data: task.toMap(),
        isAuth: true,
      );
      final msg = response[ApiKeypoint.message] ?? "Task updated successfully";
      return right(msg);
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Update error: ${e.toString()}");
    }
  }

  Future<Either<String, TasksModel>> getTask({
    required String taskId,
  }) async {
    try {
      final response = await apiHelper.get(
        endPoint: "${ApiEndpoint.newTasks}/$taskId",
        isAuth: true,
      );

      final taskData = response['data'];
      final task = TasksModel.fromJson(taskData);
      return right(task);
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Fetch error: ${e.toString()}");
    }
  }

  Future<Either<String, String>> deleteTask(String taskId) async {
    try {
      final response = await apiHelper.delete(
        endPoint: "${ApiEndpoint.newTasks}/$taskId",
        isAuth: true,
      );

      final msg = response[ApiKeypoint.message] ?? "Task deleted successfully";
      return right(msg);
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Delete error: ${e.toString()}");
    }
  }
}
