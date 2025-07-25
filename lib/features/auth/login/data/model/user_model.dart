import 'package:to_do_app/core/network/api_keypoint.dart';

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
