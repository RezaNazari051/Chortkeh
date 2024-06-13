import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {

  static const String routeName = 'SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _showText = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light),);
    _fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _scaleController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1), value: 0.3);

    _scaleAnimation =
        CurvedAnimation(parent: _scaleController, curve: Curves.ease);

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.ease);

    _fadeController.forward();
    _fadeController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _scaleController.forward();
        }
        _scaleController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _showText = true;
            });
            Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                IntroScreen.routeName,
                (route) => false,
              ),
            );
          }
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            top: _scaleController.isCompleted ? 65.h : 55.h,
            duration: const Duration(milliseconds: 500),
            child: Center(
              child: AnimatedOpacity(
                opacity: _showText ? 1 : 0,
                duration: const Duration(seconds: 1),
                child: Text(
                  'با اپلیکیش چُرتکه \n دیگه چُرتکه ننداز',
                  style: theme.textTheme.headlineMedium!
                      .apply(color: theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ),
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset('assets/images/img_splash_icon.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
}
