import 'package:chortkeh/common/utils/constants.dart';
import 'package:chortkeh/common/widgets/app_buttons.dart';
import 'package:chortkeh/config/dimens/sizer.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/blocs/cubit/cubit/change_tabbar_index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class PelehScreen extends StatelessWidget {
  static const String routeName = '/peleh-peleh';
  const PelehScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeTabbarIndexCubit(),
      child: BlocBuilder<ChangeTabbarIndexCubit, int>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('پله پله های من'),
              leading: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  '$iconUrl/ic_arrow_right.svg',
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: SizedBox(
                  height: 40,
                  child: ChortkehTabBar(state: state),
                ),
              ),
            ),
            body: IndexedStack(
              index: state,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverGap(MediaQuery.sizeOf(context).height * 0.2),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              // ignore: deprecated_member_use
                              SvgPicture.asset('$imageUrl/img_not_found_peleh.svg'),
                              const Gap(30), 
                              Text(
                                'هنوز پله‌پله‌ای نساختی! \n پله‌پله‌ات رو بساز :)',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(color: AppColor.grayColor),
                              ),


                              Gap(MediaQuery.sizeOf(context).height*.15),
                              Padding(
                                padding: const EdgeInsets.only(left: 90),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset('$imageUrl/img_hint_arrow.svg')),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                          Positioned(
                            bottom: 40,
                            child: FillElevatedButton(onPressed: (){}, title: 'ساخت پله‌پله‌')),

                  ],
                ),
                Placeholder(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ChortkehTabBar extends StatefulWidget {
  const ChortkehTabBar({super.key, required this.state});
  final int state;

  @override
  State<ChortkehTabBar> createState() => _ChortkehTabBarState();
}

int selected = 0;

class _ChortkehTabBarState extends State<ChortkehTabBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: buildTabs(),
    );
  }

  List<Widget> buildTabs() {
    // Build tabs with priority order based on selection
    List<Widget> tabs = [
      _getTab(positionRigth: 20.w, index: 0, title: 'فعال'),
      _getTab(positionLeft: 20.w, index: 1, title: 'تکمیل شده'),
    ];

    // If selected is 0, index 1 tab should be on top, otherwise index 0 tab
    if (widget.state == 0) {
      return tabs.reversed
          .toList(); // Reverse to bring the first item to the front
    }
    return tabs; // Default order
  }

  Widget _getTab(
      {double? positionLeft,
      double? positionRigth,
      required int index,
      required String title}) {
    return Positioned(
      right: positionRigth,
      left: positionLeft,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (index != widget.state) {
            context.read<ChangeTabbarIndexCubit>().changeIndex(index);
          }
        },
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(
            color: widget.state == index ? AppColor.primaryColor : null,
            border: Border.all(
              color:
                  widget.state != index ? Colors.grey : AppColor.primaryColor,
              width: widget.state != index ? 1 : 0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style:
                  TextStyle(color: widget.state != index ? null : Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
