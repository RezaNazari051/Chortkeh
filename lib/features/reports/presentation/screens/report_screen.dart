import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/blocs/cubit/cubit/change_tabbar_index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<String> tabLabes = ['هفتگی', 'ماهانه', 'سالانه'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeTabbarIndexCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'گزارشات',
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<ChangeTabbarIndexCubit, int>(
              builder: (context, state) {
                return ChrotkehTabBarWidget(
                  tabLabes: tabLabes,
                  state: state,
                  onTap: (index) => context
                      .read<ChangeTabbarIndexCubit>()
                      .changeReportScreenTabBarIndex(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChrotkehTabBarWidget extends StatelessWidget {
  const ChrotkehTabBarWidget({
    super.key,
    required this.tabLabes,
    required this.onTap, required this.state,
  });
  final Function(int index) onTap;
  final int state;
  final List<String> tabLabes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.lightGrayColor, width: 1)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
              children: List.generate(
            tabLabes.length,
            (index) =>_getTap(context, index, tabLabes[index], onTap)
           
            
          ));
        },
      ),
    );
  }
  Widget _getTap(
    BuildContext context,
    int index,
    String lable,
    Function(int index) onTap,
  ){
    return  Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: index == state ? AppColor.primaryColor : null,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
              child: Text(
            lable,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color:
                      state == index ? Colors.white : const Color(0xffADADAD),
                ),
          )),
        ),
      ),
    );
  }
}