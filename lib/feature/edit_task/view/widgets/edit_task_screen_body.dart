import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/widgets/custom_circle_progress_inicator.dart';
import 'package:to_do_app/feature/edit_task/cubit/edit_task_cubit.dart';
import 'package:to_do_app/feature/edit_task/view/widgets/date_input_field.dart';
import 'package:to_do_app/feature/edit_task/view/widgets/priority_dropdown.dart';
import 'package:to_do_app/feature/edit_task/view/widgets/qr_code_section.dart';
import 'package:to_do_app/feature/edit_task/view/widgets/status_dropdown.dart';
import 'package:to_do_app/feature/edit_task/view/widgets/task_content_section.dart';
import 'package:to_do_app/feature/edit_task/view/widgets/task_image_selection.dart';

class EditTaskScreenBody extends StatelessWidget {
  const EditTaskScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = EditTaskCubit.get(context);

    return BlocBuilder<EditTaskCubit, EditTaskState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is EditTaskLoading) {
          return const Center(child: CustomCircleProgressInicator());
        }

        if (state is EditTaskError) {
          return Center(child: Text("Error: ${state.errMessage}"));
        }

        return SingleChildScrollView(
          child: Form(
            key: cubit.globalKey,
            autovalidateMode: cubit.autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskImageSection(imagePath: cubit.existingImagePath),
                SizedBox(
                    height: AppWidthHeight.persantageOfHeight(16 / 812 * 100)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppWidthHeight.persantageOfWidth(6.4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskTextSection(
                        title: cubit.titleController.text,
                        description: cubit.descriptionController.text,
                      ),
                      SizedBox(
                          height: AppWidthHeight.persantageOfHeight(
                              16 / 812 * 100)),
                      Column(
                        children: [
                          DateField(
                            dateText: cubit.dateController.text,
                            onDateSelected: (date) {
                              cubit.dateController.text = date;
                              cubit.onUpdate(
                                taskId: cubit.taskId!,
                                userId: cubit.userId!,
                                currentImage: cubit.existingImagePath ?? '',
                              );
                            },
                          ),
                          SizedBox(
                              height: AppWidthHeight.persantageOfHeight(
                                  8 / 812 * 100)),
                          StatusDropdown(
                            value: cubit.selectedStatus,
                            onChanged: (val) {
                              cubit.selectedStatus = val!;
                              cubit.onUpdate(
                                taskId: cubit.taskId!,
                                userId: cubit.userId!,
                                currentImage: cubit.existingImagePath ?? '',
                              );
                            },
                          ),
                          SizedBox(
                              height: AppWidthHeight.persantageOfHeight(
                                  8 / 812 * 100)),
                          PriorityDropdown(
                            value: cubit.selectedPriority,
                            onChanged: (val) {
                              cubit.selectedPriority = val!;
                              cubit.onUpdate(
                                taskId: cubit.taskId!,
                                userId: cubit.userId!,
                                currentImage: cubit.existingImagePath ?? '',
                              );
                            },
                          ),
                          QrCodeWidget(taskId: cubit.taskId!),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
