import 'package:chortkeh/core/models/pie_chart_data_model.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

abstract class GetMonthlyActivitiesChartStatus extends Equatable {}

final class GetMonthlyChartInitial extends GetMonthlyActivitiesChartStatus {
  @override
  List<Object?> get props => [];
}

final class GetMonthlyChartLoading extends GetMonthlyActivitiesChartStatus {
  @override
  List<Object?> get props => [];
}

final class GetMonthlyChartCompleted extends GetMonthlyActivitiesChartStatus {
  final PieChartDataModel data;

  GetMonthlyChartCompleted({required this.data});

  @override
  List<Object?> get props => [data];
}

final class GetMonthlyChartError extends GetMonthlyActivitiesChartStatus {
  final String error;

  GetMonthlyChartError({required this.error});

  @override
  List<Object?> get props => [error];
}
