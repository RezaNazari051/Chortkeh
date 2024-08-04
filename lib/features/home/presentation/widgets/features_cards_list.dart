import 'package:chortkeh/config/dimens/sizer.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/screens/peleh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../config/dimens/responsive.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/json_data.dart';
import '../../../../core/widgets/app_buttons.dart';

class FeaturesCardsList extends StatefulWidget {
  
  const FeaturesCardsList({super.key});

  @override
  State<FeaturesCardsList> createState() => _FeaturesCardsListState();
}

class _FeaturesCardsListState extends State<FeaturesCardsList> {
    List<TargetFocus> targets = [];

  final GlobalKey _buttonKey = GlobalKey();

    @override
  void initState() {
    super.initState();
    initTargets();
    // showTutorial();
  }
 void initTargets() {
    targets.add(TargetFocus(
      identify: "Target 1",
      keyTarget: _buttonKey,
      alignSkip: Alignment.topRight,
      shape: ShapeLightFocus.RRect,
      paddingFocus: 0,
      
      
      radius: 8,
      contents: [
     
        TargetContent(
          align: ContentAlign.custom,
          customPosition: CustomTargetContentPosition(bottom: 25.height(context)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
              
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
              const Gap(10),
                    const Text(
                      "از «پله‌پله» می‌تونی اهداف مالی\nتعریف کنی و پله به پله بهشون برسی.",
                    ),
                    const Gap(10),
                    FillElevatedButton(onPressed: (){}, title: 'فهمیدم',textColor: AppColor.primaryColor,backgroundColor: Colors.white,)
                  ],
                ),
              ),
              const Gap(12),
              SvgPicture.asset('$iconUrl/ic_arrow_tutorail_1.svg')
            ],
          ),
        ),
      ],
    ));
  }

void showTutorial() {
    TutorialCoachMark(
      targets: targets, // List<TargetFocus>
       // alignSkip: Alignment.bottomRight,
       // textSkip: "SKIP",
       // paddingFocus: 10,
       // opacityShadow: 0.8,
      onClickTarget: (target){
        debugPrint(target.toString());
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        debugPrint("target: $target");
        debugPrint("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target){
        debugPrint(target.toString());
      },
      onFinish: (){
        debugPrint("finish");
      },
    ).show(context:context);
  }
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // childAspectRatio: .76,
          childAspectRatio: .9,
          crossAxisCount: 3,
          crossAxisSpacing: Responsive.isTablet() ? 40 : 20),
      itemBuilder: (context, index) {
        final cardItemData = homeFeaturesCardItem['item$index'];
        return LayoutBuilder(builder: (context, co) {
          return Ink(
            key:index==0 ?_buttonKey:null,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(.1),
                  spreadRadius: 5,
                  offset: const Offset(0, 15),
                  blurRadius: 50,
                )
              ],
              // color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                Navigator.pushNamed(context, PelehScreen.routeName);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: co.maxHeight * 0.12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      cardItemData!['icon']!,
                      fit: BoxFit.cover,
                      width: co.maxWidth * 0.36,
                    ),
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
              ),
            ),
          );
        });
      },
    );
  }
}
