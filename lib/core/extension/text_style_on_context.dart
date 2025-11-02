import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weider/core/extension/text_extension.dart';
import 'package:weider/core/extension/theme_data_on_context.dart';

extension TextStyleOnContext on BuildContext {
  TextExtension? get _textExtension =>
      Theme.of(this).extension<TextExtension>();

  double _deviceFontScale() {
    return switch (deviceType) {
      DeviceType.desktop => 1.5,
      DeviceType.tablet => 1.25,
      DeviceType.mobile => 1,
    };
  }

  double _textScale(double fontSize) {
    // final scaler = MediaQuery.maybeTextScalerOf(this);
    // final limitedScaler = scaler?.clamp(minScaleFactor: 1, maxScaleFactor: 2);
    // log(limitedScaler.toString());
    // log("${limitedScaler?.scale(fontSize) ?? fontSize}");
    // return limitedScaler?.scale(fontSize) ?? fontSize;  //* هي اللي بيتظهر ال scaler
    return fontSize;
  }

  TextStyle _scaled(TextStyle? style, double defaultSize) {
    final size = style?.fontSize ?? defaultSize;
    final scaledSize = _textScale(size) * _deviceFontScale();
    // final scaledSize = _textScale(size) * _deviceFontScale();
    log("TextScaler = ${_deviceFontScale()}");
    return (style ?? const TextStyle()).copyWith(fontSize: scaledSize);
  }

  TextStyle get med12 => _scaled(_textExtension?.med12, 12);
  TextStyle get med14 => _scaled(_textExtension?.med14, 14);
  TextStyle get semiB14 => _scaled(_textExtension?.semiB14, 14);
  TextStyle get reg12 => _scaled(_textExtension?.reg12, 12);
  TextStyle get semiB16 => _scaled(_textExtension?.semiB16, 16);
  TextStyle get semiB18 => _scaled(_textExtension?.semiB18, 18);

  //! Hint if (application became bigger and font sized became more , use the map ↓ )

  // Map<String, TextStyle> get allTextStyles => {
  //   'med12': _scaled(_textExtension?.med12, 12),
  //   'med14': _scaled(_textExtension?.med14, 14),
  //   'semiB14': _scaled(_textExtension?.semiB14, 14),
  //   'reg12': _scaled(_textExtension?.reg12, 12),
  //   'semiB16': _scaled(_textExtension?.semiB16, 16),
  //   'semiB18': _scaled(_textExtension?.semiB18, 18),
  // };
}
