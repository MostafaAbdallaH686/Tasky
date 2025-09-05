import 'package:flutter/material.dart';
import 'package:to_do_app/core/constants/add_task_constants.dart';
import 'package:to_do_app/feature/add_task/cubit/add_task_cubit.dart';
import 'package:to_do_app/feature/add_task/view/widgets/image_picker_section.dart';
import 'package:to_do_app/feature/add_task/view/widgets/submit_button.dart';
import 'package:to_do_app/feature/add_task/view/widgets/task_form_section.dart';

class AddTaskScreenBody extends StatelessWidget {
  const AddTaskScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AddTaskCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AddTaskConstants.verticalPadding,
        horizontal: AddTaskConstants.horizontalPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImagePickerSection(cubit: cubit),
            SizedBox(height: AddTaskConstants.mediumSpacing),
            TaskFormSection(cubit: cubit),
            SizedBox(height: AddTaskConstants.largeSpacing),
            SubmitButton(cubit: cubit),
          ],
        ),
      ),
    );
  }
}
