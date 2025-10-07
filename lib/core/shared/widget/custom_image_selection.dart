import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/core/utils/select_and_save_image.dart';
import 'package:weider/features/user/presentation/controllers/uesr_image/user_image_cubit.dart';

class CustomImageSelection extends StatelessWidget {
  const CustomImageSelection({super.key, this.imagePath});
  final String? imagePath;

  Widget _addPhoto() {
    return Center(child: Icon(Icons.camera_alt_outlined));
  }

  Widget _editPhoto(String path) {
    return Image.file(File(path), fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserImageCubit>();
    return InkWell(
      onTap: () async {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return BlocProvider.value(
              value: cubit,
              child: Container(
                padding: EdgeInsets.all(30),
                color: AppColors.primaryColor,
                child: Row(
                  children: [
                    ImageChoice(
                      icon: Icons.camera_alt_outlined,
                      title: "Camera",
                      onTap: () async {
                        final imagePath = await SelectAndSaveImage.call(
                          source: ImageSource.camera,
                        );

                        await cubit.storeImagePath(imagePath: imagePath);
                      },
                    ),
                    ImageChoice(
                      icon: Icons.filter,
                      title: "Gallery",
                      onTap: () async {
                        final imagePath = await SelectAndSaveImage.call(
                          source: ImageSource.gallery,
                        );
                        await cubit.storeImagePath(imagePath: imagePath);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(16),
            child: Container(
              width: 120,
              height: 120,
              color: AppColors.primaryColor,
              child: imagePath == null ? _addPhoto() : _editPhoto(imagePath!),
            ),
          ),
          Text(
            imagePath == null ? "إضافة صورة" : "تعديل الصورة",
            style: context.med14,
          ),
        ],
      ),
    );
  }
}

class ImageChoice extends StatelessWidget {
  const ImageChoice({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 5,
          children: [
            Icon(icon, color: AppColors.backgroundLight),
            Text(
              title,
              style: context.med14.copyWith(
                color: AppColors.backgroundLight.withAlpha(200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
