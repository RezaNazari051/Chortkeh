import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/dimens/sizer.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class FillElevatedButton extends StatelessWidget {
  const FillElevatedButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.width,
      this.height,
      this.backgroundColor,
      this.textStyle});

  final void Function() onPressed;
  final String title;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: backgroundColor ?? theme.primaryColor,
        fixedSize: Size(
            Responsive.isDesktop() ? 500 : width ?? 80.width(), height ?? 50),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style:
            textStyle ?? theme.textTheme.labelSmall!.apply(color: Colors.white),
      ),
    );
  }
}

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.width,
      this.height,
      this.borderColor = AppColor.primaryColor,
      this.textStyle});

  final void Function() onPressed;
  final String title;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        
        elevation: 0,
        side: BorderSide(color: borderColor!,width:1.5),
        overlayColor: borderColor,
        shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize: Size(
            Responsive.isDesktop() ? 500 : width ?? 80.width(), height ?? 50),

      ),
      onPressed: onPressed,
      child: Text(
        title,
        style:
            textStyle ?? theme.textTheme.labelSmall!.apply(color: borderColor),
      ),
    );
  }
}
