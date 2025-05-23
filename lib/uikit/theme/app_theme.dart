import 'package:flutter/material.dart';

import '../../resourses/font_family.dart';
import 'app_colors.dart';

class AppTheme {

  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.21,
      color: AppColors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.21,
      color: AppColors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.21,
      color: AppColors.white,
    ),
    headlineSmall: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1.5,
      color: AppColors.white,
    ),
    bodySmall: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1.5,
      color: AppColors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.21,
      color: AppColors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.21,
      color: AppColors.white,
    ),
    headlineLarge: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1.21,
    ),
    headlineMedium: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w700,
      fontSize: 18,
      height: 1.21,
      color: AppColors.white,
    ),
    labelLarge: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w600,
      fontSize: 15,
      height: 1.21,
      color: AppColors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w600,
      fontSize: 15,
      height: 1.21,
      color: AppColors.neutralDark,
    ),
    labelSmall: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w400,
      fontSize: 13,
      height: 1.21,
      color: AppColors.white,
    ),
    titleSmall: TextStyle(
      fontFamily: FontFamily.openSansRegular,
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1,
      letterSpacing: -0.24,
      color: AppColors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: FontFamily.openSansSemiBold,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      height: 1.21,
      color: AppColors.white,
    ),
    titleLarge: TextStyle(
      fontFamily: FontFamily.openSans,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 1.21,
      color: AppColors.white,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.neutralLight,
        surface: AppColors.surfaceLight,
        inversePrimary: AppColors.black,
        onPrimary: AppColors.neutralTwoDark,
        onSecondary: AppColors.neutralThreeDark
    ),
    cardColor: AppColors.cardColorLight,
    textTheme: textTheme.apply(
      bodyColor: AppColors.neutralDark,
      displayColor: AppColors.neutralDark,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.neutralTwoDark,
        surface: AppColors.surfaceDark,
        inversePrimary: AppColors.white,
        onPrimary: AppColors.neutralTwoDark,
        onSecondary: AppColors.neutralThreeDark
    ),
    cardColor: AppColors.cardColorDark,
    textTheme: textTheme.apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),
  );

}
