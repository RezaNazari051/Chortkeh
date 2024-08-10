
import 'package:chortkeh/core/utils/constants.dart';
import 'package:chortkeh/core/utils/extensions.dart';
import 'package:chortkeh/features/transaction/presentation/bloc/transaction_form_bloc/bloc/transaction_form_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../config/theme/app_color.dart';
import '../bloc/manage_cards_bloc/card_cubit.dart';
import '../screens/add_card_screen.dart';
import '../screens/card_list_screen.dart';

class ChannelListBottomSheet extends StatelessWidget {
  final bool inTransaction;
  const ChannelListBottomSheet({
    super.key,
    this.inTransaction = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return BlocBuilder<CardCubit, CardState>(
              buildWhen: (previous, current) {
                return previous != current;
              },
              builder: (context, state) {
                if (state is GetCardsLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (state is GetCardsCompleted) {
                  final cards = state.cards;
                  return LayoutBuilder(builder: (context, constraints) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'کانال‌های ورودی',
                                      style: textTheme.titleSmall,
                                    ),
                                  ),
                                ),
                                // const Gap(10),
                                const Spacer(),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, CardListScreen.routeName,
                                            arguments: state.cards);
                                      },
                                      icon: SvgPicture.asset(
                                          '$iconUrl/ic_edit.svg'),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: constraints.maxWidth * 0.05),
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Gap(8),
                                controller: scrollController,
                                itemCount: cards.length,
                                itemBuilder: (context, index) {
                                  final card = cards[index];

                                  if (inTransaction && card.cardNumber == '0') {
                                    return const SizedBox.shrink();
                                  }
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color:
                                                AppColor.cardBorderGrayColor)),
                                    child: ListTile(
                                      trailing: !inTransaction &&
                                              card == state.selectedCard
                                          ? SvgPicture.asset(
                                              '$iconUrl/ic_tick_circle.svg')
                                          : const SizedBox.shrink(),
                                      minLeadingWidth: 32,
                                      leading: SvgPicture.asset(
                                        '$cardIcon/${card.iconPath}',
                                        fit: BoxFit.cover,
                                      ),
                                      title: Text(
                                        card.cardName,
                                        style: textTheme.bodyMedium,
                                      ),
                                      subtitle: Text(
                                        'موجودی: ${card.balance.toStringAsFixed(0).toCurrencyFormat()} تومان',
                                        style: textTheme.bodySmall!
                                            .apply(color: AppColor.grayColor),
                                      ),
                                      onTap: () {
                                        if (inTransaction) {
                                          context
                                              .read<TransactionFormBloc>()
                                              .add(
                                                  SelectTransactionChannelEvent(
                                                      cardModel: card));
                                        } else {
                                          context
                                              .read<CardCubit>()
                                              .setSelectedCard(card);
                                        }

                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const Gap(10),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.05),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AddCardScreen.routeName);
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      '$iconUrl/ic_add_square.svg'),
                                  const Gap(5),
                                  Text('اضافه کردن کانال جدید',
                                      style: textTheme.labelSmall)
                                ],
                              ),
                            ),
                          ),
                          const Gap(16),
                        ],
                      ),
                    );
                  });
                }
                return const SizedBox.shrink();
              },
            );
          }),
    );
  }
}
