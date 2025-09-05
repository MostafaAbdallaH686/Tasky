import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/constants/add_task_constants.dart';
import 'package:to_do_app/core/function/app_route.dart';
import 'package:to_do_app/core/function/app_svg_image.dart';
import 'package:to_do_app/core/theme/app_text_style.dart';
import 'package:to_do_app/core/utils/app_icon.dart';
import 'package:to_do_app/core/utils/app_string.dart';
import 'package:to_do_app/feature/add_task/cubit/add_task_cubit.dart';

class ImagePickerSection extends StatelessWidget {
  final AddTaskCubit cubit;

  const ImagePickerSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => _showImageSourceBottomSheet(context, cubit),
          child: Container(
            width: double.infinity,
            height: cubit.pickedImage == null
                ? AddTaskConstants.smallContainerHeight
                : AddTaskConstants.largeContainerHeight,
            decoration: AddTaskConstants.containerDecoration,
            child: cubit.pickedImage == null
                ? _buildPlaceholderContent()
                : _buildImagePreview(cubit.pickedImage!),
          ),
        );
      },
    );
  }

  void _showImageSourceBottomSheet(BuildContext context, AddTaskCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Pick from Gallery"),
            onTap: () {
              AppRoute.navigateBack();
              cubit.pickImageFromGallery();
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take a Photo"),
            onTap: () {
              AppRoute.navigateBack();
              cubit.pickImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderContent() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSvgImage.showSvgImage(path: AppIcon.timage),
          SizedBox(width: AddTaskConstants.smallSpacing),
          Text(
            AppString.image,
            textScaler: AddTaskConstants.textScaler,
            style: AppTextStyle.regular19,
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(File image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AddTaskConstants.borderRadius),
      child: Image.file(
        image,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}
