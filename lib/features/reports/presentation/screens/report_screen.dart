import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/core/utils/extensions.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/blocs/cubit/cubit/change_tabbar_index_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/tab_bar_widget.dart';

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
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
            child: Column(
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
                const Gap(25),
                SizedBox(
                  width: double.infinity,
                  height: 280,
                  child: BarChart(
                    BarChartData(
                        borderData: FlBorderData(show: true),
                        maxY: 20000000,
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(toY: 4700000, color: Colors.red),
                            BarChartRodData(toY: 6000000, color: Colors.green)
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(toY: 8000000, color: Colors.red),
                            BarChartRodData(toY: 13500000, color: Colors.green)
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(toY: 10025000, color: Colors.red),
                            BarChartRodData(toY: 5000000, color: Colors.green)
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(toY: 10025000, color: Colors.red),
                            BarChartRodData(toY: 5000000, color: Colors.green)
                          ]),
                          BarChartGroupData(x: 4, barRods: [
                            BarChartRodData(toY: 10025000, color: Colors.red),
                            BarChartRodData(toY: 5000000, color: Colors.green)
                          ]),
                        ],
                        titlesData: FlTitlesData(
                          rightTitles: const AxisTitles(),
                          topTitles: const AxisTitles(),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(value.toStringAsFixed(0).toCurrencyFormat(),
                                    style: TextStyle(color: Colors.black));
                              },
                              reservedSize: 100,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: bottomTitles),
                          ),
                        ),
                        gridData: FlGridData(
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) =>
                              const FlLine(color: AppColor.cardBorderGrayColor,strokeWidth: 1),
                        )),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  Widget rightTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      value.toStringAsFixed(0).toCurrencyFormat(),
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }
}
