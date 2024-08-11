
import 'package:hive_flutter/hive_flutter.dart';
part 'transaction_model.g.dart';
enum TransactionType{
  deposit,
  withdraw
}

@HiveType(typeId: 1)
class TransactionModel{
  @HiveField(0)
   String? id;
  @HiveField(1)
  final String cardId;
  @HiveField(2)
  final String categoryId;
  @HiveField(3)
  final double amount;
  @HiveField(4)
  final DateTime dateTime;
  @HiveField(5)
  final TransactionType type;

  TransactionModel({ this.id,required this.cardId,required this.categoryId,required this.amount,required this.dateTime,required this.type});
}