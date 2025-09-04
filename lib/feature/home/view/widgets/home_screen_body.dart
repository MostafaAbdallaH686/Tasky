import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/function/app_width_height.dart';
import 'package:to_do_app/core/function/formate_date_time_string.dart';
import 'package:to_do_app/core/function/home_function.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/widgets/custom_circle_progress_inicator.dart';
import 'package:to_do_app/core/widgets/custom_menu_button.dart';
import 'package:to_do_app/feature/edit_task/view/edit_task_screen.dart';
import 'package:to_do_app/feature/home/cubit/home_cubit.dart';
import 'package:to_do_app/feature/home/cubit/home_state.dart';
import 'package:to_do_app/feature/home/view/widgets/custom_button_home.dart';
import 'package:to_do_app/feature/home/view/widgets/home_screen_body_no_data.dart';
import 'package:to_do_app/feature/home/view/widgets/image_widget.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: AppLightColor.blue,
        onRefresh: () async {
          HomeCubit.get(context).getAllTasks();
        },
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      AppWidthHeight.persantageOfWidth((22 / 375) * 100),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            AppWidthHeight.persantageOfHeight((24 / 812) * 100),
                      ),
                      Text(
                          textScaler: TextScaler.linear(
                            AppWidthHeight.persantageOfWidth((1 / 375) * 100),
                          ),
                          'My Tasks',
                          style: AppTextStyle.bold16),
                      SizedBox(
                        height:
                            AppWidthHeight.persantageOfHeight((16 / 812) * 100),
                      ),
                      BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, filter) {
                        final cubit = HomeCubit.get(context);
                        final currentFilter = cubit.currentFilter;

                        return Row(
                          spacing:
                              AppWidthHeight.persantageOfWidth((6 / 375) * 100),
                          children: [
                            CustomButtonOfOhome(
                              title: "All",
                              isActive: currentFilter == TaskFilter.all,
                              width: AppWidthHeight.persantageOfWidth(
                                  (44 / 375) * 100),
                              onTap: () => cubit.changeFilter(TaskFilter.all),
                            ),
                            CustomButtonOfOhome(
                              title: "Inpogress",
                              isActive: currentFilter == TaskFilter.inProgress,
                              width: AppWidthHeight.persantageOfWidth(
                                  (98 / 375) * 100),
                              onTap: () =>
                                  cubit.changeFilter(TaskFilter.inProgress),
                            ),
                            CustomButtonOfOhome(
                              title: "Waiting",
                              isActive: currentFilter == TaskFilter.waiting,
                              width: AppWidthHeight.persantageOfWidth(
                                  (81 / 375) * 100),
                              onTap: () =>
                                  cubit.changeFilter(TaskFilter.waiting),
                            ),
                            CustomButtonOfOhome(
                              title: "Finished",
                              isActive: currentFilter == TaskFilter.finished,
                              width: AppWidthHeight.persantageOfWidth(
                                  (88 / 375) * 100),
                              onTap: () =>
                                  cubit.changeFilter(TaskFilter.finished),
                            ),
                          ],
                        );
                      }),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoadingState) {
                            return const Center(
                                child: CustomCircleProgressInicator());
                          }

                          if (state is HomeSuccessState) {
                            final tasks = state.tasks;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: AppWidthHeight.persantageOfHeight(
                                      (20 / 812) * 100),
                                ),
                                ListView.separated(
                                  itemCount: tasks.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: AppWidthHeight.persantageOfHeight(
                                        (10 / 812) * 100),
                                  ),
                                  itemBuilder: (context, index) {
                                    final task = tasks[index];

                                    return InkWell(
                                      onTap: () => AppRoute.navigateTo(
                                          EditTaskScreen(task: task)),
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            AppWidthHeight.persantageOfHeight(
                                                96 / 812 * 100),
                                        decoration: BoxDecoration(
                                          color: AppLightColor.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              buildTaskImage(
                                                task.image,
                                                AppWidthHeight
                                                    .persantageOfWidth(
                                                        (64 / 375) * 100),
                                                AppWidthHeight
                                                    .persantageOfHeight(
                                                        (64 / 812) * 100),
                                              ),
                                              SizedBox(
                                                width: AppWidthHeight
                                                    .persantageOfWidth(
                                                        (12 / 375) * 100),
                                              ),
                                              Column(
                                                spacing: AppWidthHeight
                                                    .persantageOfHeight(
                                                        (4 / 812) * 100),
                                                children: [
                                                  SizedBox(
                                                    height: AppWidthHeight
                                                        .persantageOfHeight(
                                                            (12 / 812) * 100),
                                                  ),
                                                  SizedBox(
                                                    width: AppWidthHeight
                                                        .persantageOfWidth(
                                                            (219 / 375) * 100),
                                                    height: AppWidthHeight
                                                        .persantageOfHeight(
                                                            (22 / 812) * 100),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            task.title,
                                                            style: AppTextStyle
                                                                .regularB16,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textScaler:
                                                                TextScaler
                                                                    .linear(
                                                              AppWidthHeight
                                                                  .persantageOfWidth(
                                                                      (1 / 375) *
                                                                          100),
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: AppWidthHeight
                                                                .persantageOfWidth(
                                                                    (8 / 375) *
                                                                        100)),
                                                        Container(
                                                          width:
                                                              getStatusContainerwidth(
                                                                  task.status),
                                                          height: AppWidthHeight
                                                              .persantageOfHeight(
                                                                  (22 / 812) *
                                                                      100),
                                                          decoration: BoxDecoration(
                                                              color: getStatusContainerColor(
                                                                  task.status),
                                                              borderRadius: BorderRadius.circular(
                                                                  AppWidthHeight
                                                                      .persantageOfHeight((5 /
                                                                              812) *
                                                                          100))),
                                                          child: Center(
                                                            child: Text(
                                                                textScaler:
                                                                    TextScaler
                                                                        .linear(
                                                                  AppWidthHeight
                                                                      .persantageOfWidth(
                                                                          (1 / 375) *
                                                                              100),
                                                                ),
                                                                ' ${task.status}',
                                                                style: AppTextStyle
                                                                    .status12(
                                                                        color: getStatusTextColor(
                                                                            task.status))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: AppWidthHeight
                                                        .persantageOfWidth(
                                                            (219 / 375) * 100),
                                                    child: Text(
                                                      textScaler:
                                                          TextScaler.linear(
                                                        AppWidthHeight
                                                            .persantageOfWidth(
                                                                (1 / 375) *
                                                                    100),
                                                      ),
                                                      task.desc,
                                                      style: AppTextStyle
                                                          .regular14,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                    ),
                                                  ),
                                                  Flex(
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      SizedBox(
                                                        width: AppWidthHeight
                                                            .persantageOfWidth(
                                                                (219 / 375) *
                                                                    100),
                                                        height: AppWidthHeight
                                                            .persantageOfHeight(
                                                                (20 / 812) *
                                                                    100),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AppSvgImage.showSvgImage(
                                                                path: getPriorityIcon(
                                                                    task.priority)),
                                                            Text(
                                                                textScaler:
                                                                    TextScaler
                                                                        .linear(
                                                                  AppWidthHeight
                                                                      .persantageOfWidth(
                                                                          (1 / 375) *
                                                                              100),
                                                                ),
                                                                ' ${task.priority}',
                                                                style: AppTextStyle
                                                                    .priority12(
                                                                  color: getPriorityTextColor(
                                                                      task.priority),
                                                                )),
                                                            Spacer(),
                                                            Text(
                                                                textScaler:
                                                                    TextScaler
                                                                        .linear(
                                                                  AppWidthHeight
                                                                      .persantageOfWidth(
                                                                          (1 / 375) *
                                                                              100),
                                                                ),
                                                                formateDateTimeString(
                                                                  task.createdAt,
                                                                ),
                                                                style: AppTextStyle
                                                                    .regular12),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: CusompopupMenuButton(
                                                    task: task),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          }

                          if (state is HomeSuccessNoDataState) {
                            return const HomeScreenBodyNoData();
                          }

                          if (state is HomeErrorState) {
                            return Center(
                              child: Text(
                                "Error: ${state.errMessage}",
                                style: AppTextStyle.regular16,
                              ),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ]))));
  }
}
