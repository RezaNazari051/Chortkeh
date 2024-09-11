import 'package:fl_chart/fl_chart.dart';

class PieChartDataModel{
  PieChartDataModel({required this.chartData,required this.touchedSection});
  final List<PieChartSectionData> chartData;
  final int touchedSection;
}