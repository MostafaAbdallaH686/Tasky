import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/dio/dio_exception.dart';
import 'package:to_do_app/core/shared/user_model.dart';
import 'package:to_do_app/core/helper/api_endpoint.dart';
import 'package:to_do_app/core/helper/api_helper.dart';
import 'package:to_do_app/core/helper/api_keypoint.dart';

class RegisterRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, String>> register({
    required String phone,
    required String password,
    required String displayName,
    required int experienceYears,
    required String address,
    required String level,
  }) async {
    try {
      UserModel user = UserModel(
        phone: phone,
        password: password,
        displayName: displayName,
        experienceYears: experienceYears,
        address: address,
        level: level,
      );

      final data = await user.toMap();

      final rawResponse = await apiHelper.post(
        endPoint: ApiEndpoint.register,
        data: data,
      );

      if (rawResponse == null || rawResponse is! Map) {
        return left("Invalid response from server.");
      }

      final response = rawResponse as Map<String, dynamic>;

      final message =
          response[ApiKeypoint.message] ?? "Registered successfully.";
      return right(message);
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Unexpected error: ${e.toString()}");
    }
  }
}
