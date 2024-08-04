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

  @override
  Widget build(BuildContext context) {
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

                textDirection: textDirection,
                inputFormatters: inputFormatters,
                onChanged: onChanged,
                style: Theme.of(context).textTheme.bodySmall,
                maxLength: maxLength,
                textAlign: textAlign,
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  
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
