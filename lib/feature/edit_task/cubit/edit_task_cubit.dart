import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/feature/home/data/model/home_model.dart';
import 'package:to_do_app/feature/edit_task/data/model/edit_task_model.dart';
import 'package:to_do_app/feature/edit_task/data/repo/edit_task_repo.dart';
import 'package:to_do_app/feature/home/view/home_screen.dart';
part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit() : super(EditTaskInitial());

  static EditTaskCubit get(context) => BlocProvider.of(context);

  final EditTaskRepo repo = EditTaskRepo();

  final GlobalKey<FormState> globalKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  String selectedPriority = 'low';
  String selectedStatus = 'waiting';

  final ImagePicker _picker = ImagePicker();
  File? pickedImage;
  String? existingImagePath;
  String? taskId;
  String? userId;

  Future<void> pickImageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      emit(EditTaskImagePicked());
    }
  }

  Future<void> pickImageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage = File(image.path);
      emit(EditTaskImagePicked());
    }
  }

  void initializeWithTask(TasksModel task) {
    titleController.text = task.title;
    descriptionController.text = task.desc;
    dateController.text =
        DateFormat('dd MMM yyyy').format(DateTime.parse(task.createdAt));
    selectedPriority = task.priority;
    selectedStatus = task.status;
    existingImagePath = task.image;
    taskId = task.id;
    userId = task.user;
  }

  void onUpdate({
    required String taskId,
    required String userId,
    required String currentImage,
    bool showLoader = false,
  }) async {
    if (showLoader) {
      if (isClosed) return;
      emit(EditTaskLoading());
    }

    if (!globalKey.currentState!.validate()) {
      autovalidateMode = AutovalidateMode.always;
      if (isClosed) return;
      emit(EditTaskError(errMessage: "Please fill in all fields."));
      return;
    }

    String imagePath = currentImage;

    if (pickedImage != null) {
      final uploadResult = await repo.uploadImage(pickedImage!);
      if (isClosed) return;

      uploadResult.fold(
        (err) {
          if (isClosed) return;
          emit(EditTaskError(errMessage: err));
        },
        (path) => imagePath = path,
      );
    }

    final taskModel = EditTaskModel(
      title: titleController.text,
      desc: descriptionController.text,
      priority: selectedPriority,
      image: imagePath,
      status: selectedStatus,
      user: userId,
    );

    final result = await repo.updateTask(taskId: taskId, task: taskModel);
    if (isClosed) return;

    result.fold(
      (error) {
        if (isClosed) return;
        emit(EditTaskError(errMessage: error));
      },
      (_) {
        if (isClosed) return;
        emit(EditTaskSuccess());
        //  Optionally navigate back to home screen , there is no button
        AppRoute.navigateToAndNoBack(HomeScreen());
      },
    );
  }

  Future<void> getTaskById(String taskId) async {
    emit(EditTaskLoading());
    final result = await repo.getTask(taskId: taskId);
    result.fold(
      (error) => emit(EditTaskError(errMessage: error)),
      (task) => emit(EditTaskFetched(task)),
    );
  }

  Future<void> deleteTaskById(String taskId) async {
    emit(EditTaskLoading());
    if (isClosed) return;
    final result = await repo.deleteTask(taskId);
    result.fold(
      (error) => emit(EditTaskError(errMessage: error)),
      (msg) => emit(TaskDeletedSuccess(errMessage: msg)),
    );
  }
}
