import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/widgets/custom_my_app_bar.dart';
import 'package:to_do_app/feature/add_task/cubit/add_task_cubit.dart';
import 'package:to_do_app/feature/add_task/view/widgets/add_task_screen_body.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddTaskCubit(),
        child: Scaffold(
          appBar: CustomMyAppBar(title: "Add new task"),
          body: const AddTaskScreenBody(),
        ));
  }
}
