import 'package:flutter/material.dart';
import 'package:weider/core/theme/app_colors.dart';
import 'package:weider/core/theme/fonts/text_styles.dart';

abstract class AppTheme {
  final BuildContext context;
  Brightness get brightness;
  Color background = AppColors.surfaceBackground;

  AppTheme({required this.context});

  ThemeData get themeData => ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: background,
    fontFamily: 'Cairo',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    ),
    brightness: brightness,
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.primary,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.secondary),
        shadowColor: WidgetStatePropertyAll(Colors.black),
        foregroundColor: WidgetStatePropertyAll(AppColors.onSecondary),
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.onSecondary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.onSecondary,
    ),

    extensions: [TextStyles.textExtension(context)],
  );
}

class LightTheme extends AppTheme {
  LightTheme({required super.context});

  // @override
  // Color get background => AppColors.backgroundLight;

  @override
  Brightness get brightness => Brightness.light;
}

class DarkTheme extends AppTheme {
  DarkTheme({required super.context});

  // @override
  // Color get background => AppColors.backgroundDark;

  @override
  Brightness get brightness => Brightness.dark;
}
