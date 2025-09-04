import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/feature/home/data/model/home_model.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/feature/edit_task/cubit/edit_task_cubit.dart';
import 'package:to_do_app/feature/edit_task/view/edit_task_screen.dart';
import 'package:to_do_app/feature/home/cubit/home_cubit.dart';
import 'package:to_do_app/feature/home/view/home_screen.dart';

class CusompopupMenuButton extends StatelessWidget {
  const CusompopupMenuButton({
    super.key,
    this.task,
    this.isInEditScreen = false,
  });

  final bool isInEditScreen;
  final TasksModel? task;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      borderRadius: BorderRadius.circular(
          AppWidthHeight.persantageOfWidth((12 / 375) * 100)),
      elevation: 10,
      shadowColor: AppLightColor.black,
      padding: EdgeInsets.zero,
      offset: const Offset(0, 33),
      constraints: const BoxConstraints(),
      color: AppLightColor.white,
      icon: Icon(Icons.more_vert,
          size: AppWidthHeight.persantageOfWidth((24 / 375) * 100)),
      onSelected: (value) async {
        if (task == null) {
          return;
        }

        HomeCubit? homeCubit;
        EditTaskCubit? editCubit;

        try {
          homeCubit = HomeCubit.get(context);
        } catch (e) {
          log(" Could not get HomeCubit: $e");
        }

        try {
          editCubit = EditTaskCubit.get(context);
        } catch (e) {
          log(" Could not get EditTaskCubit: $e");
        }

        if (value == 'edit') {
        } else if (value == 'delete') {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Confirm Deletion"),
              content: const Text("Are you sure you want to delete this task?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text("Delete"),
                ),
              ],
            ),
          );

          if (confirmed != true) return;

          try {
            if (isInEditScreen && editCubit != null) {
              await editCubit.deleteTaskById(task!.id);
            } else if (homeCubit != null) {
              await homeCubit.deleteTaskById(task!.id);
              homeCubit.getAllTasks();
            }

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Task deleted')),
              );
              AppRoute.navigateTo(const HomeScreen());
            }
          } catch (e) {
            log(" Error during deletion: $e");
          }
        }
        if (value == 'edit') {
          if (isInEditScreen) {
            return;
          }
          if (context.mounted) {
            AppRoute.navigateTo(
              EditTaskScreen(
                task: task!,
              ),
            );
          }
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 30,
          value: 'edit',
          child: Text(
            'Edit',
            style: AppTextStyle.dotsdrawer(color: AppLightColor.blackedit),
          ),
        ),
        PopupMenuItem(
          height: 30,
          value: 'delete',
          child: Text(
            'Delete',
            style: AppTextStyle.dotsdrawer(color: AppLightColor.statusWaiting),
          ),
        ),
      ],
    );
  }
}
