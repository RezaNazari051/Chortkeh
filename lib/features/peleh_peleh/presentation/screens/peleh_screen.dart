import 'package:chortkeh/common/utils/arguments.dart';
import 'package:chortkeh/common/utils/constants.dart';
import 'package:chortkeh/common/utils/extensions.dart';
import 'package:chortkeh/common/utils/json_data.dart';
import 'package:chortkeh/common/widgets/app_buttons.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/blocs/cubit/cubit/change_tabbar_index_cubit.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/screens/new_peleh_screen.dart';
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
    final List<Target> activePelehList = [
      Target(
          id: 1001,
          name: 'خرید هدیه',
          image: 'ic_gift.svg',
          progress: 0.75,
          amount: 2850000),
      Target(
          id: 1002,
          name: 'خرید موبایل',
          image: 'ic_mobile.svg',
          progress: 0.90,
          amount: 47000000),
      Target(
          id: 1003,
          name: 'خرید لوازم خانه',
          image: 'ic_chair.svg',
          progress: 0.25,
          amount: 5035000),
    ];
    final List<Target> newTargetList = [
      Target(
          id: 1,
          name: 'موبایل',
          amount: 0,
          progress: 0,
          image: 'ic_mobile.svg'),
      Target(id: 2, name: 'هدیه', amount: 0, progress: 0, image: 'ic_gift.svg'),
      Target(
          id: 1, name: 'اتوموبیل', amount: 0, progress: 0, image: 'ic_car.svg'),
      Target(
          id: 2,
          name: 'لوازم خانه',
          amount: 0,
          progress: 0,
          image: 'ic_chair.svg'),
      Target(
          id: 3,
          name: 'لپ‌تاپ',
          amount: 0,
          progress: 0,
          image: 'ic_laptop.svg'),
      Target(
          id: 0,
          name: 'پله‌پله جدید',
          amount: 0,
          progress: 0,
          image: 'ic_new_target.svg'),
    ];
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => ChangeTabbarIndexCubit(),
      child: BlocBuilder<ChangeTabbarIndexCubit, int>(
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'پله پله های من',
                ),
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
                          // _notFoundPelehPlaceholder(context),
                          SliverPadding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: constraints.maxWidth * 0.05),
                            sliver: SliverGrid.builder(
                              itemCount: 3,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.4,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 12),
                              itemBuilder: (context, index) {
                                return LayoutBuilder(
                                    builder: (context, onstraints) {
                                  final Target peleh = activePelehList[index];
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.lightGrayColor),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Stack(
                                              children: [
                                                SizedBox(
                                                  width: 49,
                                                  height: 49,
                                                  child: TweenAnimationBuilder(
                                                    tween: Tween<double>(
                                                        begin: 0.0,
                                                        end: peleh.progress),
                                                    duration: const Duration(
                                                        seconds: 1),
                                                    builder: (context, value,
                                                            child) =>
                                                        CircularProgressIndicator(
                                                      value: value,
                                                      color:
                                                          AppColor.greenColor,
                                                      strokeWidth: 5,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  width: 49,
                                                  height: 49,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        AppColor.lightBlueColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: FittedBox(
                                                    child: SvgPicture.asset(
                                                      '$targetIcon/${peleh.image}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(8),
                                            Text(
                                                onstraints.maxHeight.toString(),
                                                style: textTheme.labelSmall),
                                            const Gap(3),
                                            Text(
                                              '${peleh.amount.toString().toCurrencyFormat()}تومان',
                                              style: textTheme.displaySmall!
                                                  .apply(
                                                      color:
                                                          AppColor.grayColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 40,
                        child: FillElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return NewPelehBottomSheet(
                                      textTheme: textTheme,
                                      newTargetList: newTargetList);
                                },
                              );
                            },
                            title: 'ساخت پله‌پله‌'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  SliverToBoxAdapter _notFoundPelehPlaceholder(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Gap(MediaQuery.sizeOf(context).height * 0.2),
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

          Gap(MediaQuery.sizeOf(context).height * .15),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset('$imageUrl/img_hint_arrow.svg')),
          )
        ],
      ),
    );
  }
}

class NewPelehBottomSheet extends StatelessWidget {
  const NewPelehBottomSheet({
    super.key,
    required this.textTheme,
    required this.newTargetList,
  });

  final TextTheme textTheme;
  final List<Target> newTargetList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: double.infinity),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: 60,
            height: 5,
            decoration: BoxDecoration(
                color: AppColor.cardBorderGrayColor,
                borderRadius: BorderRadius.circular(28)),
          ),
          const Gap(16),
          Text('نام پله‌پله', style: textTheme.titleSmall),
          const Gap(24),
          SizedBox(
            height: 300,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 24, crossAxisSpacing: 40, crossAxisCount: 3),
              itemBuilder: (context, index) {
                final Target target = newTargetList[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(context, NewPelehScreen.routeName,arguments: 
                    NewPelehArgument(id: target.id, image: target.image, name: target.name));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color: AppColor.lightBlueColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            '$targetIcon/${target.image}',
                            fit: BoxFit.cover,
                          )),
                      Text(target.name)
                    ],
                  ),
                );
              },
            ),
          )
        ],
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
