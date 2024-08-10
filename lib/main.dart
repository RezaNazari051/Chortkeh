import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/theme/app_theme.dart';
import 'package:chortkeh/core/bloc/text_field_on_change_cubit.dart/cubit/bank_cubit.dart';
import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/features/home/presentation/bloc/manage_cards_bloc/card_cubit.dart';
import 'package:chortkeh/features/home/presentation/bloc/touch_chart_section_callback/chart_section_cubit.dart';
import 'package:chortkeh/features/intro/presentation/screens/splash_screen.dart';
import 'package:chortkeh/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'core/screens/main_wrapper.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  // final path = join( await getDatabasesPath(), 'Card.db');
  //
  // await deleteDatabase(path);
  await initLocator();


  runApp(MultiBlocProvider(
    providers: [
      //! Cubits
      BlocProvider(create: (context) => BottomNavbarCubit()),
      BlocProvider(create: (context) => ChartSectionCubit()),
      BlocProvider(create: (context) => BankCubit()),
      BlocProvider(create: (context) => CardCubit()),
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
    },);
  }
}
