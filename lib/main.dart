import 'package:chortkeh/common/bloc/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:chortkeh/config/theme/app_theme.dart';
import 'package:chortkeh/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/intro/presentation/screens/splash_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      //! Cubits
      BlocProvider(create: (context) => BottomNavbarCubit(),)

    ], child:
    const MyApp(),

    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,constraints) {
        return MaterialApp(
          locale: const Locale('fa'),
          supportedLocales: const [
            Locale('fa'),
            Locale('en'),
          ],
          localizationsDelegates: const [
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
          // initialRoute: MainWrapper.routeName,
        );
      }
    );
  }
}
