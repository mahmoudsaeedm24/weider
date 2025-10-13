import 'package:flutter/material.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';

import '../widgets/display_users_widgets/display_users_body.dart';

class DisplayUsersScreen extends StatelessWidget {
  const DisplayUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الصفحة الرئيسية",
          style: context.semiB18.copyWith(color: AppColors.onPrimary),
        ),
        actions: [
          // Image.asset(
          //   "assets/images/wing.png",
          //   width: 10,
          //   height: 10,
          //   cacheHeight: 10,
          //   cacheWidth: 10,
          // ),
        ],

        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadiusGeometry.circular(16),
        // ),
      ),
      body: DisplayUsersBody(),
    );
  }
}
