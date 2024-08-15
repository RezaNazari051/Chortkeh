part of 'recent_transactions_bloc.dart';

abstract class RecentTransactionsEvent extends Equatable {}


final class GetAllTransactionsEvent extends RecentTransactionsEvent {
  final TransactionType type;

  GetAllTransactionsEvent({required this.type});
  @override
  List<Object?> get props => [];
}