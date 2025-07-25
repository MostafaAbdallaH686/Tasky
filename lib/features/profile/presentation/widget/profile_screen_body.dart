import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/features/profile/presentation/manager/profile_cubit.dart';
import 'package:to_do_app/features/profile/presentation/manager/profile_state.dart';
import 'package:to_do_app/features/profile/presentation/widget/custom_card.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileFailingState) {
          return Center(child: Text(" ${state.errMessage}"));
        } else if (state is ProfileSuccessState) {
          final user = state.user;

          return Column(
            children: [
              SizedBox(
                height: AppWidthHeight.persantageOfHeight((24 / 812) * 100),
              ),
              CustomCardProfile(
                  title: "NAME", subtitle: user.displayName ?? ""),
              CustomCardProfile(
                title: "PHONE",
                subtitle: user.phone,
                showSvg: true,
              ),
              CustomCardProfile(title: "LEVEL", subtitle: user.level ?? ""),
              CustomCardProfile(
                  title: "Years of experience",
                  subtitle: "${user.experienceYears ?? 0} years"),
              CustomCardProfile(
                  title: "Location", subtitle: user.address ?? ""),
            ],
          );
        } else {
          return const SizedBox(
            child: Text("dafaf"),
          );
        }
      },
    );
  }
}
