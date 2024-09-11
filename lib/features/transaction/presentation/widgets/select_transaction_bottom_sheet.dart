import 'package:chortkeh/features/transaction/presentation/screens/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../config/theme/app_color.dart';
import '../../data/data_source/categories.dart';
import '../../data/models/transaction_category_model.dart';
import '../bloc/transaction_form_bloc/bloc/transaction_form_bloc.dart';
class SelectCategoryBottomSheetWidget extends StatelessWidget {
  final TransactionFormWidgetMode mode;
  const SelectCategoryBottomSheetWidget({
    super.key, required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
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
          Text('دسته‌بندی', style: textTheme.titleSmall),
          const Gap(24),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) => const Gap(16),
            itemCount: depositTransactionCategories.length,
            itemBuilder: (listContext, index) {
              final CategoryModel category = mode==TransactionFormWidgetMode.deposit?
                  depositTransactionCategories[index]:
                  withdrawalTransactionCategory[index];
                  
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05),
                child: Ink(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.cardBorderGrayColor)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      context.read<TransactionFormBloc>().add(
                          SelectTransactionCategoryEvent(
                              categoryModel: category));
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: category.backgroundColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(category.iconPath),
                            ),
                          ),
                          const Gap(8),
                          Text(category.name)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ))
        ],
      );
    });
  }
}