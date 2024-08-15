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
  AddTransactionCompleted();
  @override
  List<Object?> get props => [];
}
class AddTransactionFailed extends AddTransactionStatus{
  final String error;
  AddTransactionFailed({required this.error});
  @override
  List<Object?> get props => [error];

}