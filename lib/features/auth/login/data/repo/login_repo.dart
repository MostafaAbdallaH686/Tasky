import 'package:dartz/dartz.dart';
import 'package:to_do_app/core/cache/cache_helper.dart';
import 'package:to_do_app/core/cache/shared_preferenece_key.dart';
import 'package:to_do_app/core/failure/dio_exception.dart';
import 'package:to_do_app/core/model/user_model.dart';
import 'package:to_do_app/core/network/api_endpoint.dart';
import 'package:to_do_app/core/network/api_helper.dart';
import 'package:to_do_app/core/shared/user_service.dart';
import 'package:to_do_app/features/auth/login/data/model/login_model.dart';

class LoginRepo {
  UserService userService = UserService();

  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, LoginModel>> login(
      {required String phone, required String password}) async {
    try {
      CacheHelper cacheHelper = CacheHelper();
      UserModel userModel = UserModel(phone: phone, password: password);
      var data = await userModel.toMap();
      var response =
          await apiHelper.post(endPoint: ApiEndpoint.login, data: data);
      LoginModel loginModel = LoginModel.fromJson(response);

      await cacheHelper.saveData(
          key: SharedPrefereneceKey.isLogin, value: true);
      await cacheHelper.saveData(
          key: SharedPrefereneceKey.accesstoken, value: loginModel.accesstoken);
      await cacheHelper.saveData(
          key: SharedPrefereneceKey.refreshtoken,
          value: loginModel.refreshtoken);
      await cacheHelper.saveData(
          key: SharedPrefereneceKey.phone, value: loginModel.user.displayName);

      userService.loginModel = loginModel;

      return right(loginModel);
    } on CustomDioException catch (e) {
      return left(e.errMessage);
    } catch (e) {
      return left(e.toString());
    }
  }
}
