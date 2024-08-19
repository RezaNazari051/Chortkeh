import 'package:chortkeh/config/dimens/sizer.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/core/utils/constants.dart';
import 'package:chortkeh/core/utils/extensions.dart';
import 'package:chortkeh/features/home/presentation/bloc/manage_cards_bloc/card_cubit.dart';
import 'package:chortkeh/features/home/presentation/screens/add_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/app_buttons.dart';

class CardListScreen extends StatelessWidget {
  static const String routeName = '/manage-cards';
  const CardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('کانال‌های ورودی', style: textTheme.bodyMedium),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            '$iconUrl/ic_arrow_right.svg',
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          LayoutBuilder(builder: (context, consraints) {
            final double horizontalPadding = consraints.maxWidth * 0.05;
            return BlocBuilder<CardCubit, CardState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    state is GetCardsCompleted && state.cards.length > 1
                        ? SliverPadding(
                            padding: EdgeInsets.fromLTRB(
                                horizontalPadding, 24, horizontalPadding, 130),
                            sliver: SliverList.separated(
                              separatorBuilder: (context, index) =>
                                  const Gap(8),
                              itemCount: state.cards.length,
                              itemBuilder: (context, index) {
                                final card = state.cards[index];
                                return card.cardNumber != '0'
                                    ? DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: AppColor
                                                    .cardBorderGrayColor)),
                                        child: ListTile(
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: AppColor.grayColor,
                                              size: 20),
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
                                            style: textTheme.bodySmall!.apply(
                                                color: AppColor.grayColor),
                                          ),
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AddCardScreen.routeName,
                                                arguments: card);
                                          },
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                          )
                        : state is GetCardsCompleted && state.cards.length <= 1
                            ? SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    Gap(
                                      30.height(context),
                                    ),
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                            '$imageUrl/img_not_found_channel.svg'),
                                        const Gap(24),
                                        Text(
                                          'هنوز کانالی ثبت نکردی',
                                          style: textTheme.bodySmall!
                                              .apply(color: AppColor.grayColor),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 90,
                                              top: 10.height(context)),
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: SvgPicture.asset(
                                                  '$imageUrl/img_hint_arrow.svg')),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : const SliverGap(0),
                  ],
                );
              },
            );
          }),
          Positioned(
            bottom: 64,
            child: FillElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddCardScreen.routeName);
                },
                title: 'اضافه کردن کانال جدید'),
          ),
        ],
      ),
    );
  }
}
