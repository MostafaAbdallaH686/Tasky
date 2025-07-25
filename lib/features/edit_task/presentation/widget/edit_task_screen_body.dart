import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/function/home_function.dart';
import 'package:to_do_app/core/network/api_endpoint.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/core/widget/custom_circle_progress_inicator.dart';
import 'package:to_do_app/core/widget/default_text_form_filed.dart';
import 'package:to_do_app/features/edit_task/manager/edit_task_cubit.dart';
import 'package:to_do_app/features/home/presentation/widget/image_widget.dart';

class EditTaskScreenBody extends StatelessWidget {
  const EditTaskScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = EditTaskCubit.get(context);

    return BlocBuilder<EditTaskCubit, EditTaskState>(builder: (context, state) {
      if (state is EditTaskLoading) {
        return const Center(child: CustomCircleProgressInicator());
      }

      if (state is EditTaskError) {
        return Center(child: Text("Error: ${state.errMessage}"));
      }

      if (state is EditTaskFetched ||
          state is EditTaskInitial ||
          state is EditTaskImagePicked) {
        return SingleChildScrollView(
          child: Form(
            key: cubit.globalKey,
            autovalidateMode: cubit.autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTaskImage(
                    cubit.existingImagePath,
                    AppWidthHeight.persantageOfWidth((375 / 375) * 100),
                    AppWidthHeight.persantageOfHeight((225 / 812) * 100)),
                SizedBox(
                    height:
                        AppWidthHeight.persantageOfHeight((16 / 812) * 100)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppWidthHeight.persantageOfWidth(6.4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.titleController.text,
                        style: AppTextStyle.regularB24,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textScaler: TextScaler.linear(
                          AppWidthHeight.persantageOfWidth((1 / 375) * 100),
                        ),
                      ),
                      Text(
                        textScaler: TextScaler.linear(
                          AppWidthHeight.persantageOfWidth((1 / 375) * 100),
                        ),
                        cubit.descriptionController.text,
                        style: AppTextStyle.regular14,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                          height: AppWidthHeight.persantageOfHeight(
                              (16 / 812) * 100)),
                      Column(
                        spacing:
                            AppWidthHeight.persantageOfHeight((8 / 812) * 100),
                        children: [
                          DefaultTextFormFiled(
                            hint: "End date",
                            controller: cubit.dateController,
                            passwordSuffixIcon: InkWell(
                              onTap: () async {
                                DateTime? selectedDate;
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    DateTime focusedDay = DateTime.now();
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      content: SizedBox(
                                        height:
                                            AppWidthHeight.persantageOfHeight(
                                                (400 / 812) * 100),
                                        child: StatefulBuilder(
                                          builder: (context, setState) {
                                            return TableCalendar(
                                              firstDay:
                                                  DateTime.utc(2010, 1, 1),
                                              lastDay:
                                                  DateTime.utc(2030, 12, 31),
                                              focusedDay: focusedDay,
                                              selectedDayPredicate: (day) =>
                                                  isSameDay(day, selectedDate),
                                              onDaySelected:
                                                  (selected, focused) {
                                                setState(() {
                                                  selectedDate = selected;
                                                  focusedDay = focused;
                                                });
                                                cubit.dateController.text =
                                                    DateFormat('dd MMM yyyy')
                                                        .format(selected);
                                                Navigator.pop(context);
                                              },
                                              calendarStyle: CalendarStyle(
                                                todayDecoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  shape: BoxShape.circle,
                                                ),
                                                selectedDecoration:
                                                    BoxDecoration(
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
                              },
                              child: AppSvgImage.showSvgImage(
                                path: AppIcon.tdate,
                                width: AppWidthHeight.persantageOfWidth(
                                    (24 / 375) * 100),
                                height: AppWidthHeight.persantageOfHeight(
                                    (24 / 812) * 100),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),

                          /// Status Dropdown
                          DropdownButtonFormField<String>(
                            value: cubit.selectedStatus,
                            icon: AppSvgImage.showSvgImage(
                              path: AppIcon.tArrowdown,
                              width: AppWidthHeight.persantageOfWidth(
                                  (24 / 375) * 100),
                              height: AppWidthHeight.persantageOfHeight(
                                  (24 / 812) * 100),
                            ),
                            items: [
                              {'label': 'Waiting', 'value': 'waiting'},
                              {'label': 'In Progress', 'value': 'inProgress'},
                              {'label': 'Finished', 'value': 'finished'},
                            ].map((item) {
                              final label = item['label']!;
                              final value = item['value']!;
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: AppWidthHeight.persantageOfWidth(
                                          (6 / 375) * 100),
                                    ),
                                    Text(
                                      textScaler: TextScaler.linear(
                                        AppWidthHeight.persantageOfWidth(
                                            (1 / 375) * 100),
                                      ),
                                      label,
                                      style: AppTextStyle.priority16(
                                        color: getStatusTextColor(
                                            value.capitalizeFirst!),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              cubit.selectedStatus = val!;
                              cubit.onUpdate(
                                taskId: cubit.taskId!,
                                userId: cubit.userId!,
                                currentImage: cubit.existingImagePath ?? '',
                              );
                            },
                            decoration: InputDecoration(
                              fillColor: AppLightColor.homegreyContainer,
                              filled: true,
                              border: cubit.outlineInputBorder(),
                              enabledBorder: cubit.outlineInputBorder(),
                              focusedBorder: cubit.outlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppWidthHeight.persantageOfWidth(
                                    (12 / 375) * 100),
                                vertical: AppWidthHeight.persantageOfHeight(
                                    (12 / 812) * 100),
                              ),
                            ),
                          ),

                          /// Priority Dropdown
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: cubit.selectedPriority,
                            icon: AppSvgImage.showSvgImage(
                              path: AppIcon.tArrowdown,
                              width: AppWidthHeight.persantageOfWidth(
                                  (24 / 375) * 100),
                              height: AppWidthHeight.persantageOfHeight(
                                  (24 / 812) * 100),
                            ),
                            items: [
                              {'label': 'Low Priority', 'value': 'low'},
                              {'label': 'Medium Priority', 'value': 'medium'},
                              {'label': 'High Priority', 'value': 'high'},
                            ].map((item) {
                              final label = item['label']!;
                              final value = item['value']!;
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppSvgImage.showSvgImage(
                                      path: getPriorityIcon(
                                        value.capitalizeFirst!,
                                      ),
                                      width: AppWidthHeight.persantageOfWidth(
                                          (24 / 375) * 100),
                                      height: AppWidthHeight.persantageOfHeight(
                                          (24 / 812) * 100),
                                    ),
                                    SizedBox(
                                      width: AppWidthHeight.persantageOfWidth(
                                          (10 / 375) * 100),
                                    ),
                                    Text(
                                      textScaler: TextScaler.linear(
                                        AppWidthHeight.persantageOfWidth(
                                            (1 / 375) * 100),
                                      ),
                                      label,
                                      style: AppTextStyle.priority16(
                                        color: getPriorityTextColor(
                                            value.capitalizeFirst!),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              cubit.selectedPriority = val!;
                              cubit.onUpdate(
                                taskId: cubit.taskId!,
                                userId: cubit.userId!,
                                currentImage: cubit.existingImagePath ?? '',
                              );
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              fillColor: AppLightColor.homegreyContainer,
                              filled: true,
                              border: cubit.outlineInputBorder(),
                              enabledBorder: cubit.outlineInputBorder(),
                              focusedBorder: cubit.outlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppWidthHeight.persantageOfWidth(
                                    (12 / 375) * 100),
                                vertical: AppWidthHeight.persantageOfHeight(
                                    (12 / 812) * 100),
                              ),
                            ),
                          ),
                          QrImageView(
                            data:
                                "${ApiBaseUrl.baseUrl}${ApiEndpoint.newTasks}/${cubit.taskId}",
                            version: QrVersions.auto,
                            size: AppWidthHeight.persantageOfWidth(
                                (310 / 375) * 100),
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return const SizedBox();
    });
  }
}
