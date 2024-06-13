import 'package:chortkeh/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/widgets/app_buttons.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = 'IntroScreen';

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController=PageController();
    final ThemeData theme = Theme.of(context);
    final List<String> sliderImage = [
      'img_savings_pana.svg',
      'img_personal_finance_pana.svg',
      'img_business_mission_pana.svg'
    ];
    final Map<String, Map<String, String>>sliderTitles={
      'slider0':{
        'title':'قلک',
        'subtitle': 'تا قلک پره نگران هیچ اتفاق غیرقابل پیش‌بینی نباش.',
      },
      'slider1':{
        'title':'بودجه‌بندی',
        'subtitle': 'با کیف پول‌های جدا دیگه نگران دخل و خرجت نباش.',
      },
      'slider2':{
        'title':'پله‌پله',
        'subtitle': 'پله‌هات رو برای برای رسیدن به آرزوهات بچین.',
      },

    };

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 40.h,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: sliderImage.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/${sliderImage[index]}',
                          fit: BoxFit.cover,
                          height: 28.h,
                        ),
                        const Gap(40),
                        Text(sliderTitles['slider$index']!['title']!, style: theme.textTheme.titleMedium),
                        const Gap(20),
                        Text(
                          sliderTitles['slider$index']!['subtitle']!,
                          style: theme.textTheme.bodySmall!.apply(color: const Color(0xff717171)),
                        )
                        ,
                      ],
                    ),
                  ),
                ),
              ],

            ),
            const Gap(30),

            SmoothPageIndicator(controller: pageController, count:sliderImage.length,
              effect: ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  expansionFactor: 6,
                  dotColor:const Color(0xffe1e1e1) ,
                  activeDotColor: theme.primaryColor
              ),
            ),
            const Spacer(),
            FillElevatedButton(onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
            },title: 'ورود به اپلیکیشن'),
            Gap(6.h)
          ],
        ),
      ),
    );
  }
}
