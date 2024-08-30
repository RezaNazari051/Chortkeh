import 'package:flutter/material.dart';

import '../../config/theme/app_color.dart';



class ChrotkehTabBarWidget extends StatelessWidget {
  const ChrotkehTabBarWidget({
    super.key,
    required this.tabLabes,
    required this.onTap, required this.state,
  });
  final Function(int index) onTap;
  final int state;
  final List<String> tabLabes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.lightGrayColor, width: 1)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
              children: List.generate(
            tabLabes.length,
            (index) =>_getTap(context, index, tabLabes[index], onTap)
           
            
          ));
        },
      ),
    );
  }
  Widget _getTap(
    BuildContext context,
    int index,
    String lable,
    Function(int index) onTap,
  ){
    return  Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: index == state ? AppColor.primaryColor : null,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
              child: Text(
            lable,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color:
                      state == index ? Colors.white : const Color(0xffADADAD),
                ),
          )),
        ),
      ),
    );
  }
}