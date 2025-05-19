import 'package:flutter/material.dart';
import 'appColors.dart';

class MainTheme {
  static final ThemeData defaultTheme = _buildTheme();
  static const appColors = AppColors();

  static ThemeData _buildTheme() {
    return ThemeData(
      fontFamily: 'Ubuntu',
      useMaterial3: true,
      primaryColor: appColors.white,
      iconTheme: IconThemeData(color: appColors.primaryBlue100),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              color: appColors.activeYellow400,
              fontSize: 16,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w700),
          iconTheme: IconThemeData(color: appColors.neutral900),
          color: appColors.white),
      buttonTheme: const ButtonThemeData(),
      scaffoldBackgroundColor: appColors.white,
      datePickerTheme: DatePickerThemeData(
        backgroundColor: appColors.white,
        dividerColor: appColors.activeYellow400,
        headerBackgroundColor: appColors.activeYellow400,
        headerForegroundColor: appColors.white,
        todayForegroundColor: WidgetStateProperty.all(appColors.white),
        todayBackgroundColor: WidgetStateProperty.all(appColors.primaryBlue100),
        rangePickerBackgroundColor: appColors.primaryBlue100,
      ),
      textTheme: TextTheme(
          bodySmall: TextStyle(
              color: MainTheme.appColors.neutral900,
              fontSize: 12,
              fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
              color: MainTheme.appColors.neutral900,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(
              color: MainTheme.appColors.neutral600,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(
            color: appColors.primaryBlue100,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: "SpaceGrotesk",
          ),
          headlineMedium: TextStyle(
              color: MainTheme.appColors.primaryBlue100,
              fontFamily: "SpaceGrotesk",
              fontSize: 28,
              fontWeight: FontWeight.w400),
          headlineLarge: TextStyle(
              color: MainTheme.appColors.primaryBlue100,
              fontSize: 32,
              fontWeight: FontWeight.w600),
          displayMedium: TextStyle(
              color: MainTheme.appColors.primaryBlue100,
              fontFamily: "SpaceGrotesk",
              fontSize: 48,
              fontWeight: FontWeight.w800),
          labelMedium:  TextStyle(
              color: appColors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500)
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: MainTheme.appColors.primaryBlue100,
        unselectedItemColor: Colors.grey.shade400,
      ),
    );
  }
  static ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Ubuntu',
      useMaterial3: true,
      primaryColor: appColors.darkModeBlue,
      scaffoldBackgroundColor: appColors.darkModeBlue,
      iconTheme: IconThemeData(color: appColors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.darkModeBlue,
        iconTheme: IconThemeData(color: appColors.white),
        titleTextStyle: TextStyle(
          color: appColors.activeYellow400,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Ubuntu',
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: appColors.darkModeBlue,
        dividerColor: appColors.activeYellow400,
        headerBackgroundColor: appColors.activeYellow400,
        headerForegroundColor: appColors.white,
        todayForegroundColor: WidgetStateProperty.all(appColors.white),
        todayBackgroundColor: WidgetStateProperty.all(appColors.darkModeBlue100),
        rangePickerBackgroundColor: appColors.darkModeBlue100,
      ),
      textTheme: TextTheme(
          bodySmall: TextStyle(
              color: appColors.neutral100,
              fontSize: 12,
              fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(
              color: appColors.neutral100,
              fontSize: 14,
              fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(
              color: appColors.neutral100,
              fontSize: 16,
              fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(
            color: appColors.neutral100,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: "SpaceGrotesk",
          ),
          headlineMedium: TextStyle(
              color: appColors.white,
              fontFamily: "SpaceGrotesk",
              fontSize: 28,
              fontWeight: FontWeight.w400),
          headlineLarge: TextStyle(
              color: appColors.white, fontSize: 32, fontWeight: FontWeight.w600),
          displayMedium: TextStyle(
              color: appColors.white,
              fontFamily: "SpaceGrotesk",
              fontSize: 48,
              fontWeight: FontWeight.w800),
          labelMedium:  TextStyle(
              color: appColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500)
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: MainTheme.appColors.activeYellow400,
        unselectedItemColor: MainTheme.appColors.activeYellow400.withOpacity(0.5),
      ),
    );
  }
}
