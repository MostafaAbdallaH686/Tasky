import 'package:equatable/equatable.dart';
import 'package:to_do_app/feature/home/data/model/home_model.dart';
import 'package:to_do_app/feature/home/cubit/home_cubit.dart';

sealed class HomeState extends Equatable {}

class HomeLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeFilterChanged extends HomeState with EquatableMixin {
  final TaskFilter filter;

  HomeFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

class HomeSuccessNoDataState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  final List<TasksModel> tasks;
  HomeSuccessState({required this.tasks});
  @override
  List<Object?> get props => [tasks];
}

class TaskDeletedSuccess extends HomeState {
  final String errMessage;

  TaskDeletedSuccess({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

class HomeErrorState extends HomeState {
  final String errMessage;

  HomeErrorState({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}
