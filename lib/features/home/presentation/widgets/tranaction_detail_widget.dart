import 'package:chortkeh/core/utils/extensions.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/get_transaction_status.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/recent_transactions_bloc.dart';
import 'package:chortkeh/features/transaction/data/data_source/local/transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../config/dimens/responsive.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../../core/widgets/dialogs/delete_transaction_dialog.dart';
import '../../../transaction/data/models/transaction_model.dart';
import '../screens/home_screen.dart';

class TransactionDetailWidget extends StatelessWidget {
  const TransactionDetailWidget({
    super.key,
    required this.index, required this.state,
  });

  final GetTransactionCompeted state; 
  final int index;

  @override
  Widget build(BuildContext context) {
  final List<TransactionDetail> recentActivities=state.transactions;

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: Responsive.isTablet() ? 85 : 65,
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColor.cardBorderGrayColor),
            borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onDoubleTap: () {
      context.read<RecentTransactionsBloc>().add(GetAllTransactionsEvent(type: TransactionType.withdraw));
          },
          onTap: () {
            showTransactionDetailBottomSheet(
                context, recentActivities[index],state.type);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: recentActivities[index].category.backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: SvgPicture.asset(recentActivities[index].category.iconPath),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recentActivities[index].category.name),
                      Text(formatJalali(recentActivities[index].transaction.dateTime)),
                    ],
                  ),
                ),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    style: textTheme.bodySmall,
                    text: recentActivities[index]
                        .transaction.amount
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
          ),
        ),
      ),
    );
  }
}

class TransactionDetailBottomSheet extends StatelessWidget {
  const TransactionDetailBottomSheet({
    super.key,
    required this.transactionDetail, required this.type, required this.bloc,
  });

  final TransactionDetail transactionDetail;
  final TransactionType type;
  final RecentTransactionsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final isWithdraw=type==TransactionType.withdraw;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
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
                              return  DeleteTransactionDialog(transactionDetail:transactionDetail ,bloc: bloc);
                            });
                      },
                      icon: InkWell(
                        child: SvgPicture.asset('$iconUrl/ic_trash.svg')),
                    ),
                  ],
                ))
              ],
            ),
            const Gap(16),
            TransactionDetailBottomSheetRowData(
                title:isWithdraw? 'دسته‌بندی پرداخت':'دسته‌بندی واریز', detail: transactionDetail.category.name),
            TransactionDetailBottomSheetRowData(
                title:type==TransactionType.withdraw? 'مبلغ پرداخت':'مبلغ واریزی',
                detail:
                    '${transactionDetail.transaction.amount.toStringAsFixed(0).toCurrencyFormat()} تومان'),
            TransactionDetailBottomSheetRowData(
                title:isWithdraw? 'برداشت از':'واریز به', detail: transactionDetail.card.cardName),
            TransactionDetailBottomSheetRowData(
              title: 'تاریخ و ساعت',
              detail: formatJalali(transactionDetail.transaction.dateTime),
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
      ),
    );
  }
}

class TransactionDetailBottomSheetRowData extends StatelessWidget {
  const TransactionDetailBottomSheetRowData({
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

Future<void> showTransactionDetailBottomSheet(
    BuildContext context, TransactionDetail detail, TransactionType type) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return TransactionDetailBottomSheet(transactionDetail:detail,type: type,bloc: context.read<RecentTransactionsBloc>(),);
    },
  );
}
