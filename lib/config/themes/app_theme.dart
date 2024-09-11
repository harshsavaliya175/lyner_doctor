import 'package:flutter/material.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';

class AppTheme {
  AppTheme._();

  /*static TextTheme textTheme = const TextTheme(
    headlineLarge: TextStyle(color: AppColors.red),
    headlineMedium: TextStyle(color: AppColors.primary),
    headlineSmall: TextStyle(color: AppColors.lightBlack),
    titleMedium: TextStyle(color: AppColors.hintText),
    titleLarge: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: AppColors.buttonBorder),
    bodySmall: TextStyle(color: AppColors.lightGray),
    bodyLarge: TextStyle(color: Colors.green),
  );*/

  static ThemeData lightTheme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: primaryBrown,
    ),
    // primaryColor: AppColors.primary,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryBrown),
  );
}
