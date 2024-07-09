import 'dart:ui';
import 'package:chortkeh/common/bloc/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/constants.dart';

class MainWrapper extends StatefulWidget {
  static const String routeName = '/';

  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  List<String> navIconList = [
    '$iconUrl/ic_navbar_home',
    '$iconUrl/ic_navbar_chart',
    '$iconUrl/ic_navbar_notification',
    '$iconUrl/ic_navbar_profile'
  ];
  final Map<String, Map<String, String>> navbarItemsData = {
    'item0': {
      'title': 'خانه',
      'icon': '$iconUrl/ic_navbar_home',
    },
    'item1': {
      'title': 'گزارشات',
      'icon': '$iconUrl/ic_navbar_chart',
    },
    'item3': {
      'title': 'یادآور',
      'icon': '$iconUrl/ic_navbar_notification',
    },
    'item4': {
      'title': 'پروفایل',
      'icon': '$iconUrl/ic_navbar_profile',
    },
  };

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f9fd),
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f9fd),
        leadingWidth: 32 + 20.w,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w),
          child: SvgPicture.asset(
            'assets/icons/ic_chortkeh_small_logo.svg',
          ),
        ),
        actions: [
          Padding(
            padding:   EdgeInsetsDirectional.only(end: 20.w),
            child: SvgPicture.asset(
              'assets/icons/ic_message_icon.svg',
            ),
          ), // SvgPicture.string('assets/icons/ic_message_icon.svg')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            unselectedLabelColor: AppColor.grayColor,
            onTap: (value) =>
                context.read<BottomNavbarCubit>().changeNavbarIndex(value),
            indicator: TopIndicator(),
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            tabs: [
              Tab(
                  icon: BottomNavbarWidget(
                    icon: navbarItemsData['item0']!['icon']!,
                    index: 0,
                  ),
                  text: navbarItemsData['item0']!['title']!),
              Tab(
                  icon: BottomNavbarWidget(
                    icon: navbarItemsData['item1']!['icon']!,
                    index: 1,
                  ),
                  text: navbarItemsData['item1']!['title']!),
              const Visibility(
                visible: false,
                child: SizedBox(width: 15),
              ),
              Tab(
                  icon: BottomNavbarWidget(
                    icon: navbarItemsData['item3']!['icon']!,
                    index: 3,
                  ),
                  text: navbarItemsData['item3']!['title']!),
              Tab(
                  icon: BottomNavbarWidget(
                    icon: navbarItemsData['item4']!['icon']!,
                    index: 4,
                  ),
                  text: navbarItemsData['item4']!['title']!),
            ]),
      ),
      body: TabBarView(controller: _tabController, children: [
        HomeScreen(),
        HomeScreen(),
        HomeScreen(),
        HomeScreen(),
        HomeScreen(),

      ]),
    );
  }
}

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({
    super.key,
    required this.icon,
    required this.index,
  });

  final int index;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavbarCubit, int>(
      builder: (context, state) {
        return SvgPicture.asset(
            state == index ? '${icon}_fill.svg' : '$icon.svg');
      },
    );
  }
}

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox();
  }
}

class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint _paint = Paint()
      ..color = AppColor.primaryColor
      ..strokeWidth = 5
      ..isAntiAlias = true;

    canvas.drawLine(offset, Offset(cfg.size!.width + offset.dx, 0), _paint);
  }
}

