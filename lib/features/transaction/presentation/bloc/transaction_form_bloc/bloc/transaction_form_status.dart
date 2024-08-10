import 'package:chortkeh/features/home/data/model/card_model.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_category_model.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionFormStatus extends Equatable {}

class CategoryStatus extends TransactionFormStatus {
  final CategoryModel? category;
  CategoryStatus({this.category});
  @override
  List<Object?> get props => [category];
}

class ChannelStatus extends TransactionFormStatus {
  final CardModel? cardModel;
  ChannelStatus({this.cardModel});
  @override
  List<Object?> get props => [cardModel];
}

class DateStatus extends TransactionFormStatus {
  final DateTime? date;
  DateStatus({this.date});
  @override
  List<Object?> get props => [date];
}

class TimeStatus extends TransactionFormStatus {
  final DateTime? time;
  TimeStatus({this.time});
  @override
  List<Object?> get props => [time];
}
