import 'package:chortkeh/features/auth/presentation/screens/login_screen.dart';
import 'package:chortkeh/features/intro/presentation/screens/intro_screen.dart';
import 'package:chortkeh/features/intro/presentation/screens/splash_screen.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/screens/new_peleh_screen.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/screens/peleh_screen.dart';
import 'package:flutter/cupertino.dart';

import 'common/screens/main_wrapper.dart';
import 'features/auth/presentation/screens/otp_screen.dart';

Map<String , WidgetBuilder>routeMethod(){
  return <String,WidgetBuilder>{
    SplashScreen.routeName:(context)=>const SplashScreen(),
    IntroScreen.routeName:(context)=>const IntroScreen(),

    LoginScreen.routeName:(context)=>const LoginScreen(),
    OtpScreen.routeName:(context)=>const OtpScreen(),
    MainWrapper.routeName:(context)=>const MainWrapper(),
    PelehScreen.routeName:(context)=>const PelehScreen(),
    NewPelehScreen.routeName:(context)=>const NewPelehScreen(),
  };
}