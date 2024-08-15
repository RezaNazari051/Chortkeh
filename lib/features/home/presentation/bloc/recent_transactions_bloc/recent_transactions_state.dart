part of 'recent_transactions_bloc.dart';

class RecentTransactionsState {
  
  final GetTransactionStatus getTransactionStatus;

  RecentTransactionsState({required this.getTransactionStatus});


  RecentTransactionsState copyWith({
    GetTransactionStatus? newgetTransactionStatus
  }){
    return RecentTransactionsState(getTransactionStatus: newgetTransactionStatus?? getTransactionStatus);
  }

}