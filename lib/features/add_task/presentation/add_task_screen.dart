import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/widget/custom_my_app_bar.dart';
import 'package:to_do_app/features/add_task/manager/add_task_cubit/cubit/add_task_cubit.dart';
import 'package:to_do_app/features/add_task/presentation/widget/add_task_screen_body.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddTaskCubit(),
        child: Scaffold(
          appBar: CustomMyAppBar(title: "Add new task"),
          body: AddTaskScreenBody(),
        ));
  }
}
