import 'package:flutter/material.dart';

import '../theme/fonts/text_styles.dart';

extension TextStyleOnContext on BuildContext {
  TextStyle get reg12 => TextStyles.reg12;
  TextStyle get med12 => TextStyles.med12;
  TextStyle get med14 => TextStyles.med14;
  TextStyle get semiB14 => TextStyles.semiB14;
  TextStyle get semiB16 => TextStyles.semiB16;
}
