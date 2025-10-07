import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/features/user/data/models/user_model.dart';
import 'package:weider/features/user/presentation/view/add_edit_user_screen.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userModel});
  final UserModel userModel;
  Widget _customContainer(BuildContext context, {required String title}) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.secondaryColor,
      ),
      child: Text(title, style: context.semiB14),
    );
  }

  Widget _imageReview() => ClipRRect(
    borderRadius: BorderRadiusGeometry.circular(16),
    child: Container(
      width: 120,
      height: 120,
      color: AppColors.primaryColor,
      child: userModel.imagePath == null
          ? Image.asset('assets/images/unkown_person.png', fit: BoxFit.cover)
          : Image.file(File(userModel.imagePath!), fit: BoxFit.cover),
    ),
  );

  Widget _firstRow(BuildContext context, int restDayes) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        userModel.name,
        style: context.med14.copyWith(color: AppColors.backgroundLight),
      ),
      _customContainer(context, title: '$restDayes يوم'),
    ],
  );
  Widget _lastRow(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        userModel.startDate.toString().split(' ')[0],
        style: context.med14.copyWith(color: AppColors.backgroundLight),
      ),
      _customContainer(context, title: userModel.intervalTime.intervalName),

      Text(
        userModel.endDate.toString().split(' ')[0],
        style: context.med14.copyWith(color: AppColors.backgroundLight),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    final restDayes = userModel.endDate.difference(DateTime.now()).inDays;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditUserScreen(userModel: userModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageReview(),
            Gap(8),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    _firstRow(context, restDayes),
                    Text(
                      userModel.phone,
                      style: context.med14.copyWith(
                        color: AppColors.backgroundLight,
                      ),
                    ),
                    _lastRow(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
