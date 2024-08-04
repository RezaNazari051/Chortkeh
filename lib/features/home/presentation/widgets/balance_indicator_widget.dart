import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

import 'package:gap/gap.dart';

import '../../../../core/utils/constants.dart';

class BalanceWidget extends StatefulWidget {
  final double deposit;
  final double withdrawal;
  final BoxConstraints constraints;

  const BalanceWidget({
    super.key,
    required this.deposit,
    required this.withdrawal,
    required this.constraints,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double previousPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _updateAnimation(); // شروع انیمیشن با مقادیر اولیه
  }

  @override
  void didUpdateWidget(covariant BalanceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.deposit != oldWidget.deposit ||
        widget.withdrawal != oldWidget.withdrawal) {
      _updateAnimation(); // به‌روزرسانی انیمیشن در صورت تغییر مقادیر
    }
  }

  void _updateAnimation() {
    final double balance = widget.deposit - widget.withdrawal;
    final double newPercentage =
        (balance / widget.deposit).clamp(-1.0, 1.0).abs();

    _animation = Tween<double>(
      begin: previousPercentage, // شروع انیمیشن از مقدار قبلی
      end: newPercentage,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller
      ..reset()
      ..forward();

    previousPercentage = newPercentage; // به‌روزرسانی مقدار قبلی
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double balance = widget.deposit - widget.withdrawal;
    final double percentage = (balance / widget.deposit).clamp(-1.0, 1.0).abs();

    Color color;
    if (balance > 0) {
      color = AppColor.greenColor;
    } else if (balance < 0) {
      color = AppColor.redColor;
    } else {
      color = AppColor.lightGrayColor;
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        // padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.cardBorderGrayColor)),
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.deposit.toStringAsFixed(0).toCurrencyFormat(),
                style: textTheme.headlineSmall,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: Gap( constraints.maxWidth*0.13),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: ScreenUtil().screenWidth < 405 ? 0.8 : 1,
                    child: CustomPaint(
                      size: Size(getWidgetSize(), 0),
                      // size:Size(MediaQuery.sizeOf(context).width* 0.8, MediaQuery.sizeOf(context).width * 0.4),
                      painter: ArcPainter(
                        percentage: percentage * _animation.value,
                        color: color,
                      ),
                    ),
                  ),
                  AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: ScreenUtil().screenWidth < 405 ? 0.78 : 1,
                    child: CustomPaint(
                      size: Responsive.isMobile()
                          ? Size(getWidgetSize() - 60, getWidgetSize() - 60)
                          : Size(getWidgetSize() - 100, getWidgetSize() - 100),
                      painter: DotsPainter(
                        percentage: percentage * _animation.value,
                        color: color,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'مانده',
                        style: textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          balance.toStringAsFixed(0).toCurrencyFormat(),
                          style: textTheme.headlineSmall!.apply(
                              color: balance == 0 ? Colors.black : color),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(balance.isNegative
                              ? '$iconUrl/ic_red_warning.svg'
                              : balance == 0
                                  ? '$iconUrl/ic_grey_warning.svg'
                                  : '$iconUrl/ic_green_tick-circle.svg'),
                          const Gap(8),
                          Text(
                            balance.isNegative
                                ? 'هشدار! بیشتر از دخلت خرج کردی.'
                                : balance == 0
                                    ? 'فعلا که خبری نیست تا ببینیم چی میشه'
                                    : 'اوضاع خوبه؛ هنوز تو منطقه سبزیم.',
                            style: textTheme.displaySmall!.apply(
                              color: balance.isNegative
                                  ? AppColor.redColor
                                  : balance == 0
                                      ? AppColor.grayColor
                                      : AppColor.greenColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: AppColor.cardBorderGrayColor))),
                child: Row(
                  children: [
                    Expanded(
                      child: BalanceCardAmountDetailWidget(
                          amount: widget.deposit, isWithdrawal: false),
                    ),
                    Container(
                      width: 2,
                      height: 40,
                      color: AppColor.cardBorderGrayColor,
                    ),
                    Expanded(
                        child: BalanceCardAmountDetailWidget(
                            amount: widget.withdrawal)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  double getWidgetSize() {
    if (Responsive.isMobile()) {
      return 300;
    } else {
      return 500;
    }

    // final width = MediaQuery.of(context).size.width;
    // if (width < 600) {
    //   return 300; // موبایل
    // } else if (width < 1200) {
    //   return 400; // تبلت
    // } else {
    //   return 500; // دسکتاپ
    // }
  }
}

class ArcPainter extends CustomPainter {
  final double percentage;
  final Color color;

  ArcPainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    final backgroundPaint = Paint()
      ..color = AppColor.lightGrayColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = Responsive.isMobile() ? 40 : 60;

    canvas.drawArc(
      rect,
      -pi,
      pi,
      false,
      backgroundPaint,
    );

    final foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = Responsive.isMobile() ? 40 : 60
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -pi,
      percentage * pi,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DotsPainter extends CustomPainter {
  final Color color;
  final double percentage;

  DotsPainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    double dotRadius = Responsive.isMobile() ? 5 : 8;
    const int totalDots = 20;
    const double startAngle = -pi + .07;
    final sweepAngle = percentage * pi;

    for (int i = 0; i < totalDots; i++) {
      final double angle = startAngle + (i / totalDots) * pi;
      final Offset offset = Offset(
        size.width / 2 + (size.width / 2 - dotRadius) * cos(angle),
        size.height / 2 + (size.height / 2 - dotRadius) * sin(angle),
      );

      if (angle <= startAngle + sweepAngle) {
        paint.color = color;
      } else {
        paint.color = AppColor.lightGrayColor;
      }

      canvas.drawCircle(offset, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BalanceCardAmountDetailWidget extends StatelessWidget {
  final double amount;
  final bool isWithdrawal;

  const BalanceCardAmountDetailWidget(
      {super.key, required this.amount, this.isWithdrawal = true});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(isWithdrawal
                ? '$iconUrl/ic_card_withdraw.svg'
                : '$iconUrl/ic_card_deposit.svg'),
            const Gap(4),
            Text(isWithdrawal ? 'پرداختی' : 'دریافتی',
                style: textTheme.displaySmall),
          ],
        ),
        Text.rich(
          TextSpan(
            text: amount.toStringAsFixed(0).toCurrencyFormat(),
            style: textTheme.titleSmall,
            children: [
              TextSpan(
                text: ' تومان',
                style: textTheme.displaySmall!.apply(color: AppColor.grayColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
