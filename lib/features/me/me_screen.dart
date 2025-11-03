import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weider/core/extension/text_style_on_context.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/features/me/my_animated_name.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("عن التطبيق")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "هذا التطبيق صُمم لتسهيل وإدارة جيم كابتن شريف، ومتابعة اشتراكات المتدربين وتسهيل الوصول للمتدربين من خلال توفير أرقام هواتفهم.",
              style: context.semiB16.copyWith(
                color: AppColors.onPrimary,
                wordSpacing: 5,
              ),
              softWrap: true,
            ),
            const SizedBox(height: 24),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "التوقيع: ",
                      style: context.semiB16.copyWith(
                        color: AppColors.onPrimary,
                        wordSpacing: 5,
                      ),
                    ),
                    MyAnimatedName(),
                  ],
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "رقم الهاتف: ",
                      style: context.semiB16.copyWith(
                        color: AppColors.onPrimary,
                        wordSpacing: 5,
                      ),
                    ),
                    Text(
                      "01552483586",
                      style: context.semiB16.copyWith(
                        color: AppColors.secondary,
                        wordSpacing: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
