import 'package:flutter/material.dart';
import 'package:weider/core/extension/device_info_on_num.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/core/utils/date_time_format.dart';
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
          overflow: TextOverflow.ellipsis,
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
        dayAndMonth(userModel.startDate),
        style: context.med14.copyWith(color: AppColors.onPrimary),
      ),

      // CustomContainerCard(title: userModel.intervalTime!.intervalName),
      Text(
        userModel.intervalTime!.intervalName,
        style: context.semiB14.copyWith(color: AppColors.accentLight),
      ),
      Text(
        dayAndMonth(userModel.endDate),
        style: context.med14.copyWith(color: AppColors.onPrimary),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditUserScreen(userModel: userModel),
            ),
          );
        },
        child: SizedBox(
          height: 28.5.sp(context),
          // height: 100,
          child: Row(
            spacing: 16,
            children: [
              ImageReview(userModel: userModel),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _firstRow(context, restDays(userModel.endDate)),
                    Text(
                      userModel.phone ?? "",
                      style: context.med14.copyWith(color: AppColors.onPrimary),
                    ),
                    _lastRow(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
