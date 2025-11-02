import 'package:flutter/material.dart';
import 'package:weider/core/extension/text_style_on_context.dart';

import '../../../../../../core/theme/app_colors.dart';

class CustomContainerCard extends StatelessWidget {
  const CustomContainerCard({
    super.key,
    required this.title,
    this.alarm = false,
  });
  final String title;
  final bool alarm;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
        // border: Border.symmetric(horizontal: BorderSide(color: Colors.white)),
        borderRadius: BorderRadius.circular(8),
        // gradient: LinearGradient(
        //   colors: [
        //     Colors.transparent,
        //     AppColors.secondary,
        //     AppColors.secondary,
        //     Colors.transparent,
        //   ],
        // ),
        color: alarm ? AppColors.error : AppColors.secondary,
      ),
      child: Text(
        title,
        style: context.med14.copyWith(color: AppColors.onSecondary),
      ),
    );
  }
}
