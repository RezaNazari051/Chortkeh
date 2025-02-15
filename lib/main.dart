import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/theme/app_theme.dart';
import 'package:chortkeh/core/bloc/text_field_on_change_cubit.dart/cubit/bank_cubit.dart';
import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/features/home/presentation/bloc/manage_cards_bloc/card_cubit.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/recent_transactions_bloc.dart';
import 'package:chortkeh/features/home/presentation/bloc/touch_chart_section_callback/chart_section_cubit.dart';
import 'package:chortkeh/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'core/screens/main_wrapper.dart';
import 'features/intro/presentation/screens/splash_screen.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();


  runApp(MultiBlocProvider(
    providers: [
      //! Cubits
      BlocProvider(create: (context) => BottomNavbarCubit()),
      BlocProvider(create: (context) => ChartSectionCubit()),
      BlocProvider(create: (context) => BankCubit()),
      BlocProvider(create: (context) => CardCubit()),
      BlocProvider(create: (context) => RecentTransactionsBloc(locator())),
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
        title: 'Chortkeh',
        theme: AppTheme.lightTheme(),
        themeMode: ThemeMode.light,
        routes: routeMethod(),
        initialRoute: MainWrapper.routeName,
        // initialRoute: SplashScreen.routeName,
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
