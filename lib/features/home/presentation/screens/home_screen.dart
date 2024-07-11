
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../widgets/balance_indicator_widget.dart';

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
                  const Text(
                    'حساب‌کتاب مهرماه',
                    style: TextStyle(fontFamily: 'IranYekanBold'),
                  ),
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
           const SliverGap(20),
           SliverToBoxAdapter(
            child: BalanceWidget(deposit: 10000000, withdrawal: 1000000,size: Size(285.w, 150),),
          )
        ],
      ),
    );
  }
}

