part of 'reports_bloc.dart';

class ReportsState{
  ReportsState({required this.transactionsReportsStatus});
  final GetTransactionReportsStatus transactionsReportsStatus;


  ReportsState copyWith({GetTransactionReportsStatus? newTransactionsReportsStatus}) {
    return ReportsState(transactionsReportsStatus: newTransactionsReportsStatus??transactionsReportsStatus);
  }
}