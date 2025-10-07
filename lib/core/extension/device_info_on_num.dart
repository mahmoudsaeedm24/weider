import 'package:flutter/material.dart';
import 'package:weider/core/responsive/device_info.dart';

extension DeviceInfoOnNum on BuildContext {
  double sp (double value) =>  DeviceInfo.sp(this, value);
  double get h => DeviceInfo.screenHeight(this);
  double get w => DeviceInfo.screenWidth(this);
}
