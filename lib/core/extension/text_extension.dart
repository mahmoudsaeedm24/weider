import 'package:flutter/material.dart';

class TextExtension extends ThemeExtension<TextExtension> {
  final TextStyle reg12;
  final TextStyle med12;
  final TextStyle med14;
  final TextStyle semiB14;
  final TextStyle med16;
  final TextStyle semiB16;
  final TextStyle semiB18;

  TextExtension({
    required this.reg12,
    required this.med12,
    required this.med14,
    required this.semiB14,
    required this.med16,
    required this.semiB16,
    required this.semiB18,
  });

  @override
  ThemeExtension<TextExtension> copyWith({
    TextStyle? reg12,
    TextStyle? med12,
    TextStyle? med14,
    TextStyle? semiB14,
    TextStyle? med16,
    TextStyle? semiB16,
    TextStyle? semiB18
  }) {
    return TextExtension(
      reg12: reg12 ?? this.reg12,
      med12: med12 ?? this.med12,
      med14: med14 ?? this.med14,
      semiB14: semiB14 ?? this.semiB14,
      med16: med16 ?? this.med16,
      semiB16: semiB16 ?? this.semiB16,
      semiB18: semiB18 ?? this.semiB18,
    );
  }

  @override
  ThemeExtension<TextExtension> lerp(
    covariant ThemeExtension<TextExtension>? other,
    double t,
  ) {
    if (other is! TextExtension) return this;
    return TextExtension(
      reg12: TextStyle.lerp(reg12, other.reg12, t)!,
      med12: TextStyle.lerp(med12, other.med12, t)!,
      med14: TextStyle.lerp(med14, other.med14, t)!,
      semiB14: TextStyle.lerp(semiB14, other.semiB14, t)!,
      med16: TextStyle.lerp(med16, other.med16, t)!,
      semiB16: TextStyle.lerp(semiB16, other.semiB16, t)!,
      semiB18: TextStyle.lerp(semiB18, other.semiB18, t)!,
    );
  }
}