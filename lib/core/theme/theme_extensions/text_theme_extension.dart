import 'package:flutter/material.dart';

@immutable
class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  final TextStyle reg12;
  final TextStyle med12;
  final TextStyle med14;
  final TextStyle semiB14;
  final TextStyle med16;
  final TextStyle semiB16;

  const TextThemeExtension({
    required this.reg12,
    required this.med12,
    required this.med14,
    required this.semiB14,
    required this.med16,
    required this.semiB16,
  });

  @override
  TextThemeExtension copyWith({
    TextStyle? reg12,
    TextStyle? med12,
    TextStyle? med14,
    TextStyle? semiB14,
    TextStyle? med16,
    TextStyle? semiB16,
  }) {
    return TextThemeExtension(
      reg12: reg12 ?? this.reg12,
      med12: med12 ?? this.med12,
      med14: med14 ?? this.med14,
      semiB14: semiB14 ?? this.semiB14,
      med16: med16 ?? this.med16,
      semiB16: semiB16 ?? this.semiB16,
    );
  }

  @override
  TextThemeExtension lerp(ThemeExtension<TextThemeExtension>? other, double t) {
    if (other is! TextThemeExtension) return this;
    return TextThemeExtension(
      reg12: TextStyle.lerp(reg12, other.reg12, t)!,
      med12: TextStyle.lerp(med12, other.med12, t)!,
      med14: TextStyle.lerp(med14, other.med14, t)!,
      semiB14: TextStyle.lerp(semiB14, other.semiB14, t)!,
      med16: TextStyle.lerp(med16, other.med16, t)!,
      semiB16: TextStyle.lerp(semiB16, other.semiB16, t)!,
    );
  }
}
mahmoudsaeedm24/base_structure