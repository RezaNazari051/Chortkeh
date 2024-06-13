import 'package:chortkeh/common/widgets/app_buttons.dart';
import 'package:chortkeh/common/widgets/app_text_form_field.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/auth/presentation/screens/otp_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverGap( MediaQuery.of(context).viewInsets.bottom==0?12.h:5.h),
          SliverToBoxAdapter(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: Gap(
                  MediaQuery.of(context).viewInsets.bottom == 0 ? 12.h : 5.h),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/img_sign_in.svg',
                  width: 60.w,
                  height: 30.h,
                  fit: BoxFit.cover,
                ),
                const Gap(32),
                Text('لطفا شماره موبایل خود را وارد کنید.',
                    style: Theme.of(context).textTheme.bodyMedium),
                const Gap(32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PTextFormField(
                      title: 'شماره موبایل',
                      hintText: '********09',
                      controller: TextEditingController(),
                      keyboardType: TextInputType.number),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: checkValue,
                  side: const BorderSide(color: AppColor.primaryColor),
                  onChanged: (value) {
                    setState(() {
                      checkValue = value!;
                    });
                  },
                ),
                Text.rich(
                  style: Theme.of(context).textTheme.displaySmall,
                  TextSpan(
                    text: 'با ',
                    children: [
                      TextSpan(
                          text: 'قوانین و مقررات',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .apply(color: AppColor.primaryColor),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      const TextSpan(text: ' چرتکه موافقم.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.paddingOf(context).top),
                  child: FillElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, OtpScreen.routeName);
                      },
                      title: 'ثبت شماره موبایل'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
