part of 'recent_transactions_bloc.dart';

class RecentTransactionsState {
  final DeleteTransactionStatus deleteTransactionStatus;
  final GetTransactionStatus getTransactionStatus;
  final GetMonthlyActivitiesChartStatus getMonthlyActivitiesChartStatus;

  RecentTransactionsState({
    required this.getTransactionStatus,
    required this.deleteTransactionStatus,
    required this.getMonthlyActivitiesChartStatus,
  });

  RecentTransactionsState copyWith({
    DeleteTransactionStatus? newDeleteTransactionStatus,
    GetTransactionStatus? newGetTransactionStatus,
    GetMonthlyActivitiesChartStatus? newGetMonthlyActivitiesChartStatus,
  }) {
    return RecentTransactionsState(
        getTransactionStatus: newGetTransactionStatus ?? getTransactionStatus,
        deleteTransactionStatus:
            newDeleteTransactionStatus ?? deleteTransactionStatus,
        getMonthlyActivitiesChartStatus: newGetMonthlyActivitiesChartStatus ??
            getMonthlyActivitiesChartStatus);
  }
}
