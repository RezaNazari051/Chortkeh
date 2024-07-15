import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/dimens/sizer.dart';
import 'package:flutter/material.dart';

class FillElevatedButton extends StatelessWidget {
  const FillElevatedButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.width,
      this.height});

  final void Function() onPressed;
  final String title;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: theme.primaryColor,
        fixedSize: Size(Responsive.isDesktop()?500:width ??80.width(), height ?? 50),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: theme.textTheme.labelSmall!.apply(color: Colors.white),
      ),
    );
  }
}
