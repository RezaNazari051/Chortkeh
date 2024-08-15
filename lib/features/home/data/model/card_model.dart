
import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: 0)
class CardModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String cardNumber;
  @HiveField(2)
  final double balance;
  @HiveField(3)
  final String iconPath;
  @HiveField(4)
  final String cardName;

  CardModel({
    this.id,
    required this.cardNumber,
    required this.balance,
    required this.iconPath,
    required this.cardName,
  });

  CardModel copyWith({double? balance, String? cardNumber, String? cardName}) {
    return CardModel(
        id: id,
        cardNumber: cardNumber ?? this.cardNumber,
        balance: balance ?? this.balance,
        iconPath: iconPath,
        cardName: cardName ?? this.cardName);
  }
}
