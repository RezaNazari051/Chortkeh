import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class PTextFormField extends StatelessWidget {
  const PTextFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.name,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.onChanged,
    this.suffixIcon,
    this.inputFormatters,
    this.textDirection,
    this.focusBorderColor,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;

  final TextDirection? textDirection;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  final Color? focusBorderColor;

  @override
  Widget build(BuildContext context) {
    final InputDecorationTheme theme = Theme.of(context).inputDecorationTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        const Gap(10),
        SizedBox(
          height: 50,
          child: Stack(
            children: [
              if (suffixIcon != null)
                Positioned(
                  left: 16,
                  top: 7,
                  width: 32,
                  height: 32,
                  child: suffixIcon!,
                ),
              TextFormField(
                maxLengthEnforcement:
                    MaxLengthEnforcement.none, // عدم محاسبه فاصله‌ها
                    
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                textDirection: textDirection,
                inputFormatters: inputFormatters,
                onChanged: onChanged,
                style: Theme.of(context).textTheme.bodySmall,
                maxLength: maxLength,
                textAlign: textAlign,
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                    focusedBorder: theme.focusedBorder!.copyWith(
                        borderSide: BorderSide(
                            width: 1,
                            color: focusBorderColor ??
                                theme.focusedBorder!.borderSide.color)),
                    enabledBorder: theme.enabledBorder!.copyWith(
                        borderSide: BorderSide(
                            width: 1,
                            color: controller.text.isNotEmpty
                                ? Colors.black
                                : theme.enabledBorder!.borderSide.color)),
                    counterText: '',
                    hintText: hintText,
                    contentPadding: EdgeInsets.only(
                        right: 16, left: suffixIcon != null ? 55 : 16)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
