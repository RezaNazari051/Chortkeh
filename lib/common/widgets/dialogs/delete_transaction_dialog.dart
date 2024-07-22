import 'package:chortkeh/common/screens/main_wrapper.dart';
import 'package:chortkeh/common/utils/constants.dart';
import 'package:chortkeh/common/widgets/app_buttons.dart';
import 'package:chortkeh/config/dimens/sizer.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DeleteTransactionDialog extends StatelessWidget {
  const DeleteTransactionDialog({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme=Theme.of(context).textTheme;
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
                // width: 35.width(),
              ),
            ),
            const Gap(16),
            Expanded(
              child: AppOutlineButton(
                width: 0,
                onPressed: () {
                  Navigator.popUntil(context,
                      (route) => route.settings.name == MainWrapper.routeName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: const Color(0xff323232),
                      duration: const Duration(seconds: 3),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text('تراکنش حذف شد.',style: textTheme.displaySmall!.apply(color: Colors.white)),
                          InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              
                            },
                            child: Container(
                              padding:
                              const EdgeInsets.all(5),
                              child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset('$iconUrl/ic_undo.svg'),
                                      const Gap(5),
                                       Text('برگردون',style: textTheme.displaySmall!.apply(color: Colors.white))
                              
                                    ],
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                title: 'حذف',
                borderColor: AppColor.redColor,
                // width: 35.width(),
              ),
            ),
          ],
        ),
      ],
      contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton( 
              onPressed: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              icon:
               SvgPicture.asset('$iconUrl/ic_close_circle.svg')
              )
              ,
          const Spacer(flex: 1,),
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
