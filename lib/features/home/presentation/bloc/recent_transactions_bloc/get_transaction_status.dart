import 'package:chortkeh/features/transaction/data/data_source/local/transaction_detail.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:equatable/equatable.dart';

abstract class GetTransactionStatus extends Equatable{}



final class GetTransactionInitial extends GetTransactionStatus{
  @override
  List<Object?> get props => [];
}

final class GetTransactionLoading extends GetTransactionStatus{
  @override
  List<Object?> get props => [];
}

final class GetTransactionCompeted extends GetTransactionStatus {
  final List<TransactionDetail> transactions;
  final TransactionType type;

  GetTransactionCompeted(this.transactions, this.type);
  @override
  List<Object?> get props => [transactions];
}


final class GetTransactionFailure extends GetTransactionStatus {
  final String error;

  GetTransactionFailure(this.error);
  @override
  List<Object?> get props => [error];
}