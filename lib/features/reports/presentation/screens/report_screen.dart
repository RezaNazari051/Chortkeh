import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/core/utils/extensions.dart';
import 'package:chortkeh/features/peleh_peleh/presentation/blocs/cubit/cubit/change_tabbar_index_cubit.dart';
import 'package:chortkeh/features/reports/data/repository/transactions_report_repository.dart';
import 'package:chortkeh/features/reports/presentation/bloc/get_transactions_reports_status.dart';
import 'package:chortkeh/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/tab_bar_widget.dart';

enum ReportChartType {
  weekly,
  monthly,
  yearly,
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<String> tabLabels = ['هفتگی', 'ماهانه', 'سالانه'];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => ChangeTabbarIndexCubit()),
        BlocProvider( create: (context) => ReportsBloc(locator())),
      ],

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
                        tabLabes: tabLabels,
                        state: state,
                        onTap: (index) => context
                            .read<ChangeTabbarIndexCubit>()
                            .changeReportScreenTabBarIndex(index),
                      );
                    },
                  ),
                  const Gap(25),
                  BlocConsumer<ChangeTabbarIndexCubit, int>(

                    listenWhen: (previous, current) => previous!= current,
                    buildWhen: (previous, current) => previous!= current,
                    listener: (context, state) {
                      switch(state ){
                        case 0:
                          context.read<ReportsBloc>().add(GetTransactionsReportsEvent(chartType: ReportChartType.weekly));
                        break;
                        case 1:
                        context.read<ReportsBloc>().add(GetTransactionsReportsEvent(chartType: ReportChartType.monthly));
                        break;
                        case 2:
                          context.read<ReportsBloc>().add(GetTransactionsReportsEvent(chartType: ReportChartType.yearly));
                        break;
                      }
                    },
                      builder: (context, state) {
                    switch (state) {
                      case 0:
                        break;
                      case 1:
                        break;
                      case 2:
                        break;
                      default:
                        break;
                    }
                    return BarChatWidget(
                      reportChartTypeIndex: state
                    );
                    // return BarChatWidget(reportChartType: reportChartType);
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BarChatWidget extends StatefulWidget {
  final int reportChartTypeIndex;

  const BarChatWidget({
    super.key,
    required this.reportChartTypeIndex,
  });

  @override
  State<BarChatWidget> createState() => _BarChatWidgetState();
}

class _BarChatWidgetState extends State<BarChatWidget> {
  double roundUpToNearestMillion(double value) {
    if (value % 1000000 == 0) {
      return value; // اگر عدد به طور دقیق مضربی از میلیون باشد، تغییری نمی‌کنیم
    }
    return ((value / 10000000).ceil()) * 10000000; // عدد رو به بالا گرد می‌شود
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      // testRepo.testGetTransactionChartData(DateTime.now());
      context.read<ReportsBloc>().add(GetTransactionsReportsEvent());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget bottomTitles(double value, TitleMeta meta) {
      final weeklyTitles = <String>[
        'شنبه',
        'یکشنبه',
        'دوشنبه',
        'سه‌شنبه',
        'چهار‌شنبه',
        'پنجشنبه',
        'جمعه'
      ];
      final monthlyTitles = [
        'فروردین',
        'اردیبهشت',
        'خرداد',
        'تیر',
        'مرداد',
        'شهریور',
        'مهر',
        'آبان',
        'آذر',
        'دی',
        'بهمن',
        'اسفند'
      ];
      final yearlyTitles = ['1402', '1403'];

      List<String> titles;
      switch (widget.reportChartTypeIndex) {
        case 0:
          titles = weeklyTitles;
          break;
        case 1:
          titles = monthlyTitles;
          break;
        case 2:
          titles = yearlyTitles;
          break;
        default:
          titles = weeklyTitles;
          break;
      }

      // استفاده از modulo برای اطمینان از اینکه index همیشه معتبر است
      final index = value.toInt() % titles.length;
      final Widget text = RotatedBox(
        quarterTurns: 3,
        child: Text(titles[index],
            style: Theme.of(context).textTheme.displaySmall),
      );

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16, // margin top
        child: text,
      );
    }

    Widget rightTitles(double value, TitleMeta meta) {
      final Widget text = Text(
        value.toStringAsFixed(0).toCurrencyFormat(),
        style: Theme.of(context).textTheme.displaySmall,
      );

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16, // margin top
        child: text,
      );
    }

    return BlocBuilder<ReportsBloc,ReportsState>(
  builder: (context, state) {
    if(state.transactionsReportsStatus is GetReportsLoading){
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
    if(state.transactionsReportsStatus is GetReportsSuccess){
      final completedState=state.transactionsReportsStatus as GetReportsSuccess;
      final List<TransactionChartData> chartData=completedState.chartData;

      double maxValue = chartData
          .map((e) => e.totalDeposits > e.totalWithdrawals ? e.totalDeposits : e.totalWithdrawals)
          .reduce((curr, next) => curr > next ? curr : next) /1000000 .ceil()*1000000;
      return Column(
        children: [

          SizedBox(
            width: double.infinity,
            height: 280,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(
                  border: const Border(
                    left: BorderSide(color: AppColor.cardBorderGrayColor),
                    top: BorderSide(color: AppColor.cardBorderGrayColor),
                  ),
                ),
                maxY: roundUpToNearestMillion(maxValue),
                barGroups: List.generate(
                  chartData.length,
                      (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        borderRadius: BorderRadius.circular(2),
                          toY: chartData[index].totalWithdrawals,
                          color: AppColor.redColor ),
                      BarChartRodData(
                          borderRadius: BorderRadius.circular(2),
                          toY: chartData[index].totalDeposits,
                          color: AppColor.greenColor)
                    ],
                  ),
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: rightTitles,
                      reservedSize: 70,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        interval: 1,
                        showTitles: true,
                        reservedSize: 70,
                        getTitlesWidget: bottomTitles),
                  ),
                ),
                gridData: FlGridData(
                  drawVerticalLine: false,checkToShowHorizontalLine: (value) => true,
                  getDrawingHorizontalLine: (value) => const FlLine(
                      color: AppColor.cardBorderGrayColor, strokeWidth: 1),
                ),
              ),
            ),
          ),

          SizedBox(width: 200,height: 200,
          // child:  PieChart(
          //   PieChartData(
          //       // centerSpaceRadius: constraints.maxWidth * 0.1,
          //       sections: showingSection(context, state, colorList),
          //       pieTouchData: PieTouchData(
          //         touchCallback: (FlTouchEvent event, response) {
          //           if (response != null &&
          //               response.touchedSection != null) {
          //             context.read<ChartSectionCubit>().toggleChartItem(
          //                 response.touchedSection!.touchedSectionIndex);
          //           }
          //         },
          //       ),
          //       sectionsSpace: 5),
          // )
          )
        ],
      );
    }
    return const SizedBox.shrink();

  },
);
  }
}