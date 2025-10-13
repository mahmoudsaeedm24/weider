import 'package:flutter/material.dart';
import 'package:weider/core/extension/device_info_on_num.dart';
import 'package:weider/core/extension/theme_data_on_context.dart';

import '../../extension/text_extension.dart';

class TextStyles {
  TextStyles._();

  static TextExtension textExtension(BuildContext context) {
    bool isTablet = context.sp >= 600;
    return TextExtension(
      reg12: TextStyle(
        fontSize: isTablet ? 3.5.sp(context) : 3.sp(context),
        fontWeight: FontWeight.w400,
        // letterSpacing: 1,
      ),
      med12: TextStyle(
        fontSize: isTablet ? 3.5.sp(context) : 3.sp(context),
        fontWeight: FontWeight.w500,
      ),
      med14: TextStyle(
        fontSize: isTablet ? 4.sp(context) : 3.5.sp(context),
        fontWeight: FontWeight.w500,
      ),
      semiB14: TextStyle(
        fontSize: isTablet ? 4.sp(context) : 3.5.sp(context),
        fontWeight: FontWeight.w600,
      ),
      med16: TextStyle(
        fontSize: isTablet ? 4.05.sp(context) : 4.sp(context),
        fontWeight: FontWeight.w500,
      ),
      semiB16: TextStyle(
        fontSize: isTablet ? 4.05.sp(context) : 4.sp(context),
        fontWeight: FontWeight.w600,
      ),
      semiB18: TextStyle(
        fontSize: isTablet ? 6.sp(context) : 5.sp(context),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
