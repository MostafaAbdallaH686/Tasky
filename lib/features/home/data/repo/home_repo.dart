import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/failure/dio_exception.dart';
import 'package:to_do_app/core/model/task_model.dart';
import 'package:to_do_app/core/network/api_endpoint.dart';
import 'package:to_do_app/core/network/api_helper.dart';
import 'package:to_do_app/core/network/api_keypoint.dart';

class HomeRepo {
  HomeRepo._();

  static HomeRepo? _instance;
  factory HomeRepo() => _instance ??= HomeRepo._();

  final ApiHelper apiHelper = ApiHelper();

  Future<Either<String, List<TaskModel>>> getTasks() async {
    try {
      final response = await apiHelper.get(
        endPoint: ApiEndpoint.tasks,
        isAuth: true,
      );

      if (response is! List) {
        return left('Unexpected response format: expected List');
      }

      final tasks = response
          .map((json) => TaskModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return right(tasks);
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Unexpected error: ${e.toString()}");
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
