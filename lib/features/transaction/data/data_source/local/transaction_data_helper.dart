import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class TransactionDataHelper {
  TransactionDataHelper(this._box);
  final Box<TransactionModel> _box;

  Future<void>insertCard(TransactionModel transaction)async{
    if (await _checkTransacionIsExist(transaction)) {
      throw Exception('این ترانش از قبل وجود دارد');
    }
    const Uuid uuid=Uuid();
    transaction.id??=uuid.v4();

    await _box.put(transaction.id, transaction);
  }

  Future<List<TransactionModel>>getTransactions ()async{
    return _box.values.toList();
  }


Future<bool> _checkTransacionIsExist(TransactionModel transaction) async{

  final transactions=_box.values.toList();

  return transactions.any((element) => element.id==transaction.id);
}
}