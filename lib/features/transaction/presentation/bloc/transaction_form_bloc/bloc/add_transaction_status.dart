import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:equatable/equatable.dart';

abstract class AddTransactionStatus extends Equatable{}

class AddTransactionInitial extends AddTransactionStatus{
  @override
  List<Object?> get props => [];
}
class AddTransactionLoading extends AddTransactionStatus{
  @override
  List<Object?> get props => [];
}
class AddTransactionCompleted extends AddTransactionStatus{
  final TransactionModel transactionModel;
  AddTransactionCompleted({required this.transactionModel});
  @override
  List<Object?> get props => [transactionModel];
}
class AddTransactionFailed extends AddTransactionStatus{
  final String error;
  AddTransactionFailed({required this.error});
  @override
  List<Object?> get props => [error];

}