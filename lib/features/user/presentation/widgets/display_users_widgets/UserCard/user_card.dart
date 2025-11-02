
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weider/core/extension/device_info_on_num.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/core/utils/rest_days.dart';
import 'package:weider/features/user/data/models/user_model/user_model.dart';
import 'package:weider/features/user/presentation/view/add_edit_user_screen.dart';
import 'package:weider/features/user/presentation/widgets/display_users_widgets/UserCard/custom_container_card.dart';
import 'package:weider/features/user/presentation/widgets/display_users_widgets/UserCard/image_review.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userModel});
  final UserModel userModel;

  Widget _firstRow(BuildContext context, int restDayes) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          userModel.name,
          style: context.semiB14.copyWith(color: AppColors.onPrimary),
        ),
      ),
      if (restDayes > 0)
        CustomContainerCard(title: '$restDayes يوم', alarm: restDayes < 5),
    ],
  );
  Widget _lastRow(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        userModel.startDate.toString().split(' ')[0],
        style: context.reg12.copyWith(color: AppColors.onPrimary),
      ),
      CustomContainerCard(title: userModel.intervalTime!.intervalName),

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
              ImageReview(userModel: userModel),
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
