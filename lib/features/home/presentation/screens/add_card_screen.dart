import 'package:chortkeh/core/bloc/text_field_on_change_cubit.dart/cubit/bank_cubit.dart';
import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/core/utils/check_card_number.dart';
import 'package:chortkeh/core/utils/constants.dart';
import 'package:chortkeh/core/widgets/app_buttons.dart';
import 'package:chortkeh/core/widgets/app_text_form_field.dart';
import 'package:chortkeh/core/widgets/dialogs/general_dialogs.dart';
import 'package:chortkeh/features/home/data/data_source/local/cards_data_helper.dart';
import 'package:chortkeh/features/home/data/model/card_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('اضافه کردن کانال‌ ورودی',
            style: Theme.of(context).textTheme.bodyMedium),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
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
                    title: 'موجودی اولیه کارت',
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
                                    showAdaptiveDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return const AddCarSuccesfulDialog();
                                      },
                                    );
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
                        title: 'ثبت ');
                  },
                ),
                const Gap(64),
              ],
            ),
          ),
        );
      }),
    );
  }
}
