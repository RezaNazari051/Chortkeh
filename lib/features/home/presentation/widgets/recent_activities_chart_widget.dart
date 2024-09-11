import 'package:chortkeh/config/theme/app_color.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/get_monthly_activities_chart_status.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/recent_transactions_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dimens/responsive.dart';
import '../bloc/touch_chart_section_callback/chart_section_cubit.dart';

class RecentActivitiesChartWidget extends StatefulWidget {
  final BoxConstraints constraints;

  const RecentActivitiesChartWidget({super.key, required this.constraints});

  @override
  State<RecentActivitiesChartWidget> createState() =>
      _RecentActivitiesChartWidgetState();
}

class _RecentActivitiesChartWidgetState
    extends State<RecentActivitiesChartWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecentTransactionsBloc>().add(GetMonthlyChartDataEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.blue,
      Colors.purple,
    ];
    return SliverToBoxAdapter(
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.cardBorderGrayColor),
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)),
        child: BlocBuilder<RecentTransactionsBloc, RecentTransactionsState>(
          buildWhen: (previous, current) =>
              previous.getMonthlyActivitiesChartStatus !=
              current.getMonthlyActivitiesChartStatus,
          builder: (context, state) {
            if (state.getMonthlyActivitiesChartStatus
                is GetMonthlyChartCompleted) {
              final sections = state.getMonthlyActivitiesChartStatus
                  as GetMonthlyChartCompleted;

              final chartData = sections.data.chartData;
              final touchedSection = sections.data.touchedSection;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // PieChartWidget(),
                  SizedBox(
                    width: widget.constraints.maxWidth * 0.40,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: chartData.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          childAspectRatio: Responsive.isTablet() ? 2 : 3),
                      itemBuilder: (context, index) {
                        return Indicator(
                          onTap: () => context
                              .read<RecentTransactionsBloc>()
                              .add(GetMonthlyChartDataEvent(
                                  touchedSection: index)),
                          size: Responsive.isTablet()
                              ? touchedSection == index
                                  ? 26
                                  : 16
                              : touchedSection == index
                                  ? 16
                                  : 8,
                          color: chartData[index].color,
                          text: chartData[index].title,
                          isSquare: true,
                          index: index,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 200,
                    child: BlocBuilder<ChartSectionCubit, int>(
                      builder: (context, state) {
                        return PieChart(
                          PieChartData(
                              centerSpaceRadius:
                                  widget.constraints.maxWidth * 0.1,
                              sections: sections.data.chartData,
                              // sections: showingSection(context, state, colorList),
                              pieTouchData: PieTouchData(touchCallback:
                                  (FlTouchEvent event,
                                      PieTouchResponse? response) {
                                if (response != null &&
                                    response.touchedSection != null) {
                                  context.read<RecentTransactionsBloc>().add(
                                      GetMonthlyChartDataEvent(
                                          touchedSection: response
                                              .touchedSection!
                                              .touchedSectionIndex));
                                }
                              }),
                              sectionsSpace: 5),
                        );
                      },
                    ),
                  )
                ],
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSection(
      BuildContext context, int state, List<Color> colors) {
    return List.generate(
      5,
      (index) {
        final isTouched = index == state;
        final double? radius = isTouched ? 50 : null;

        switch (index) {
          case 0:
            return PieChartSectionData(
                color: colors[index],
                value: 40,
                title: 'A',
                radius: radius,
                showTitle: false);
          case 1:
            return PieChartSectionData(
                color: colors[index],
                value: 26,
                title: 'B',
                radius: radius,
                showTitle: false);
          case 2:
            return PieChartSectionData(
                color: colors[index],
                value: 34,
                title: 'C',
                radius: radius,
                showTitle: false);
          case 3:
            return PieChartSectionData(
                color: colors[index],
                value: 13,
                title: 'D',
                radius: radius,
                showTitle: false);
          case 4:
            return PieChartSectionData(
                color: colors[index],
                value: 71,
                title: 'E',
                radius: radius,
                showTitle: false);
          default:
            throw Error();
        }
      },
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 8,
    this.textColor,
    this.onTap,
    this.onHover,
    required this.index,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final int index;
  final Color? textColor;
  final void Function()? onTap;
  final void Function(PointerEvent event)? onHover;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: onHover,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .apply(color: textColor))
          ],
        ),
      ),
    );
  }
}
