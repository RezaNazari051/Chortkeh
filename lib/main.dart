import 'package:chortkeh/config/theme/app_theme.dart';
import 'package:chortkeh/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'features/intro/presentation/screens/splash_screen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context,orientation,screenType) {
        return MaterialApp(
          locale: const Locale('fa'),
          supportedLocales: const[
            Locale('fa'),
            Locale('en'),
          ],
          localizationsDelegates: const[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme(),
          themeMode: ThemeMode.light,
          routes: routeMethod(),
          initialRoute: SplashScreen.routeName,
        );
      }
    );
  }
}
