import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/core/bloc/text_field_on_change_cubit.dart/cubit/bank_cubit.dart';
import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/core/utils/check_card_number.dart';
import 'package:chortkeh/core/utils/constants.dart';
import 'package:chortkeh/core/widgets/app_buttons.dart';
import 'package:chortkeh/core/widgets/app_text_form_field.dart';
import 'package:chortkeh/core/widgets/dialogs/general_dialogs.dart';
import 'package:chortkeh/features/home/data/data_source/local/cards_data_helper.dart';
import 'package:chortkeh/features/home/data/model/card_model.dart';
import 'package:chortkeh/features/home/presentation/bloc/manage_cards_bloc/card_cubit.dart';
import 'package:chortkeh/features/home/presentation/screens/card_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AddCardScreen extends StatefulWidget {
  static const String routeName = '/AddCardScreen';

  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late TextEditingController _cardNumberController;
  late TextEditingController _initialBalanceController;

  String icon = '';

  @override
  void initState() {
    _cardNumberController = TextEditingController();
    _initialBalanceController = TextEditingController();
    context.read<BankCubit>().resetState();
    super.initState();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _initialBalanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;
    final CardModel? editCardModel =
        ModalRoute.of(context)?.settings.arguments as CardModel?;
    if (editCardModel != null) {
      _cardNumberController.text = editCardModel.cardNumber;
      _initialBalanceController.text = editCardModel.balance.toStringAsFixed(0);
    context.read<BankCubit>().cardNumberChanged(editCardModel.cardNumber);

    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
             leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  '$iconUrl/ic_arrow_right.svg',
                ),
              ),
          actions: [
            if (editCardModel != null)
              IconButton(
                tooltip: 'حذف کارت',
                onPressed: () { 
                  
                  showDialog(context: context, builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('حذف کانال',style: textTheme.titleSmall,),
                            const Gap(16),
                            Text('آیا از حذف کانال ورودی مطمئنی؟',style: textTheme.displaySmall),
                            const Gap(5), 
                            Text('در صورت حذف، تمام تراکنش‌های مربوط به کانال حذف خواهد شد.',
                            style: textTheme.displaySmall!.apply(color: AppColor.grayColor),
                            textAlign: TextAlign.center,),
                            const Gap(16),
                            Row(children: [
                              Expanded(child: AppOutlineButton(onPressed: (){
                                Navigator.pop(context);
                              }, title: 'بازگشت')),
                              const Gap(12),
                              Expanded(child: FillElevatedButton(onPressed: (){
                                context.read<CardCubit>().deleteCard(editCardModel.id!);
                                Navigator.popUntil(context,(route) => route.settings.name==CardListScreen.routeName);
                              }, title: 'حذف کردن',
                              backgroundColor: AppColor.lightRedColor,textColor:const Color(0xffC30000),)),
                            ],)
                          ],
                        ),
                      ),
                    );
                  },);
                  // dbHelper.deleteCard(editCardModel.id!).then();
                },
                icon: SvgPicture.asset(
                  '$iconUrl/ic_trash.svg',
                  color: Colors.black,
                ),
              ),
            // Gap(constraints.maxWidth * 0.05),
          ],
          // : SvgPicture.asset('$iconUrl'),
          centerTitle: true,
          title: Text(
              editCardModel != null
                  ? 'ویرایش کانال'
                  : 'اضافه کردن کانال‌ ورودی',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
          child: Form(
            //  TODO: add formKey
            child: Column(
              children: [
                BlocBuilder<BankCubit, BankState>(
                  builder: (context, state) {
                    return PTextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                          LengthLimitingTextInputFormatter(19)
                        ],
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        maxLength: 16,
                        suffixIcon: state is BankUpdated &&
                                state.bankInfo != null &&
                                state.bankInfo!.iconPath.isNotEmpty
                            ? SvgPicture.asset(
                                '$cardIcon/${state.bankInfo?.iconPath}',
                                fit: BoxFit.cover,
                              )
                            : null,
                        onChanged: (value) {
                          if (value.length > 4) {
                            context
                                .read<BankCubit>()
                                .cardNumberChanged(value.replaceAll(' ', ''));
                          }
                        },
                        title: 'شماره کارت ۱۶ رقمی',
                        keyboardType: TextInputType.number,
                        hintText: '',
                        controller: _cardNumberController);
                  },
                ),
                PTextFormField(
                    title:
                        editCardModel != null ? 'موجودی' : 'موجودی اولیه کارت',
                    hintText: '۰ تومان',
                    keyboardType: TextInputType.number,
                    controller: _initialBalanceController),
                if (icon.isNotEmpty)
                  SvgPicture.asset(
                    '$cardIcon/$icon',
                  ),
                const Spacer(),
                BlocBuilder<BankCubit, BankState>(
                  builder: (context, state) {
                    return FillElevatedButton(
                        onPressed: () async {
                          try {
                            if (editCardModel != null) {
                              final CardsDataHelper dataHelper =
                                  locator<CardsDataHelper>();
                              final CardModel updatedCard = CardModel(
                                id: editCardModel.id,
                                  cardNumber: getCardNumberWithoutSpaces(
                                      _cardNumberController.text),
                                  balance: double.parse(
                                      _initialBalanceController.text),
                                  iconPath: editCardModel.iconPath,
                                  cardName: editCardModel.cardName);
                              dataHelper.updateCard(updatedCard).then((value) {
                                _showSaveCardSuccessful(context);
                                
                              },);
                              return;
                            }
                            final cardNumber = getCardNumberWithoutSpaces(
                                _cardNumberController.text);
                            final double initialBalance =
                                double.parse(_initialBalanceController.text);
                            if (cardNumber.isNotEmpty &&
                                cardNumber.length == 16 &&
                                _initialBalanceController.text.isNotEmpty) {
                              if (state is BankUpdated) {
                                final CardsDataHelper dbHelper =
                                    locator<CardsDataHelper>();

                                final CardModel newCard = CardModel(
                                    cardNumber: cardNumber,
                                    balance: initialBalance,
                                    iconPath: state.bankInfo!.iconPath,
                                    cardName: state.bankInfo!.name);

                                await dbHelper.insertCard(newCard).then(
                                  (value) {
                                    _showSaveCardSuccessful(context);
                                  },
                                );
                              }

                              // final CardHelper dbHelper = locator<ardHelper>();

                              // await  dbHelper.insertCard(card);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                        title:
                            editCardModel != null ? 'ذخیره تغییرات' : 'ثبت ');
                  },
                ),
                const Gap(64),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<dynamic> _showSaveCardSuccessful(BuildContext context) {
    return showAdaptiveDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return const AddCarSuccesfulDialog();
                                    },
                                  );
  }
}
