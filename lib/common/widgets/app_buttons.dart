import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
        fixedSize: Size(width ?? 88.w, height ?? 50),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: theme.textTheme.labelSmall!.apply(color: Colors.white),
      ),
    );
  }
}
