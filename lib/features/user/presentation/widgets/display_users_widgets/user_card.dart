import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weider/core/extension/device_info_on_num.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/core/utils/rest_days.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';
import 'package:weider/features/user/presentation/view/add_edit_user_screen.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userModel});
  final UserModel userModel;
  Widget _customContainer(
    BuildContext context, {
    required String title,
    bool alarm = false,
  }) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: alarm ? AppColors.error : AppColors.secondary,
      ),
      child: Text(
        title,
        style: context.semiB14.copyWith(color: AppColors.onSecondary),
      ),
    );
  }

  Widget _imageReview(BuildContext context) => ClipRRect(
    borderRadius: BorderRadiusGeometry.circular(16),
    child: SizedBox(
      width: 28.5.sp(context),
      height: 28.5.sp(context),
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
        style: context.semiB16.copyWith(color: AppColors.onPrimary),
      ),
      restDayes > 0
          ? _customContainer(
              context,
              title: '$restDayes يوم',
              alarm: restDayes < 5,
            )
          : Container(),
    ],
  );
  Widget _lastRow(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        userModel.startDate.toString().split(' ')[0],
        style: context.reg12.copyWith(color: AppColors.onPrimary),
      ),
      _customContainer(context, title: userModel.intervalTime!.intervalName),

      Text(
        userModel.endDate.toString().split(' ')[0],
        style: context.reg12.copyWith(color: AppColors.onPrimary),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
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
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: SizedBox(
          height: 28.5.sp(context),

          child: Row(
            children: [
              _imageReview(context),
              Gap(16),
              Expanded(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      _firstRow(context, restDays(userModel.endDate)),
                      Text(
                        userModel.phone ?? "",
                        style: context.reg12.copyWith(
                          color: AppColors.onPrimary,
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
      ),
    );
  }
}
