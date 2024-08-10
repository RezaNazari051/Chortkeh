import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/core/widgets/app_buttons.dart';
import 'package:chortkeh/core/widgets/app_text_form_field.dart';
import 'package:chortkeh/features/home/presentation/screens/home_screen.dart';
import 'package:chortkeh/features/home/presentation/widgets/channel_list_bottom_sheet.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/blocs/cubit/cubit/change_tabbar_index_cubit.dart';
import 'package:chortkeh/features/transaction/presentation/bloc/transaction_form_bloc/bloc/transaction_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:ir_datetime_picker/ir_datetime_picker.dart' as ir;
import 'package:ir_datetime_picker/ir_datetime_picker.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../../core/utils/constants.dart';
import '../../../peleh_peleh/presentation/screens/peleh_screen.dart';
import '../widgets/select_transaction_bottom_sheet.dart';

class AddTransactionScreen extends StatefulWidget {
  static const String routeName = '/add-transaction';
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late TextEditingController _amountController;

  final List<String> category = [
    'حقوق',
    'پاداش',
    'وام',
    'سود سرمایه',
    'یارانه'
  ];
  @override
  void initState() {
    _amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeTabbarIndexCubit()),
        BlocProvider(
          create: (context) => TransactionFormBloc(),
        )
      ],
      child: BlocBuilder<ChangeTabbarIndexCubit, int>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'ثبت تراکنش',
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  '$iconUrl/ic_arrow_right.svg',
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: SizedBox(
                  height: 40,
                  child: ChortkehTabBar(
                    titles: const ['دریافت', 'پرداخت'],
                    state: state,
                    onTap: (index) {
                      context.read<ChangeTabbarIndexCubit>().changeIndex(index);
                    },
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05,
                          vertical: 24),
                      child: IndexedStack(
                        children: [
                          BlocBuilder<TransactionFormBloc,
                              TransactionFormState>(
                            builder: (context, state) {
                              return Column(
                                children: [
                                  PTextFormField(
                                      title: 'مبلغ',
                                      hintText: 'مبلغ درآمد',
                                      controller: _amountController),
                                  //* SelectTransactionChannel
                                  DropDownBottomSheet(
                                    bottomSheetContent: BlocProvider.value(
                                      value:
                                          context.read<TransactionFormBloc>(),
                                      child: const ChannelListBottomSheet(
                                        inTransaction: true,
                                      ),
                                    ),
                                    title: state.channelStatus?.cardModel
                                            ?.cardName ??
                                        'انقال به',
                                  ),
                                  //* SelectTransactionCategory
                                  DropDownBottomSheet(
                                    bottomSheetContent: BlocProvider.value(
                                      value:
                                          context.read<TransactionFormBloc>(),
                                      child:
                                          const SelectCategoryBottomSheetWidget(),
                                    ),
                                    title:
                                        state.categoryStatus?.category?.name ??
                                            'دسته‌بندی',
                                  ),

                                  DropDownBottomSheet(
                                    // TODO Fix This
                                  title: ''
                                            //  title: state.dateStatus?.date!=null?formatJalali(state.dateStatus!.date!,showTime: false):
                                        'تاریخ',
                                    bottomSheetContent: BlocProvider.value(
                                        value:
                                            context.read<TransactionFormBloc>(),
                                        child:

                                            //  datePicker.PCalendarDatePicker(firstDate: datePicker.Jalali(1385, 8), initialDate: datePicker.Jalali(1385, 8),
                                            //  lastDate: datePicker.Jalali.now(),
                                            //  onDateChanged: (value) {},

                                            //  )
                                            SafeArea(
                                          child: Builder(
                                            builder: (context) {
                                              Jalali date =Jalali.now();
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    width: 60,
                                                    height: 5,
                                                    decoration: BoxDecoration(
                                                        color: AppColor
                                                            .cardBorderGrayColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                28)),
                                                  ),
                                                  const Gap(16),
                                                  Text('تاریخ',
                                                      style: textTheme.titleSmall),
                                                  ir.IRJalaliDatePicker(
                                                    diameterRatio: 3,
                                                    squeeze: 1,
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 100),
                                                    todayButtonText: '',
                                                    onSelected:
                                                        (Jalali jalaliDate) {
                                                          date=jalaliDate;
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
                                                          },
                                                          title: 'تایید',
                                                          backgroundColor: AppColor
                                                              .lightBlueColor,
                                                          textColor:
                                                              AppColor.primaryColor,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Expanded(
                                                        child: FillElevatedButton(
                                                          onPressed: () {
                                                            date=Jalali.now();
                                                            context.read<TransactionFormBloc>().add(SelectTransactionDateEvent(date: 
                                                            jalaliToDateTime(date)));
                                                            Navigator.pop(context);
                                                          },
                                                          title: 'امروز',
                                                          backgroundColor:
                                                              Colors.white,
                                                          textColor: Colors.black,
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: FillElevatedButton(
                                                        onPressed: () {},
                                                        title: 'لغو',
                                                        backgroundColor:
                                                            Colors.white,
                                                        textColor: Colors.black,
                                                      )),
                                                    ],
                                                  )
                                                ],
                                              );
                                            }
                                          ),
                                        )),
                           
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                FillElevatedButton(onPressed: () {}, title: 'ثبت درآمد'),
                const Gap(64)
              ],
            ),
          );
        },
      ),
    );
  }
}

class DropDownBottomSheet extends StatelessWidget {
  final String title;
  final Widget bottomSheetContent;
  const DropDownBottomSheet({
    super.key,
    required this.title,
    required this.bottomSheetContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.grayColor)),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return bottomSheetContent;
              },
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 50,
            padding: const EdgeInsetsDirectional.only(
                start: 8, end: 16, top: 9, bottom: 9),
            width: double.infinity,
            // height: 40,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SvgPicture.asset('$iconUrl/ic_arrow_down.svg')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  onTap: () {
//                                     showModalBottomSheet(
//                                       context: context,
//                                       builder: (context) {
//                                         return const SelectCategoryBottomSheetWidget();
//                                       },
//                                     );
//                                   },
