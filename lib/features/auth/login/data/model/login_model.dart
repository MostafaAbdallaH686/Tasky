import 'package:to_do_app/core/network/api_keypoint.dart';
import 'package:to_do_app/features/auth/login/data/model/user_model.dart';

class LoginModel {
  final String accesstoken;
  final String refreshtoken;
  final bool status;
  final UserLoginModel user;

  LoginModel(
      {required this.accesstoken,
      required this.refreshtoken,
      required this.status,
      required this.user});

  factory LoginModel.fromJson(Map json) {
    return LoginModel(
      accesstoken: json[ApiKeypoint.accesstoken] as String? ?? '',
      refreshtoken: json[ApiKeypoint.refreshtoken] as String? ?? '',
      status:
          json[ApiKeypoint.status] is bool ? json[ApiKeypoint.status] : false,
      user: json[ApiKeypoint.user] is Map
          ? UserLoginModel.fromJson(json[ApiKeypoint.user])
          : UserLoginModel(displayName: '', id: 0),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ApiKeypoint.accesstoken: accesstoken,
      ApiKeypoint.refreshtoken: refreshtoken,
      ApiKeypoint.status: status,
      ApiKeypoint.user: user.toJson(),
    };
  }
}
