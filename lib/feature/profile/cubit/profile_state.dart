import 'package:to_do_app/core/shared/user_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final UserModel user;
  ProfileSuccessState({required this.user});
}

class ProfileFailingState extends ProfileState {
  final String errMessage;
  ProfileFailingState({required this.errMessage});
}
