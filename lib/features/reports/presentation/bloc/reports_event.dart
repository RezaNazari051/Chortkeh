part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {}

class GetTransactionsReportsEvent extends ReportsEvent{
  final ReportChartType chartType;
  GetTransactionsReportsEvent({this.chartType=ReportChartType.weekly});
  @override
  List<Object?> get props =>[chartType];
}
class ExportTransactionToExcelEvent extends ReportsEvent{
  final ReportChartType type;

  ExportTransactionToExcelEvent({required this.type});
  @override
  List<Object?> get props => [type];
}