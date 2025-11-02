// import 'dart:ui';

import 'package:flutter/material.dart';

// class DeviceInfo {
//   DeviceInfo._();

//   static PlatformDispatcher get _platformDispatcher =>
//       WidgetsBinding.instance.platformDispatcher;
//   static FlutterView get _view => _platformDispatcher.views.first;
//   static double get maxHeight => _view.physicalSize.height;
//   static double get maxWidth => _view.physicalSize.width;
//   static double get dp =>
//       _view.physicalSize.shortestSide / _view.devicePixelRatio;
//   static double get sp => (dp * _platformDispatcher.textScaleFactor) / 100;
// }

// class DeviceInfo {
//   DeviceInfo._();
//   static get myWindow => WidgetsBinding.instance.platformDispatcher.views.first;
//   static MediaQueryData get mediaQueryData => MediaQueryData.fromView(myWindow);

//   static double get screenWidth => mediaQueryData.size.width;
//   static double get screenHeight => mediaQueryData.size.height;
//   static double get textCalc => mediaQueryData.size.shortestSide;
//   static double get dp => (textCalc / mediaQueryData.devicePixelRatio);
//   static double get sp => dp / 100;
//   static get deviceBrightness => mediaQueryData.platformBrightness;
//   static get deviceLanguage => myWindow.platformDispatcher.locale;
// }

class DeviceInfo {
  DeviceInfo._();

  static MediaQueryData of(BuildContext context) {
    return MediaQuery.of(context);
  }

  static double screenWidth(BuildContext context) =>
      of(context).size.width;

  static double screenHeight(BuildContext context) =>
      of(context).size.height;

  // static double sc(BuildContext context) =>
  //     of(context).;

  static double dp(BuildContext context) =>
      of(context).size.shortestSide / of(context).devicePixelRatio;

  static double sp(BuildContext context, double value) =>
      (dp(context) * of(context).textScaler.scale(value)) / 100;

  static Brightness deviceBrightness(BuildContext context) =>
      of(context).platformBrightness;


}
