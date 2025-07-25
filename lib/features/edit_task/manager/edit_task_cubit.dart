import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/model/task_model.dart';
import 'package:to_do_app/features/edit_task/data/model/edit_task_model.dart';
import 'package:to_do_app/features/edit_task/data/repo/edit_task_repo.dart';
import 'package:to_do_app/features/home/presentation/home_screen.dart';
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

  OutlineInputBorder outlineInputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      );

  void initializeWithTask(TaskModel task) {
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
    if (showLoader) emit(EditTaskLoading());

    if (!globalKey.currentState!.validate()) {
      autovalidateMode = AutovalidateMode.always;
      emit(EditTaskError(errMessage: "Please fill in all fields."));
      return;
    }

    String imagePath = currentImage;

    if (pickedImage != null) {
      final uploadResult = await repo.uploadImage(pickedImage!);
      uploadResult.fold(
        (err) {
          emit(EditTaskError(errMessage: err));
          return;
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
    result.fold(
      (error) => emit(EditTaskError(errMessage: error)),
      (_) {
        emit(EditTaskSuccess());
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
