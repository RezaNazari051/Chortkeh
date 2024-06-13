import 'package:chortkeh/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
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
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'IranYekanBold',
          fontSize: 32,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'IranYekanBold',
          fontSize: 24,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'IranYekanBold',
          fontSize: 20,
        ),
        titleLarge: TextStyle(
          fontFamily: 'IranYekanBold',
          fontSize: 18,
        ),
        titleMedium: TextStyle(
          fontFamily: 'IranYekanBold',
          fontSize: 16,
        ),
        titleSmall: TextStyle(
          fontFamily: 'IranYekanBold',
          fontSize: 14,
        ),

        //<------- body ------->
        bodyLarge: TextStyle(
          fontFamily: 'IranYekan',
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'IranYekan',
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          fontFamily: 'IranYekan',
          fontSize: 14,
        ),
        labelMedium: TextStyle(fontFamily: 'IranYekanMedium', fontSize: 16),
        labelSmall: TextStyle(fontFamily: 'IranYekanMedium', fontSize: 14),

        displaySmall: TextStyle(fontFamily: 'IranYekan', fontSize: 12)
      ),

      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(fontFamily: 'IranYekanMedium', fontSize: 14,color: AppColor.grayColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: AppColor.grayColor,width: 1) ),
          enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: AppColor.grayColor,width: 1)),
          focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(color: AppColor.primaryColor,width: 1))
      )
    );
  }
}
