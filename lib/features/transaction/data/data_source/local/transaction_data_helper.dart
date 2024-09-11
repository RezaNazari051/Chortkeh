import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/features/home/data/data_source/local/cards_data_helper.dart';
import 'package:chortkeh/features/home/data/model/card_model.dart';
import 'package:chortkeh/features/transaction/data/data_source/categories.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../models/transaction_category_model.dart';
import 'transaction_detail.dart';

class TransactionDataHelper {
  TransactionDataHelper(this._box);
  final Box<TransactionModel> _box;

  Future<void> insertTransaction(TransactionModel transaction) async {
    final CardsDataHelper cardHelper = locator<CardsDataHelper>();
    final CardModel card = await cardHelper.getCardWithId(transaction.cardId);

    if (await _checkTransactionIsExist(transaction.id)) {
      throw Exception('این تراکنش از قبل وجود دارد');
    }

    const Uuid uuid = Uuid();
    transaction.id ??= uuid.v4();

    if (transaction.type == TransactionType.withdraw) {
      if (transaction.amount > card.balance) {
        throw 'مبلغ برداشتی بیشتر از موجودی کارت است';
      }
      final CardModel updatedCard =
          card.copyWith(balance: card.balance - transaction.amount);
      try {
        await cardHelper.updateCard(updatedCard);
        await _box.put(transaction.id, transaction);
      } catch (e) {
        throw 'خطا در زمان برداشت: ${e.toString()}';
      }
    } else if (transaction.type == TransactionType.deposit) {
      final CardModel updatedCard =
          card.copyWith(balance: card.balance + transaction.amount);
      try {
        await cardHelper.updateCard(updatedCard);
        await _box.put(transaction.id, transaction);
      } catch (e) {
        throw Exception('خطا در زمان واریز: ${e.toString()}');
      }
    }
  }

  List<TransactionModel> getTransactions({TransactionType? type}) {
    if (type != null) {
      return _box.values.where((element) => element.type == type).toList();
    }
    return _box.values.toList();
  }

  List<TransactionModel> getTransactionsByDate(DateTime startDate, DateTime endDate) {
    final transactions = _box.values.where((TransactionModel transaction) {
      final transactionDate = transaction.dateTime;

      return (transactionDate.isAfter(startDate) || transactionDate.isAtSameMomentAs(startDate)) &&
          (transactionDate.isBefore(endDate) || transactionDate.isAtSameMomentAs(endDate));
    }).toList();

    return transactions;
  }

  Future<bool> _checkTransactionIsExist(String? id) async {
    final transactions = _box.values.toList();

    return transactions.any((element) => element.id == id);
  }

  Future<List<TransactionDetail>> getTransactionDetails(
      TransactionType type) async {
    final List<TransactionModel> transactions = getTransactions(type: type);
    final List<TransactionDetail> transactionDetails = [];

    final CardsDataHelper cardsDataHelper = locator<CardsDataHelper>();
    for (final transaction in transactions) {
      final card = await cardsDataHelper.getCardWithId(transaction.cardId);

      final CategoryModel category =
          getCategoryById(transaction.categoryId, transaction.type);

      transactionDetails.add(TransactionDetail(
          card: card, transaction: transaction, category: category));
    }
    return transactionDetails;
  }

  Future<void> deleteTransaction(TransactionDetail detail) async {
    if (await _checkTransactionIsExist(detail.transaction.id)) {
      final CardsDataHelper cardHelper = locator<CardsDataHelper>();
      final CardModel card =
          await cardHelper.getCardWithId(detail.transaction.cardId);

      if (detail.transaction.type == TransactionType.deposit) {
        final CardModel updatedCard =
            card.copyWith(balance:card.balance- detail.transaction.amount);
        cardHelper.updateCard(updatedCard);
      }else{
         final CardModel updatedCard =
            card.copyWith(balance:card.balance+ detail.transaction.amount);
          cardHelper.updateCard(updatedCard);  
      }
      await _box.delete(detail.transaction.id);

    } else {
      throw 'چنین تراکنشی وجود ندارد';
    }
  }
}
