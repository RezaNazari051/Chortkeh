import 'dart:async';

import 'package:chortkeh/common/widgets/app_buttons.dart';
import 'package:chortkeh/config/dimens/sizer.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../../../../common/screens/main_wrapper.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = 'OtpScreen';

  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool checkValue = false;
  Timer? _timer;
  late int _start;

  void _startTimer() {
    _start = 120;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_start > 0) {
          if(mounted){
            setState(() => _start --);
          }
        } else {
          if(mounted){
            setState(() {
              _timer!.cancel();
            });
          }
        }
      },
    );
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              // SliverGap( MediaQuery.of(context).viewInsets.bottom==0?12.h:5.h),
              SliverToBoxAdapter(
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: Gap(MediaQuery.of(context).viewInsets.bottom == 0
                      ? 12.height(context)
                      : 5.height(context)),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/img_enter_otp.svg',
                      width: 60.width(),
                      height: 30.height(context),
                      fit: BoxFit.cover,
                    ),
                    const Gap(32),
                    Text.rich(
                      style: Theme.of(context).textTheme.bodySmall,
                      TextSpan(text: 'کد ارسال‌ شده به شماره', children: [
                        TextSpan(
                            text: ' 4567 123 0915',
                            style: Theme.of(context).textTheme.bodyMedium),
                        const TextSpan(text: ' را وارد کنید.')
                      ]),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'ویرایش شماره موبایل',
                          style: theme.textTheme.displaySmall?.apply(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: MediaQuery.sizeOf(context).width * 0.05,
                              bottom: 5.h),
                          child: Text(
                            'کد تایید',
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                        Pinput(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          defaultPinTheme: PinTheme(
                            width: 60,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.grayColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 8.h, start: 5.width()),
                          child: _start != 0
                              ? Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/ic_clock.svg'),
                                    Gap(3.w),
                                    Text.rich(
                                      TextSpan(
                                        text:
                                            '${minutes.toString().padLeft(1,'0')}:${seconds.toString().padLeft(2,'0')}',
                                        style: theme.textTheme.displaySmall
                                            ?.apply(
                                                color: AppColor.primaryColor),
                                        children: [
                                          TextSpan(
                                              text: 'تا دریافت مجدد کد',
                                              style: theme
                                                  .textTheme.displaySmall
                                                  ?.apply(
                                                      color:
                                                          AppColor.grayColor))
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : InkWell(
                                  borderRadius: BorderRadius.circular(5),
                                  onTap: () {
                                    setState(() {
                                      _startTimer();
                                    });
                                  },
                                  child: Text(
                                    'دریافت مجدد کد',
                                    style: theme.textTheme.labelSmall!
                                        .apply(color: AppColor.primaryColor),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.viewInsetsOf(context).bottom == 0 ? 50.h : 20.h,
            child: FillElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, MainWrapper.routeName,(route) => false,);
                },
                title: 'تایید'),
          )
        ],
      ),
    );
  }
}
