import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/core/constants/add_task_constants.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/default_text_form_filed.dart';
import 'package:to_do_app/feature/add_task/cubit/add_task_cubit.dart';
import 'package:to_do_app/feature/add_task/view/widgets/priorty_drop_down.dart';

class TaskFormSection extends StatelessWidget {
  final AddTaskCubit cubit;

  const TaskFormSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return Form(
          key: cubit.globalKey,
          autovalidateMode: cubit.autovalidateMode,
          child: Column(
            spacing: AddTaskConstants.mediumSpacing,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleSection(cubit),
              _buildDescriptionSection(cubit),
              _buildPrioritySection(cubit),
              _buildDatePickerSection(cubit, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleSection(AddTaskCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppString.titletask),
        DefaultTextFormFiled(
          hint: AppString.title,
          controller: cubit.titleController,
          validator: cubit.validatorTitle,
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(AddTaskCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppString.descriptiontask),
        DefaultTextFormFiled(
          maxLines: 8,
          minLines: 5,
          hint: AppString.description,
          controller: cubit.descriptionController,
          validator: cubit.validatorDescription,
        ),
      ],
    );
  }

  Widget _buildPrioritySection(AddTaskCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppString.priority),
        PriorityDropdown(
          cubit: cubit,
          onChanged: (value) => cubit.selectedPriority = value,
        ),
      ],
    );
  }

  Widget _buildDatePickerSection(AddTaskCubit cubit, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppString.datetitle),
        DefaultTextFormFiled(
          hint: "Select a date",
          controller: cubit.dateController,
          passwordSuffixIcon: InkWell(
            onTap: () => _showDatePickerDialog(context, cubit),
            child: AppSvgImage.showSvgImage(
              path: AppIcon.tdate,
              width: AddTaskConstants.iconSize,
              height: AddTaskConstants.iconSize,
              fit: BoxFit.scaleDown,
            ),
          ),
          onTapSuffixIcon: () {},
          validator: (_) => null,
        ),
      ],
    );
  }

  Future<void> _showDatePickerDialog(
      BuildContext context, AddTaskCubit cubit) async {
    DateTime? selectedDate;
    DateTime focusedDay = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: AddTaskConstants.calendarHeight,
            child: StatefulBuilder(
              builder: (context, setState) {
                return TableCalendar(
                  daysOfWeekHeight: 32,
                  firstDay: DateTime.utc(2010, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDate = selected;
                      focusedDay = focused;
                    });
                    cubit.dateController.text =
                        DateFormat('yyyy-MM-dd').format(selected);
                    Navigator.pop(context);
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      textScaler: AddTaskConstants.textScaler,
      style: AppTextStyle.titleaddtask,
    );
  }
}
