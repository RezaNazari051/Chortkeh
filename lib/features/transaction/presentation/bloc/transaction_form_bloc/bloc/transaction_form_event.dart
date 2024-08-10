part of 'transaction_form_bloc.dart';

sealed class TransactionFormEvent extends Equatable {}

class SelectTransactionChannelEvent extends TransactionFormEvent {
  final CardModel? cardModel;
  SelectTransactionChannelEvent({this.cardModel});
  @override
  List<Object?> get props => [cardModel];
}

class SelectTransactionCategoryEvent extends TransactionFormEvent {
  final CategoryModel? categoryModel;
  SelectTransactionCategoryEvent({this.categoryModel});
  @override
  List<Object?> get props => [categoryModel];
}

class SelectTransactionDateEvent extends TransactionFormEvent{
  final DateTime? date;
  SelectTransactionDateEvent({this.date});
  
  @override
  List<Object?> get props => [date];
}

class SelectTransactionTimeEvent extends TransactionFormEvent{
  final DateTime? time;
  SelectTransactionTimeEvent({this.time});
  @override
  List<Object?> get props => [time];

}