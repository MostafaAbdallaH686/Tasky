import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/failure/dio_exception.dart';
import 'package:to_do_app/core/model/user_model.dart';
import 'package:to_do_app/core/network/api_helper.dart';
import 'package:to_do_app/core/network/api_endpoint.dart';

class ProfileRepo {
  final ApiHelper apiHelper = ApiHelper();

  Future<Either<String, UserModel>> getProfile() async {
    try {
      final rawResponse =
          await apiHelper.get(endPoint: ApiEndpoint.profile, isAuth: true);

      if (rawResponse == null || rawResponse is! Map<String, dynamic>) {
        return left("Invalid profile response.");
      }

      final user = UserModel.fromJson(rawResponse);
      return right(user);
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left("Unexpected error: ${e.toString()}");
    }
  }
}
