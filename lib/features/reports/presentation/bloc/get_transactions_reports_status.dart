import 'package:chortkeh/features/reports/data/repository/transactions_report_repository.dart';
import 'package:equatable/equatable.dart';

abstract class GetTransactionReportsStatus extends Equatable{}


class GetReportsInitial extends GetTransactionReportsStatus{
  @override
  List<Object> get props => [];
}
class GetReportsLoading extends GetTransactionReportsStatus{
  @override
  List<Object> get props => [];
}
class GetReportsSuccess extends GetTransactionReportsStatus{
  GetReportsSuccess({required this.chartData});
  final List<TransactionChartData> chartData;

  @override
  List<Object> get props => [];
}

class GetReportsError extends GetTransactionReportsStatus{
  GetReportsError(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}