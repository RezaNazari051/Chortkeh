import 'package:chortkeh/features/home/data/model/card_model.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_category_model.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';

class TransactionDetail {
  final CardModel card;
  final TransactionModel transaction;
  final CategoryModel category;

  TransactionDetail({required this.card, required this.transaction, required this.category});
}