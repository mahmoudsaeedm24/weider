import 'package:flutter/material.dart';
import 'package:weider/core/extension/theme_data_on_context.dart';

import '../../extension/text_extension.dart';

class TextStyles {
  TextStyles._();

  static TextExtension textExtension(BuildContext context) {
    bool isTablet = context.sp >= 600;
    return TextExtension(
      reg12: TextStyle(
        fontSize: isTablet ? 14 : 12,
        fontWeight: FontWeight.w400,
        // letterSpacing: 1,
      ),
      med12: TextStyle(
        fontSize: isTablet ? 14 : 12,
        fontWeight: FontWeight.w500,
      ),
      med14: TextStyle(
        fontSize: isTablet ? 16 : 14,
        fontWeight: FontWeight.w500,
      ),
      semiB14: TextStyle(
        fontSize: isTablet ? 16 : 14,
        fontWeight: FontWeight.w600,
      ),
      med16: TextStyle(
        fontSize: isTablet ? 18 : 16,
        fontWeight: FontWeight.w500,
      ),
      semiB16: TextStyle(
        fontSize: isTablet ? 18 : 16,
        fontWeight: FontWeight.w600,
      ),
      semiB18: TextStyle(
        fontSize: isTablet ? 20 : 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
