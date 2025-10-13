import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

extension ThemeDataOnContext on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  Size get mySize => mediaQueryData.size;
  double get maxHeight => mySize.height;
  double get maxWidth => mySize.width;
  double get sp => (mySize.shortestSide) / 100;
  double get heightPercentage => maxHeight / 100;
  double get widthPercentage => maxHeight / 100;
  DeviceType get deviceType => switch (mySize.shortestSide) {
    >= 1024 => DeviceType.desktop,
    >= 600 => DeviceType.tablet,
    _ => DeviceType.mobile,
  };
}
