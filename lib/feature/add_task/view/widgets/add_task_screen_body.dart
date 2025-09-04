import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_snak_bar.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/function/home_function.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/core/widgets/custom_circle_progress_inicator.dart';
import 'package:to_do_app/core/widgets/default_custom_buttong.dart';
import 'package:to_do_app/core/widgets/default_text_form_filed.dart';
import 'package:to_do_app/feature/add_task/cubit/add_task_cubit.dart';
import 'package:to_do_app/feature/home/view/home_screen.dart';

class AddTaskScreenBody extends StatelessWidget {
  const AddTaskScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = AddTaskCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppWidthHeight.persantageOfHeight((24 / 812) * 100),
        horizontal: AppWidthHeight.persantageOfWidth((22 / 375) * 100),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<AddTaskCubit, AddTaskState>(
              builder: (context, state) {
                final cubit = AddTaskCubit.get(context);
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text("Pick from Gallery"),
                            onTap: () {
                              AppRoute.navigateBack();
                              cubit.pickImageFromGallery();
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text("Take a Photo"),
                            onTap: () {
                              AppRoute.navigateBack();
                              cubit.pickImageFromCamera();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    // Dynamic height: bigger if image is selected
                    height: cubit.pickedImage == null
                        ? AppWidthHeight.persantageOfHeight((56 / 812) * 100)
                        : AppWidthHeight.persantageOfHeight((240 / 812) * 100),
                    decoration: BoxDecoration(
                      color: AppLightColor.white,
                      borderRadius: BorderRadius.circular(
                        AppWidthHeight.persantageOfWidth((12 / 375) * 100),
                      ),
                      border: Border.all(color: AppLightColor.greyBorder),
                    ),
                    child: cubit.pickedImage == null
                        ? Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppSvgImage.showSvgImage(path: AppIcon.timage),
                                SizedBox(
                                  width: AppWidthHeight.persantageOfWidth(
                                    (8 / 375) * 100,
                                  ),
                                ),
                                Text(
                                  textScaler: TextScaler.linear(
                                    AppWidthHeight.persantageOfWidth(
                                      (1 / 375) * 100,
                                    ),
                                  ),
                                  AppString.image,
                                  style: AppTextStyle.regular19,
                                ),
                              ],
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppWidthHeight.persantageOfWidth(
                                  (12 / 375) * 100),
                            ),
                            child: Image.file(
                              cubit.pickedImage!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                );
              },
            ),

            SizedBox(
              height: AppWidthHeight.persantageOfHeight((16 / 812) * 100),
            ),

            // Form
            BlocBuilder<AddTaskCubit, AddTaskState>(
              builder: (context, state) {
                return Form(
                  key: cubit.globalKey,
                  autovalidateMode: cubit.autovalidateMode,
                  child: Column(
                    spacing:
                        AppWidthHeight.persantageOfHeight((16 / 812) * 100),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          textScaler: TextScaler.linear(
                            AppWidthHeight.persantageOfWidth((1 / 375) * 100),
                          ),
                          AppString.titletask,
                          style: AppTextStyle.titleaddtask),
                      DefaultTextFormFiled(
                        hint: AppString.title,
                        controller: cubit.titleController,
                        validator: cubit.validatorTitle,
                      ),
                      Text(
                          textScaler: TextScaler.linear(
                            AppWidthHeight.persantageOfWidth((1 / 375) * 100),
                          ),
                          AppString.descriptiontask,
                          style: AppTextStyle.titleaddtask),
                      DefaultTextFormFiled(
                        maxLines: 8,
                        minLines: 5,
                        hint: AppString.description,
                        controller: cubit.descriptionController,
                        validator: cubit.validatorDescription,
                      ),
                      Text(
                          textScaler: TextScaler.linear(
                            AppWidthHeight.persantageOfWidth((1 / 375) * 100),
                          ),
                          AppString.priority,
                          style: AppTextStyle.titleaddtask),
                      DropdownButtonFormField<String>(
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppWidthHeight.persantageOfWidth(
                                    (8 / 375) * 100),
                              ),
                              child: Row(
                                children: [
                                  AppSvgImage.showSvgImage(
                                    path:
                                        getPriorityIcon(value.capitalizeFirst!),
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
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          cubit.selectedPriority = val!;
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
                      Text(
                          textScaler: TextScaler.linear(
                            AppWidthHeight.persantageOfWidth((1 / 375) * 100),
                          ),
                          AppString.datetitle,
                          style: AppTextStyle.titleaddtask),
                      DefaultTextFormFiled(
                        hint: "Select a date",
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
                                    height: AppWidthHeight.persantageOfHeight(
                                        (580 / 812) * 100),
                                    child: StatefulBuilder(
                                      builder: (context, setState) {
                                        return TableCalendar(
                                          firstDay: DateTime.utc(2010, 1, 1),
                                          lastDay: DateTime.utc(2030, 12, 31),
                                          focusedDay: focusedDay,
                                          selectedDayPredicate: (day) =>
                                              isSameDay(day, selectedDate),
                                          onDaySelected: (selected, focused) {
                                            setState(() {
                                              selectedDate = selected;
                                              focusedDay = focused;
                                            });

                                            cubit.dateController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(selected);
                                            Navigator.pop(context);
                                          },
                                          calendarStyle: CalendarStyle(
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
                        onTapSuffixIcon: () {},
                        validator: (_) => null,
                      )
                    ],
                  ),
                );
              },
            ),

            SizedBox(
              height: AppWidthHeight.persantageOfHeight((28.5 / 812) * 100),
            ),

            BlocConsumer<AddTaskCubit, AddTaskState>(
              listener: (context, state) {
                if (state is AddTaskError) {
                  AppSnakBar.showSnakBar(
                      title: "Error", message: state.errMessage);
                } else if (state is AddTaskSuccess) {
                  AppRoute.navigateToAndNoBack(HomeScreen());
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
            ),
          ],
        ),
      ),
    );
  }
}
