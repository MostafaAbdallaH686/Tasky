import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_snak_bar.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/custom_circle_progress_inicator.dart';
import 'package:to_do_app/core/widgets/default_custom_buttong.dart';
import 'package:to_do_app/feature/add_task/cubit/add_task_cubit.dart';
import 'package:to_do_app/feature/home/view/home_screen.dart';

class SubmitButton extends StatelessWidget {
  final AddTaskCubit cubit;

  const SubmitButton({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskError) {
          AppSnakBar.showSnakBar(title: "Error", message: state.errMessage);
        } else if (state is AddTaskSuccess) {
          AppRoute.navigateToAndNoBack(const HomeScreen());
        }
      },
      builder: (context, state) {
        if (state is AddTaskLoading) {
          return const CustomCircleProgressInicator();
        }
        return DefaultCustomButtong(
          onTap: cubit.onTap,
          text: AppString.addScreen,
        );
      },
    );
  }
}
