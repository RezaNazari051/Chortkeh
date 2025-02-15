// ignore_for_file: use_build_context_synchronously

import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/core/widgets/app_buttons.dart';
import 'package:chortkeh/core/widgets/app_text_form_field.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/recent_transactions_bloc.dart';
import 'package:chortkeh/features/home/presentation/screens/home_screen.dart';
import 'package:chortkeh/features/home/presentation/widgets/channel_list_bottom_sheet.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/blocs/cubit/cubit/change_tabbar_index_cubit.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:chortkeh/features/transaction/presentation/bloc/transaction_form_bloc/bloc/add_transaction_status.dart';
import 'package:chortkeh/features/transaction/presentation/bloc/transaction_form_bloc/bloc/transaction_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/tab_bar_widget.dart';
import '../widgets/select_date_and_time_bottom_sheet.dart';
import '../widgets/select_transaction_bottom_sheet.dart';

enum TransactionFormWidgetMode { deposit, withdraw }

class AddTransactionScreen extends StatefulWidget {
  static const String routeName = '/add-transaction';
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late TextEditingController _amountController;

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChangeTabbarIndexCubit()),
        BlocProvider(
          create: (context) => TransactionFormBloc(),
        )
      ],
      child: BlocBuilder<ChangeTabbarIndexCubit, int>(
        builder: (context, tabState) {
          return LayoutBuilder(
            builder: (context, constraints) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
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
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal:constraints.maxWidth *0.05),
                    child: SizedBox(
                      height: 40,
                      child: ChrotkehTabBarWidget(tabLabes: const ['دریافت','پرداخت'], onTap: (index) {
                        context.read<ChangeTabbarIndexCubit>().changeIndex(index);
                      }, state: tabState
                      ),
                    ),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05,
                          vertical: 24),
                      child: IndexedStack(
                        index: tabState,
                        children: [
                          TransactionFormWidget(
                              amountController: _amountController),
                          TransactionFormWidget(
                              mode: TransactionFormWidgetMode.withdraw,
                              amountController: _amountController),
                        ],
                      ),
                    ),
                  ),
                  BlocConsumer<TransactionFormBloc, TransactionFormState>(
                    listenWhen: (previous, current) => previous.transactionStatus!=current.transactionStatus,
                    // listenWhen: (previous, current) {
                    //   return previous.transactionStatus != current.transactionStatus;
                    // },
                    listener: (context, state) {
                      if (state.transactionStatus is AddTransactionFailed) {
                        final data =
                            state.transactionStatus as AddTransactionFailed;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(data.error),
                          ),
                        );
                      }
                      else if(state.transactionStatus is AddTransactionCompleted){

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('تراکنش با موفقیت ثبت شد'),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 2),() => Navigator.pop(context),).then((value) {
                          // context.read<CardCubit>().loadCards();
                          context.read<RecentTransactionsBloc>().add(GetAllTransactionsEvent(type: TransactionType.withdraw));
                        },);
                      }
                    },
                    builder: (context, state) {
                      return FillElevatedButton(
                          onPressed: () {
                            if (state.channelStatus?.cardModel != null &&
                                state.categoryStatus?.category != null &&
                                state.dateStatus?.date != null &&
                                state.timeStatus?.time != null &&
                                _amountController.text.isNotEmpty) {
                              final DateTime date = state.dateStatus!.date!;
                              final DateTime time = state.timeStatus!.time!;
                              final DateTime dateTime = DateTime(date.year,
                                  date.month, date.day, time.hour, time.minute);
                              final TransactionModel transactionModel =
                                  TransactionModel(
                                      cardId: state.channelStatus!.cardModel!.id!,
                                      categoryId:
                                          state.categoryStatus!.category!.id,
                                      amount:
                                          double.parse(_amountController.text),
                                      dateTime: dateTime,
                                      type: tabState == 0
                                          ? TransactionType.deposit
                                          : TransactionType.withdraw);

                              context.read<TransactionFormBloc>().add(
                                  AddTransactionEvent(
                                      transactionModel: transactionModel));
                            }
                          },
                          loading: state.transactionStatus is AddTransactionLoading,
                          title: tabState == 0 ? 'ثبت درآمد' : 'ثبت هزینه');
                    },
                  ),
                  const Gap(64)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TransactionFormWidget extends StatelessWidget {
  final TransactionFormWidgetMode mode;
  const TransactionFormWidget({
    super.key,
    required TextEditingController amountController,
    this.mode = TransactionFormWidgetMode.deposit,
  }) : _amountController = amountController;

  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormBloc, TransactionFormState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              PTextFormField(
                  focusBorderColor: Colors.black,
                  title: 'مبلغ',
                  hintText: isDeposit(mode) ? 'مبلغ درآمد' : 'مبلغ هزینه',
                  controller: _amountController),
              //* SelectTransactionChannel
              DropDownBottomSheet(
                  hintText: isDeposit(mode) ? 'انقال به' : 'برداشت از',
                  bottomSheetContent: BlocProvider.value(
                    value: context.read<TransactionFormBloc>(),
                    child: const ChannelListBottomSheet(
                      inTransaction: true,
                    ),
                  ),
                  title: state.channelStatus?.cardModel?.cardName),
              //* SelectTransactionCategory
              DropDownBottomSheet(
                  hintText: 'دسته‌بندی',
                  bottomSheetContent: BlocProvider.value(
                    value: context.read<TransactionFormBloc>(),
                    child: SelectCategoryBottomSheetWidget(
                      mode: mode,
                    ),
                  ),
                  title: state.categoryStatus?.category?.name),
          
              DropDownBottomSheet(
                hintText: 'تاریخ',
                suffixIconPath: 'ic_calendar.svg',
                title: state.dateStatus?.date == null
                    ? null
                    : formatJalali(state.dateStatus!.date!,
                        mode: FormatMode.withMonthName),
                // state.dateStatus!.date=null?
                //      formatJalali(state.dateStatus!.date!,
                //         mode: FormatMode.withMonthName)
                //   :null,
                bottomSheetContent: BlocProvider.value(
                    value: context.read<TransactionFormBloc>(),
                    child: const SelectDateAndTimeBottomSheetWidget()),
              ),
              DropDownBottomSheet(
                alignment: MainAxisAlignment.end,
                title: state.timeStatus?.time == null
                    ? null
                    : formatTime(state.timeStatus!.time!),
                hintText: 'ساعت',
                suffixIconPath: 'ic_clock.svg',
                bottomSheetContent: BlocProvider.value(
                    value: context.read<TransactionFormBloc>(),
                    child:
                        const SelectDateAndTimeBottomSheetWidget(showTime: true)),
              ),
            ],
          ),
        );
      },
    );
  }

  bool isDeposit(TransactionFormWidgetMode mode) {
    return mode == TransactionFormWidgetMode.deposit;
  }
}

class DropDownBottomSheet extends StatelessWidget {
  final String? title;
  final String suffixIconPath;
  final String hintText;
  final MainAxisAlignment alignment;
  final Widget bottomSheetContent;
  const DropDownBottomSheet({
    super.key,
    required this.title,
    required this.bottomSheetContent,
    this.suffixIconPath = 'ic_arrow_down.svg',
    this.alignment = MainAxisAlignment.spaceBetween,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: title != null ? Colors.black : AppColor.grayColor)),
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
              mainAxisAlignment:
                  title != null ? alignment : MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? hintText,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .apply(color: title == null ? AppColor.grayColor : null),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 4),
                  // ignore: deprecated_member_use
                  child: SvgPicture.asset('$iconUrl/$suffixIconPath',
                      color: title != null ? Colors.black : AppColor.grayColor),
                )
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
