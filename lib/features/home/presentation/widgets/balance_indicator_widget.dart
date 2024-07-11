import 'package:chortkeh/common/utils/constants.dart';
import 'package:chortkeh/common/utils/extensions.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

import 'package:gap/gap.dart';

class BalanceWidget extends StatefulWidget {
  final double deposit;
  final double withdrawal;
  final Size size;

  const BalanceWidget({
    super.key,
    required this.deposit,
    required this.withdrawal,
    required this.size,
  });

  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
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

    return Column(
      children: [
        Text(widget.deposit.toStringAsFixed(0).toCurrencyFormat(),
            style: textTheme.headlineSmall),
        Gap(50.h),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: widget.size,
              painter: ArcPainter(
                percentage: percentage * _animation.value,
                color: color,
              ),
            ),
            CustomPaint(
              size: Size(widget.size.width - 50, widget.size.height * 1.85),
              painter: DotsPainter(
                percentage: percentage * _animation.value,
                color: color,
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
                    style: textTheme.headlineSmall!.apply(color:balance==0?Colors.black: color),
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
      ],
    );
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
      ..strokeWidth = 40;

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
      ..strokeWidth = 40
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

    const double dotRadius = 5.0;
    const int totalDots = 26;
    const double startAngle = -pi;
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
