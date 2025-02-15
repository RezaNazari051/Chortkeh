import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final bool isMobile = Responsive.isMobile();
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColor.primaryColor,
          onPrimary: Colors.white,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black),
      textTheme: TextTheme(
          headlineLarge: const TextStyle(
            fontFamily: 'IranYekanBold',
            fontSize: 32,
          ),
          headlineMedium: const TextStyle(
            fontFamily: 'IranYekanBold',
            fontSize: 24,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'IranYekanBold',
            fontSize: Responsive.isMobile() ? 20 : 26,
          ),
          titleLarge: const TextStyle(
            fontFamily: 'IranYekanBold',
            fontSize: 18,
          ),
          titleMedium: const TextStyle(
            fontFamily: 'IranYekanBold',
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            fontFamily: 'IranYekanBold',
            fontSize: isMobile ? 14 : 20,
          ),

          //<------- body ------->
          labelLarge: const TextStyle(
            fontFamily: 'IranYekan',
            fontSize: 20,
          ),
          bodyLarge: const TextStyle(
            fontFamily: 'IranYekan',
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'IranYekan',
            fontSize: Responsive.isMobile() ? 16 : 22,
          ),
          bodySmall: TextStyle(
            fontFamily: 'IranYekan',
            fontSize: isMobile ? 14 : 20,
          ),

          //<------- body ------->

          labelMedium: TextStyle(
            fontFamily: 'IranYekanMedium',
            fontSize: Responsive.isMobile() ? 16 : 22,
          ),
          labelSmall: TextStyle(
              fontFamily: 'IranYekanMedium',
              fontSize: Responsive.isMobile() ? 14 : 20),
          displaySmall: TextStyle(
              fontFamily: 'IranYekan',
              fontSize: Responsive.isMobile() ? 12 : 18)),

      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            fontFamily: 'IranYekan',
            fontSize: Responsive.isMobile() ? 16 : 22,
            color: Colors.black
          ),
      ),
      //? Outline button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.all(8),
          ),
          side: const WidgetStatePropertyAll(
            BorderSide(color: AppColor.primaryColor),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
            fontFamily: 'IranYekan',
            fontSize: Responsive.isMobile() ? 12 : 18,
            color: AppColor.grayColor),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.grayColor, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.grayColor, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: AppColor.primaryColor, width: 1)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
              fontFamily: 'IranYekan',
              color: Colors.black,
              fontSize: Responsive.isMobile() ? 12 : 18),
        ),
      ),
    );
  }
}
