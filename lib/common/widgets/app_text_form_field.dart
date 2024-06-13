import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PTextFormField extends StatelessWidget {
  const PTextFormField(
      {super.key, required this.title, required this.hintText, required this.controller, required this.keyboardType, this.maxLength,});


  final String title;
  final String hintText;
  final TextEditingController controller;

  final TextInputType keyboardType;

  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme
            .of(context)
            .textTheme
            .bodyMedium),
        const Gap(10),
        SizedBox(
          height: 50 ,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodySmall,
            maxLength:maxLength,
            textAlign: TextAlign.end,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                hintText: hintText,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16)
            ),
          ),
        ),
      ],
    );
  }
}
