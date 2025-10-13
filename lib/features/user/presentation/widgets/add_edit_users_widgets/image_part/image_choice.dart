import 'package:flutter/material.dart';
import 'package:weider/core/extension/text_style_on_context.dart';

import '../../../../../../core/theme/app_colors.dart';

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
            Icon(icon, color: AppColors.onPrimary),
            Text(
              title,
              style: context.med14.copyWith(color: AppColors.accentLight),
            ),
          ],
        ),
      ),
    );
  }
}
