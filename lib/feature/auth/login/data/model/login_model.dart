import 'package:to_do_app/core/helper/api_keypoint.dart';

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

class UserLoginModel {
  final String displayName;
  final int id;

  UserLoginModel({
    required this.displayName,
    required this.id,
  });

  factory UserLoginModel.fromJson(Map json) {
    return UserLoginModel(
      displayName: json[ApiKeypoint.displayName],
      id: json[ApiKeypoint.id],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKeypoint.phone: displayName,
      ApiKeypoint.id: id,
    };
  }
}
