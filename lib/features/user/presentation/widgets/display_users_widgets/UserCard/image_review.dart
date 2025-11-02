import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weider/core/extension/device_info_on_num.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';

class ImageReview extends StatelessWidget {
  const ImageReview({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(16),
      child: SizedBox(
        width: 28.5.sp(context),
        height: 28.5.sp(context),
        child: userModel.imagePath == null
            ? Image.asset('assets/images/unkown_person.png', fit: BoxFit.cover)
            : Image.file(File(userModel.imagePath!), fit: BoxFit.cover),
      ),
    );
  }
}
