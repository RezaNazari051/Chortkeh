import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final bool isMobile=Responsive.isMobile();
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
        textTheme:  TextTheme(
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
              fontSize: Responsive.isMobile()?20:30,
            ),
            titleLarge: TextStyle(
              fontFamily: 'IranYekanBold',
              fontSize: 18,
            ),
            titleMedium: TextStyle(
              fontFamily: 'IranYekanBold',
              fontSize: 16,
            ),
            titleSmall:  TextStyle(
              fontFamily: 'IranYekanBold',
              fontSize: isMobile?14:25,
            ),

            //<------- body ------->
            labelLarge:TextStyle(
              fontFamily: 'IranYekan',
              fontSize: 20,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'IranYekan',
              fontSize: 18,
            ),
            bodyMedium:  TextStyle(
              fontFamily: 'IranYekan',
              fontSize: Responsive.isMobile()?16:26,
            ),
            bodySmall: const TextStyle(
              fontFamily: 'IranYekan',
              fontSize: 14,
            ),

            //<------- body ------->



            labelMedium: TextStyle(fontFamily: 'IranYekanMedium', fontSize: Responsive.isMobile()?16:26,),
            labelSmall: const TextStyle(fontFamily: 'IranYekanMedium', fontSize: 14),
            displaySmall: TextStyle(fontFamily: 'IranYekan', fontSize:Responsive.isMobile()? 12:25)),

        ///? Outline button
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
            hintStyle: const TextStyle(
                fontFamily: 'IranYekanMedium',
                fontSize: 14,
                color: AppColor.grayColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColor.grayColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColor.grayColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColor.primaryColor, width: 1))));
  }
}
