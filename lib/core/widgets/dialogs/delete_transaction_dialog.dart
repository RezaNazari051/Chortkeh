import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/transaction/data/data_source/local/transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../features/home/presentation/bloc/recent_transactions_bloc/recent_transactions_bloc.dart';
import '../../screens/main_wrapper.dart';
import '../../utils/constants.dart';
import '../app_buttons.dart';

class DeleteTransactionDialog extends StatelessWidget {
  const DeleteTransactionDialog({
    super.key,
    required this.transactionDetail, required this.bloc,
  });

  final TransactionDetail transactionDetail;
  final RecentTransactionsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    bool undoPressed = false; // پرچم برای کنترل کلیک برگردون

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        Row(
          children: [
            Expanded(
              child: AppOutlineButton(
                width: 0,
                onPressed: () {
                  Navigator.pop(context);
                },
                title: 'انصراف',
              ),
            ),
            const Gap(16),
            Expanded(
              child: AppOutlineButton(
                width: 0,
                onPressed: () {
                  // نمایش اسنک‌بار و منتظر ماندن برای بسته شدن آن
                  scaffoldMessenger
                      .showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: const Color(0xff323232),
                          duration: const Duration(seconds: 3),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('تراکنش حذف شد.',
                                  style: textTheme.displaySmall!
                                      .apply(color: Colors.white)),
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  // کاربر برگردون را زد
                                  undoPressed = true;
                                  scaffoldMessenger.clearSnackBars();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset('$iconUrl/ic_undo.svg'),
                                      const Gap(5),
                                      Text('برگردون',
                                          style: textTheme.displaySmall!
                                              .apply(color: Colors.white))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .closed
                      .then((_) {
                    // چک کردن اینکه دکمه برگردون زده نشده باشد
                    if (!undoPressed ) {
                      // اگر برگردون زده نشده بود، حذف تراکنش انجام شود
                     bloc.add(
                          DeleteTransactionEvent(
                              transaction: transactionDetail));
                              
           
                    }
                  });

                  Navigator.popUntil(context,
                      (route) => route.settings.name == MainWrapper.routeName);
                }, 
                title: 'حذف',
                borderColor: AppColor.redColor,
              ),
            ),
          ],
        ),
      ],
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: Row(
        children: [
          IconButton(
              onPressed: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              icon: SvgPicture.asset('$iconUrl/ic_close_circle.svg')),
          const Spacer(),
          Text(
            'حذف تراکنش',
            style: textTheme.labelMedium,
          ),
          const Spacer(),
          const Gap(24),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 50,
        child: const Center(
          child: Text('از حذف تراکنش اطمینان دارید؟'),
        ),
      ),
    );
  }
}
