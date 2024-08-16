import 'package:equatable/equatable.dart';

abstract class DeleteTransactionStatus extends Equatable{}

final class DeleteTransactionInitial extends DeleteTransactionStatus{
  @override
  List<Object?> get props => [];
}

final class DeleteTransactionLoading extends DeleteTransactionStatus{
  @override
  List<Object?> get props => [];
}
final class DeleteTransactionComplete extends DeleteTransactionStatus
{
  @override
  List<Object?> get props => [];
  }

final class DeleteTransactionFailed extends DeleteTransactionStatus{
  final String error;

  DeleteTransactionFailed({required this.error});
  @override
  List<Object?> get props => [error];
  
}  

