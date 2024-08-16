part of 'recent_transactions_bloc.dart';

abstract class RecentTransactionsEvent extends Equatable {}


final class GetAllTransactionsEvent extends RecentTransactionsEvent {
  final TransactionType type;

  GetAllTransactionsEvent({required this.type});
  @override
  List<Object?> get props => [type];
}

final class DeleteTransactionEvent extends RecentTransactionsEvent{
  final TransactionDetail transaction;
  DeleteTransactionEvent({required this.transaction});
  @override
  List<Object?> get props => [];
}