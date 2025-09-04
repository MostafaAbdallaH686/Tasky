import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/widgets/custom_my_app_bar.dart';
import 'package:to_do_app/feature/profile/cubit/profile_cubit.dart';
import 'package:to_do_app/feature/profile/view/widgets/profile_screen_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProfileCubit();
        cubit.getProfile();
        return cubit;
      },
      child: Scaffold(
        appBar: CustomMyAppBar(title: "Profile"),
        body: ProfileScreenBody(),
      ),
    );
  }
}
