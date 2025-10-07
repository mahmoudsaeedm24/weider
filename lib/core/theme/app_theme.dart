import 'package:flutter/material.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/core/theme/fonts/text_styles.dart';

abstract class AppTheme {
  Brightness get brightness;
  Color background = AppColors.backgroundDark;

  ThemeData get themeData => ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: background,
    fontFamily: 'Cairo',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(color: AppColors.backgroundLight),
      backgroundColor: AppColors.secondaryColor,
    ),
    brightness: brightness,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.primaryColor,
      hintStyle: TextStyles.med14.copyWith(
        color: AppColors.backgroundLight.withAlpha(200),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.buttonColor),
        elevation: WidgetStatePropertyAll(5),
        shadowColor: WidgetStatePropertyAll(Colors.black),
        textStyle: WidgetStatePropertyAll(TextStyles.med16),
        foregroundColor: WidgetStatePropertyAll(AppColors.backgroundLight),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.backgroundLight),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.backgroundLight,
    ),

    // extensions: const [TextStyles.textStyles]
  );
}

class LightTheme extends AppTheme {
  // @override
  // Color get background => AppColors.backgroundLight;

  @override
  Brightness get brightness => Brightness.light;
}

class DarkTheme extends AppTheme {
  // @override
  // Color get background => AppColors.backgroundDark;

  @override
  Brightness get brightness => Brightness.dark;
}
