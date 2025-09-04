import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/feature/home/data/model/home_model.dart';
import 'package:to_do_app/core/widgets/custom_menu_button.dart';
import 'package:to_do_app/core/widgets/custom_my_app_bar.dart';
import 'package:to_do_app/feature/edit_task/cubit/edit_task_cubit.dart';
import 'package:to_do_app/feature/edit_task/view/widgets/edit_task_screen_body.dart';

class EditTaskScreen extends StatelessWidget {
  final TasksModel task;

  const EditTaskScreen({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EditTaskCubit()..initializeWithTask(task),
        child: Scaffold(
          appBar: CustomMyAppBar(
              title: "Task Details",
              trailing: CusompopupMenuButton(isInEditScreen: true, task: task)),
          body: EditTaskScreenBody(),
        ));
  }
}
