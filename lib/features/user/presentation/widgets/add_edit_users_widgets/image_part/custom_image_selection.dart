import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weider/core/extension/device_info_on_num.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/core/utils/select_and_save_image.dart';
import 'package:weider/features/user/presentation/controllers/uesr_image/user_image_cubit.dart';

import 'image_choice.dart';

class CustomImageSelection extends StatelessWidget {
  const CustomImageSelection({super.key, this.imagePath});
  final String? imagePath;

  Widget _addPhoto() {
    return Center(child: Icon(Icons.camera_alt_outlined));
  }

  Widget _editPhoto(String path) {
    return Image.file(File(path), fit: BoxFit.cover);
  }

  showImageSourceChoice() async {}
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
                color: AppColors.primary,
                child: Row(
                  children: [
                    ImageChoice(
                      icon: Icons.camera_alt_outlined,
                      title: "الكاميرا",
                      onTap: () async {
                        final imagePath = await SelectAndSaveImage.call(
                          source: ImageSource.camera,
                        );

                        await cubit.storeImagePath(imagePath: imagePath);
                      },
                    ),
                    ImageChoice(
                      icon: Icons.filter,
                      title: "معرض الصور",
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
              width: 33.3.sp(context),
              height: 33.3.sp(context),
              color: AppColors.primary,
              child: imagePath == null ? _addPhoto() : _editPhoto(imagePath!),
            ),
          ),
          Text(
            imagePath == null ? "إضافة صورة" : "تعديل الصورة",
            style: context.med14.copyWith(color: AppColors.onPrimary),
          ),
        ],
      ),
    );
  }
}
