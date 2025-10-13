import 'package:flutter/material.dart';
import 'package:weider/core/extension/theme_data_on_context.dart';

extension DeviceInfoOnNum on num {
  double sp(BuildContext context) => this * context.sp;
  double maxHeight(BuildContext context) => this * context.maxHeight;
  double maxWidth(BuildContext context) => this * context.maxWidth;

  double heightPercenatge(BuildContext context) => this / (context.heightPercentage * 18);
  double widthPercenatge(BuildContext context) => this / (context.maxWidth * 33);

}