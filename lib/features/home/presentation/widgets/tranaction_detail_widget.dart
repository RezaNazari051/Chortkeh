import 'package:chortkeh/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../common/utils/constants.dart';
import '../../../../common/utils/json_data.dart';
import '../../../../common/widgets/app_buttons.dart';
import '../../../../common/widgets/dialogs/delete_transaction_dialog.dart';
import '../../../../config/dimens/responsive.dart';
import '../../../../config/theme/app_color.dart';
import '../screens/home_screen.dart';

class TransactionDetailWidget extends StatelessWidget {
  const TransactionDetailWidget({
    super.key,
    required this.recentActivities, required this.index,
  });

  final List<RecentActivities> recentActivities;
  final int index;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;
    return Container(
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
              style: textTheme.bodySmall,
              text: recentActivities[index]
                  .price
                  .toStringAsFixed(0)
                  .toCurrencyFormat(),
              children: [
                TextSpan(
                  text: ' تومان',
                  style: textTheme.displaySmall!
                      .apply(color: AppColor.grayColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
class TranactionDetailBottomSheet extends StatelessWidget {
  const TranactionDetailBottomSheet({
    super.key,
    required this.recentActivity,
  });

  final RecentActivities recentActivity;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;
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
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'بازگشت'),
          const Gap(16)
        ],
      ),
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