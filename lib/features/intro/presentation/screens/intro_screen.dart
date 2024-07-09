import 'package:animate_do/animate_do.dart';
import 'package:chortkeh/config/dimens/sizer.dart';
import 'package:chortkeh/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/widgets/app_buttons.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = 'IntroScreen';

  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  final List<String> sliderImage = [
    'img_savings_pana.svg',
    'img_personal_finance_pana.svg',
    'img_business_mission_pana.svg'
  ];
  final Map<String, Map<String, String>> sliderTitles = {
    'slider0': {
      'title': 'قلک',
      'subtitle': 'تا قلک پره نگران هیچ اتفاق غیرقابل پیش‌بینی نباش.',
    },
    'slider1': {
      'title': 'بودجه‌بندی',
      'subtitle': 'با کیف پول‌های جدا دیگه نگران دخل و خرجت نباش.',
    },
    'slider2': {
      'title': 'پله‌پله',
      'subtitle': 'پله‌هات رو برای برای رسیدن به آرزوهات بچین.',
    },
  };

  int currentIndex = 0;

  late AnimationController animateController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Column(
        children: [
          const SizedBox(width: double.infinity),
          const Spacer(),
          FadeInDown(
            controller: (animController) => animateController = animController,
            duration: const Duration(seconds: 1),
            child: SizedBox(
                height: 40.height(context),
                child: SvgPicture.asset(
                    'assets/images/${sliderImage[currentIndex]}')),
          ),
          const Gap(30),
          SizedBox(
            height: 10.height(context),
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
                animateController.reset();
                animateController.forward();
              },
              itemCount: sliderImage.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        sliderTitles['slider$index']!['title']!,
                        style: theme.textTheme.titleMedium,
                      ),
                      Gap(13.h),
                      Text(
                        sliderTitles['slider$index']!['subtitle']!,
                        style: theme.textTheme.bodySmall!
                            .apply(color: const Color(0xff717171)),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            onDotClicked: (index) {
              setState(
                () => pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
              );
            },
            controller: pageController,
            count: sliderImage.length,
            effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 6,
                dotColor: const Color(0xffe1e1e1),
                activeDotColor: theme.primaryColor),
          ),
          const Spacer(),
          FillElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              },
              title: 'ورود به اپلیکیشن'),
          Gap(6.height(context))
        ],
      ),
    );
  }
}
