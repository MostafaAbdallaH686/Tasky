import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/core/function/image_compress.dart';
import 'package:to_do_app/core/theme/app_light_color.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_do_app/core/utils/app_radius.dart';
import 'package:to_do_app/feature/add_task/data/repo/add_task_repo.dart';
part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  static AddTaskCubit get(context) => BlocProvider.of(context);

  final AddTaskRepo repo = AddTaskRepo();

  final GlobalKey<FormState> globalKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Optional Dropdowns
  String selectedPriority = 'low';

  // Validators
  String? validatorTitle(String? value) {
    if (value == null || value.isEmpty) return "Please enter a title!";
    return null;
  }

  String? validatorDescription(String? value) {
    if (value == null || value.isEmpty) return "Please enter a description!";
    return null;
  }

//image picker
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;

  Future<void> pickImageFromGallery() async {
    PermissionStatus status;

    if (Platform.isAndroid &&
        (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 33) {
      status = await Permission.photos.request(); // for Android 13+
    } else {
      status = await Permission.storage.request(); // for Android < 13
    }

    if (!status.isGranted) {
      emit(AddTaskError(errMessage: "Gallery access denied"));
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final compressed = await compressImage(File(image.path));
      pickedImage = compressed;
      emit(AddTaskImagePicked());
    }
  }

  Future<void> pickImageFromCamera() async {
    final cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isGranted) {
      emit(AddTaskError(errMessage: "Camera access denied"));
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final File original = File(image.path);
      pickedImage = await compressImage(original);
      emit(AddTaskImagePicked());
    }
  }

  OutlineInputBorder outlineInputBorder() => OutlineInputBorder(
        borderRadius: AppRadius.buttonRaduis,
        borderSide: BorderSide(color: AppLightColor.greyBorder),
      );
  // Submit
  void onTap() async {
    emit(AddTaskLoading());
    await Future.delayed(const Duration(seconds: 1));

    if (!globalKey.currentState!.validate()) {
      autovalidateMode = AutovalidateMode.always;
      emit(AddTaskError(errMessage: "Please fill in all fields."));
      return;
    }
    if (pickedImage == null) {
      emit(AddTaskError(errMessage: "Please select a valid image."));
      return;
    }
    String? uploadedImagePath;
    if (pickedImage != null) {
      final uploadResult = await repo.uploadImage(pickedImage!);
      uploadResult.fold(
        (error) {
          emit(AddTaskError(errMessage: error));

          return;
        },
        (path) => uploadedImagePath = path,
      );
      if (uploadedImagePath == null || uploadedImagePath!.isEmpty) {
        emit(AddTaskError(errMessage: "Enter smaller one"));

        return;
      }
    }

    final result = await repo.addTask(
      title: titleController.text,
      desc: descriptionController.text,
      priority: selectedPriority,
      image: uploadedImagePath ?? '',
      dueDate: dateController.text,
    );

    result.fold(
      (error) => emit(AddTaskError(errMessage: error)),
      (_) => emit(AddTaskSuccess()),
    );
  }
}
