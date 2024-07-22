import 'package:chortkeh/common/bloc/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/theme/app_theme.dart';
import 'package:chortkeh/features/home/presentation/bloc/touch_chart_section_callback/chart_section_cubit.dart';
import 'package:chortkeh/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/screens/main_wrapper.dart';
import 'features/intro/presentation/screens/splash_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      //! Cubits
      BlocProvider(create: (context) => BottomNavbarCubit()),
      BlocProvider(create: (context) => ChartSectionCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, constraints) {
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
        // initialRoute: SplashScreen.routeName,
        initialRoute: MainWrapper.routeName,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              if (Responsive.isDesktop()) {
                return Center(
                  child: SizedBox(
                    width: 600,
                    child: child,
                  ),
                );
              }
              return child!;
            },
          );
        },
      );
    });
  }
}
