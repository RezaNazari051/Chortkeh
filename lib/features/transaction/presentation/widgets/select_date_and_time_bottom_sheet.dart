import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ir_datetime_picker/ir_datetime_picker.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../core/widgets/app_buttons.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../bloc/transaction_form_bloc/bloc/transaction_form_bloc.dart';

class SelectDateAndTimeBottomSheetWidget extends StatelessWidget {
  final bool showTime;
  const SelectDateAndTimeBottomSheetWidget({
    this.showTime = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Builder(builder: (context) {
        Jalali date = Jalali.now();
        IRTimeModel time=IRTimeModel(hour: date.hour, minute: date.minute);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                  color: AppColor.cardBorderGrayColor,
                  borderRadius: BorderRadius.circular(28)),
            ),
            const Gap(16),
            Text(showTime?'':'تاریخ', style: textTheme.titleSmall),
            showTime
                ? IRTimePicker(
                  textStyle: textTheme.titleSmall,
                    diameterRatio: 3,
                    squeeze: 1,
                    constraints: const BoxConstraints(maxHeight: 100),
                    nowButtonText: '',
                    onSelected: (IRTimeModel value) {
                      time=value;
                    },
                    visibleNowButton: false,
                    visibleSecondsPicker: false,
                  )
                : IRJalaliDatePicker(
                  textStyle: textTheme.titleSmall,
                    diameterRatio: 3,
                    squeeze: 1,
                    constraints: const BoxConstraints(maxHeight: 100),
                    todayButtonText: '',
                    onSelected: (Jalali jalaliDate) {
                      date = jalaliDate;
                    },
                    minYear: 1400,
                    maxYear: Jalali.now().year,
                    initialDate: Jalali.now(),
                    magnification: 1,
                    visibleTodayButton: false,
                  ),
            const Gap(32),
            Row(
              children: [
                Expanded(
                  child: FillElevatedButton(
                    onPressed: () {
                      if(showTime){
                        final now=DateTime.now();
                        final selectedTime=DateTime(now.year,now.month,now.day,time.hour,time.minute);
                        context.read<TransactionFormBloc>().add(SelectTransactionTimeEvent(time: selectedTime));
                      }
                      else{
            context.read<TransactionFormBloc>().add(
                            SelectTransactionDateEvent(
                              date: jalaliToDateTime(date),
                            ),
                          );
                      }
          
                      Navigator.pop(context);
                    },
                    title: 'تایید',
                    backgroundColor: AppColor.lightBlueColor,
                    textColor: AppColor.primaryColor,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child:!showTime? FillElevatedButton(
                    onPressed: () {
                      date = Jalali.now();
                      context.read<TransactionFormBloc>().add(
                          SelectTransactionDateEvent(
                              date: jalaliToDateTime(date)));
                      Navigator.pop(context);
                    },
                    title: 'امروز',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  ):const SizedBox.shrink()
                ),
                Expanded(
                    child: FillElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: 'لغو',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                )),
              ],
            )
          ],
        );
      }),
    );
  }
}
