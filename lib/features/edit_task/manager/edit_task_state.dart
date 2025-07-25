part of 'edit_task_cubit.dart';

abstract class EditTaskState extends Equatable {
  const EditTaskState();

  @override
  List<Object?> get props => [];
}

class EditTaskInitial extends EditTaskState {}

class EditTaskLoading extends EditTaskState {}

class EditTaskSuccess extends EditTaskState {}

class EditTaskError extends EditTaskState {
  final String errMessage;

  const EditTaskError({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

class EditTaskFetched extends EditTaskState {
  final TaskModel task;
  const EditTaskFetched(this.task);

  @override
  List<Object> get props => [task];
}

class TaskDeletedSuccess extends EditTaskState {
  final String errMessage;

  const TaskDeletedSuccess({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

class EditTaskImagePicked extends EditTaskState {}
