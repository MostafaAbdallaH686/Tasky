import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/model/user_model.dart';
import 'package:to_do_app/feature/profile/data/profile_repo.dart';
import 'package:to_do_app/feature/profile/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final ProfileRepo profileRepo = ProfileRepo();

  UserModel? profile;

  void getProfile() async {
    emit(ProfileLoadingState());

    final response = await profileRepo.getProfile();

    response.fold(
      (error) {
        emit(ProfileFailingState(errMessage: error));
      },
      (user) {
        profile = user;
        emit(ProfileSuccessState(user: user));
      },
    );
  }
}
