// lib/core/themes/app_themes.dart
import 'package:coffee_shop_managementt/core/constants/app_colors.dart';
import 'package:coffee_shop_managementt/core/constants/text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    colorScheme: _getLightColorScheme(),
    scaffoldBackgroundColor: AppColors.surfaceColor,
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headline1,
      headlineMedium: AppTextStyles.headline2,
      bodyMedium: AppTextStyles.body,
      labelLarge: AppTextStyles.button,
      bodySmall: AppTextStyles.caption,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 20,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    colorScheme: _getDarkColorScheme(),
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headline1,
      headlineMedium: AppTextStyles.headline2,
      bodyMedium: AppTextStyles.body,
      labelLarge: AppTextStyles.button,
      bodySmall: AppTextStyles.caption,
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  );

  // Light color scheme
  static ColorScheme _getLightColorScheme() => ColorScheme(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondryColors,
        surface: AppColors.surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.black87,
        onSurface: Colors.black87,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light,
      );

  static ColorScheme _getDarkColorScheme() => const ColorScheme(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondryColors,
        surface: Colors.grey,
        onPrimary: Colors.white,
        onSecondary: Colors.black87,
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.dark,
      );
}
