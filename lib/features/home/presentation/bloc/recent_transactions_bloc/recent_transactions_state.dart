part of 'recent_transactions_bloc.dart';

class RecentTransactionsState {
  final DeleteTransactionStatus deleteTransactionStatus;
  final GetTransactionStatus getTransactionStatus;

  RecentTransactionsState({
    required this.getTransactionStatus,
    required this.deleteTransactionStatus,
  });

  RecentTransactionsState copyWith(
      {DeleteTransactionStatus? newDeleteTransactionStatus,
      GetTransactionStatus? newGetTransactionStatus}) {
    return RecentTransactionsState(
        getTransactionStatus: newGetTransactionStatus ?? getTransactionStatus,
        deleteTransactionStatus:
            newDeleteTransactionStatus ?? deleteTransactionStatus);
  }
}
