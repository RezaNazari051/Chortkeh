import 'package:chortkeh/core/operation/prefs_operator/prefs_operator.dart';
import 'package:chortkeh/features/home/data/data_source/local/cards_data_helper.dart';
import 'package:chortkeh/features/home/data/model/card_model.dart';
import 'package:chortkeh/features/reports/data/repository/transactions_report_repository.dart';
import 'package:chortkeh/features/transaction/data/data_source/local/transaction_data_helper.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator=GetIt.instance;

Future<void>initLocator()async{

  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


  locator.registerSingleton<PrefsOperator>(PrefsOperator(sharedPreferences));

  

    await initHive();

  locator.registerSingleton<TransactionsReportsRepository>(TransactionsReportsRepository(locator<TransactionDataHelper>()));

}


Future<void>initHive()async{
   await Hive.initFlutter();
    Hive.registerAdapter(CardModelAdapter());

    Hive.registerAdapter(TransactionModelAdapter());
    
    Hive.registerAdapter(TransactionTypeAdapter());
    

  final cardBox= await Hive.openBox<CardModel>('card');
  final transactionBox=await Hive.openBox<TransactionModel>('transaction');

    locator.registerSingleton<CardsDataHelper>(CardsDataHelper(cardBox));
    locator.registerSingleton<TransactionDataHelper>(TransactionDataHelper(transactionBox));


}