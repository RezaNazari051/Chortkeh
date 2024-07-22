import 'package:chortkeh/config/theme/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dimens/responsive.dart';
import '../bloc/touch_chart_section_callback/chart_section_cubit.dart';

class RecentActivitiesChartWidget extends StatelessWidget {
  final BoxConstraints constraints;

  const RecentActivitiesChartWidget({super.key, required this.constraints});

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
            borderRadius: BorderRadius.circular(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // PieChartWidget(),
            SizedBox(
              width: constraints.maxWidth * 0.35,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    childAspectRatio: Responsive.isTablet() ? 2 : 3),
                itemBuilder: (context, index) {
                  return BlocBuilder<ChartSectionCubit, int>(
                    builder: (context, state) {
                      return Indicator(
                        size: Responsive.isTablet()
                            ? state == index
                                ? 26
                                : 16
                            : state == index
                                ? 16
                                : 8,
                        color: colorList[index],
                        text: 'ماشین',
                        isSquare: true,
                        index: index,
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: BlocBuilder<ChartSectionCubit, int>(
                builder: (context, state) {
                  return PieChart(
                    PieChartData(
                        centerSpaceRadius: constraints.maxWidth * 0.1,
                        sections: showingSection(context, state, colorList),
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, response) {
                            if (response != null &&
                                response.touchedSection != null) {
                              context.read<ChartSectionCubit>().toggleChartItem(
                                  response.touchedSection!.touchedSectionIndex);
                            }
                          },
                        ),
                        sectionsSpace: 5),
                  );
                },
              ),
            ),
          ],
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
    required this.index,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final int index;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) =>
          context.read<ChartSectionCubit>().toggleChartItem(index),
      child: GestureDetector(
        onTap: () => context.read<ChartSectionCubit>().toggleChartItem(index),
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
