import 'package:chortkeh/common/utils/constants.dart';
import 'package:chortkeh/common/utils/extensions.dart';
import 'package:chortkeh/config/dimens/responsive.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/home/presentation/widgets/recent_activities_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../../common/utils/json_data.dart';
import '../../../../common/widgets/app_buttons.dart';
import '../../../../common/widgets/dialogs/delete_transaction_dialog.dart';
import '../widgets/balance_indicator_widget.dart';
import '../widgets/features_cards_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final List<RecentActivities> recentActivities = [
      RecentActivities(
          category: 'ماشین',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffFCF8D2),
          date: DateTime.now(),
          price: 3750000,
          value: 25,
          icon: '$categoryIcon/ic_car.svg'),
      RecentActivities(
          category: 'سلامتی',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffDCF1DB),
          date: DateTime.now(),
          price: 650000,
          value: 10,
          icon: '$categoryIcon/ic_hospital.svg'),
      RecentActivities(
          category: 'خوردنی',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffFCE6D4),
          date: DateTime.now(),
          price: 900000,
          value: 13,
          icon: '$categoryIcon/ic_cake.svg'),
      RecentActivities(
          category: 'خریدنی',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffDAE2F0),
          date: DateTime.now(),
          price: 550000,
          value: 11,
          icon: '$categoryIcon/ic_bag.svg'),
      RecentActivities(
          category: 'خوش گذرونی',
          bankCard: 'کارت پاسارگاد',
          color: const Color(0xffECDEED),
          date: DateTime.now(),
          price: 3250000,
          value: 45,
          icon: '$categoryIcon/ic_headphone.svg'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
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
                      Text(
                        'حساب‌کتاب مهرماه',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('همه حساب‌ها',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
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
              const SliverGap(0),
              SliverToBoxAdapter(
                child: BalanceWidget(
                  deposit: 50000000,
                  withdrawal: 4900000,
                  constraints: constraints,
                ),
              ),
              const SliverGap(24),
              const FeaturesCardsList(),
              const SliverGap(24),

              ///Recent activities in month Widget
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text('فعالیت‌های اخیر مهرماه',
                        style: Theme.of(context).textTheme.labelMedium),
                    const Spacer(),
                    InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          '$iconUrl/ic_sort.svg',
                          fit: BoxFit.cover,
                          width: constraints.maxWidth * 0.045,
                        )),
                    const Gap(20),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        '$iconUrl/ic_filter.svg',
                        fit: BoxFit.cover,
                        width: constraints.maxWidth * 0.045,
                      ),
                    ),
                  ],
                ),
              ),

              const SliverGap(20),

              RecentActivitiesChartWidget(constraints: constraints),

              const SliverGap(100),
              SliverList.builder(
                  itemCount: recentActivities.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showTransactionDetailBottomSheet(
                            context, recentActivities, index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColor.cardBorderGrayColor),
                            borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.only(bottom: 10),
                        height: Responsive.isTablet() ? 85 : 65,
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: recentActivities[index].color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                    recentActivities[index].icon),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(recentActivities[index].category),
                                  Text(convertDateToJalali(
                                      recentActivities[index].date)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text.rich(
                              TextSpan(
                                style: Theme.of(context).textTheme.bodySmall,
                                text: recentActivities[index]
                                    .price
                                    .toStringAsFixed(0)
                                    .toCurrencyFormat(),
                                children: [
                                  TextSpan(
                                    text: ' تومان',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .apply(color: AppColor.grayColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showTransactionDetailBottomSheet(BuildContext context,
      List<RecentActivities> recentActivities, int index) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        final recentActivity = recentActivities[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: double.infinity),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                    color: AppColor.cardBorderGrayColor,
                    borderRadius: BorderRadius.circular(28)),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text('جزئیات تراکنش', style: textTheme.labelSmall),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset('$iconUrl/ic_edit.svg'),
                      const Gap(20),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return const DeleteTransactionDialog();
                              });
                        },
                        icon: SvgPicture.asset('$iconUrl/ic_trash.svg'),
                      ),
                    ],
                  ))
                ],
              ),
              const Gap(16),
              TranactionDetailBottomSheetRowData(
                  title: 'دسته‌بندی پرداخت', detail: recentActivity.category),
              TranactionDetailBottomSheetRowData(
                  title: 'مبلغ پرداخت',
                  detail:
                      '${recentActivity.price.toStringAsFixed(0).toCurrencyFormat()} تومان'),
              TranactionDetailBottomSheetRowData(
                  title: 'برداشت از', detail: recentActivity.bankCard),
              TranactionDetailBottomSheetRowData(
                title: 'تاریخ و ساعت',
                detail: convertDateToJalali(recentActivity.date),
                marginBottom: 16,
              ),
              FillElevatedButton(
                  backgroundColor: const Color(0xffEBEFFB),
                  textStyle:
                      textTheme.labelSmall!.apply(color: AppColor.primaryColor),
                  onPressed: () {},
                  title: 'بازگشت'),
              const Gap(16)
            ],
          ),
        );
      },
    );
  }
}


class TranactionDetailBottomSheetRowData extends StatelessWidget {
  const TranactionDetailBottomSheetRowData({
    super.key,
    required this.title,
    required this.detail,
    this.marginBottom = 12,
  });
  final String title;
  final String detail;
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: marginBottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.bodyMedium),
          Text(
            detail,
            style: textTheme.bodyMedium!.apply(
              color: AppColor.grayColor,
            ),
          )
        ],
      ),
    );
  }
}

String convertDateToJalali(DateTime dateTime) {
  final Jalali jalali = Jalali.fromDateTime(dateTime);

  final date = jalali.formatter;

  return '${date.wN}، ${date.d}${date.mN}، ${date.y}، ${jalali.hour}:${jalali.minute}';
}
