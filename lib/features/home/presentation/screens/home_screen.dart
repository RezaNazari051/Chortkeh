import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/home/presentation/widgets/semicircular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 16,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('حساب‌کتاب مهرماه',
                      style: Theme.of(context).textTheme.titleMedium),
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('همه حساب‌ها',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .apply(color: AppColor.primaryColor)),
                        const Gap(8),
                        Transform.rotate(
                          angle: 1.5,
                          child: const Icon(
                            size: 20,
                            Icons.arrow_back_ios_new_rounded,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
           SliverToBoxAdapter(
            child: Center(
              child: SemicircularIndicator(
                radius: 150,
                color: Colors.green,
                backgroundColor: Colors.grey.shade300,
                strokeWidth: 40,
                bottomPadding: 0, received: 10000000 ,paid:5000000 ,
                // child: Text(
                //   '75%',
                //   style: TextStyle(
                //       fontSize: 32,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.orange),
                // ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
