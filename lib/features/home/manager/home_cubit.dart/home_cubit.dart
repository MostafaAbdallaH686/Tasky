import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/cache/cache_helper.dart';
import 'package:to_do_app/core/cache/shared_preferenece_key.dart';
import 'package:to_do_app/core/model/task_model.dart';
import 'package:to_do_app/features/home/data/repo/home_repo.dart';
import 'package:to_do_app/features/home/manager/home_cubit.dart/home_state.dart';

enum TaskFilter { all, inProgress, waiting, finished }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoadingState()) {
    name = cacheHelper.getDataString(key: SharedPrefereneceKey.phone) ?? "";
    getAllTasks();
  }
  static HomeCubit get(context) => BlocProvider.of(context);
  final CacheHelper cacheHelper = CacheHelper();
  final HomeRepo homeRepo = HomeRepo();
  late String name;
  String? image;
  List<TaskModel> allTasks = [];
  TaskFilter currentFilter = TaskFilter.all;

  /// Change current filter and emit filtered tasks
  void changeFilter(TaskFilter filter) {
    currentFilter = filter;
    final filteredTasks = _getFilteredTasks(allTasks);
    if (filteredTasks.isEmpty) {
      emit(HomeSuccessNoDataState());
    } else {
      emit(HomeSuccessState(tasks: filteredTasks));
    }
  }

  /// Fetch all tasks from API
  void getAllTasks() async {
    emit(HomeLoadingState());
    final response = await homeRepo.getTasks();
    response.fold(
      (error) => emit(HomeErrorState(errMessage: error)),
      (list) {
        allTasks = list;
        if (allTasks.isEmpty) {
          emit(HomeSuccessNoDataState());
        } else {
          emit(HomeSuccessState(tasks: allTasks));
        }
      },
    );
  }

  /// Apply filter logic to the task list
  List<TaskModel> _getFilteredTasks(List<TaskModel> tasks) {
    switch (currentFilter) {
      case TaskFilter.inProgress:
        return tasks
            .where((task) => task.status.toLowerCase() == 'inprogress')
            .toList();
      case TaskFilter.waiting:
        return tasks
            .where((task) => task.status.toLowerCase() == 'waiting')
            .toList();
      case TaskFilter.finished:
        return tasks
            .where((task) => task.status.toLowerCase() == 'finished')
            .toList();
      case TaskFilter.all:
        return tasks;
    }
  }

  Future<void> deleteTaskById(String taskId) async {
    emit(HomeLoadingState());

    final result = await homeRepo.deleteTask(taskId);

    result.fold(
      (error) => emit(HomeErrorState(errMessage: error)),
      (msg) => emit(TaskDeletedSuccess(errMessage: msg)),
    );
  }
}
