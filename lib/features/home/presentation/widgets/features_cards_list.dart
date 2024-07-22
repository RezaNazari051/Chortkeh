import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/utils/json_data.dart';
import '../../../../config/dimens/responsive.dart';
import '../../../../config/theme/app_color.dart';

class FeaturesCardsList extends StatelessWidget {
  const FeaturesCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverGrid.builder(
      itemCount: 3,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        // childAspectRatio: .76,
          childAspectRatio: .9,
          crossAxisCount: 3, crossAxisSpacing:Responsive.isTablet()? 40:20 ),
      itemBuilder: (context, index) {
        final cardItemData=homeFeaturesCardItem['item$index'];
        return LayoutBuilder(
            builder: (context,co) {
              return Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.primaryColor.withOpacity(.1),
                        spreadRadius: 5,
                        offset: const Offset(0, 15),
                        blurRadius: 50)
                  ],
                  color: Colors.white,
                  // color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:  EdgeInsets.symmetric(vertical: co.maxHeight*0.12),
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(cardItemData!['icon']!,fit: BoxFit.cover,width: co.maxWidth *0.36,),
                    const Spacer(),
                    Text(
                      // '${co.maxWidth *0.36}',
                        '${cardItemData['title']}',
                        style: Theme.of(context).textTheme.displaySmall),
                    FittedBox(
                      child: Text('${cardItemData['subtitle']}',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .apply(color: AppColor.grayColor)),
                    )
                  ],
                ),
              );
            }
        );
      },
    );
  }
}
