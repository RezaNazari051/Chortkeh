import 'package:chortkeh/features/home/presentation/bloc/manage_cards_bloc/card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
// ignore: depend_on_referenced_packages
import 'package:lottie/lottie.dart';
import '../../utils/constants.dart';

class AddCarSuccesfulDialog extends StatelessWidget {
  const AddCarSuccesfulDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      if (context.mounted) {
                        context.read<CardCubit>().loadCards();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    icon: SvgPicture.asset('$iconUrl/ic_close_circle.svg')),
              ],
            ),
            Lottie.asset('$animUrl/add_card_successful_anim.json',
                height: 200, fit: BoxFit.cover),
            const Gap(10),
            Text(
              'کارت با موفقیت اضافه شد',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
