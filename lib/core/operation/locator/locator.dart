import 'package:chortkeh/core/operation/prefs_operator/prefs_operator.dart';
import 'package:chortkeh/features/home/data/data_source/local/cards_data_helper.dart';
import 'package:chortkeh/features/home/data/model/card_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator=GetIt.instance;

Future<void>initLocator()async{

  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();


  locator.registerSingleton<PrefsOperator>(PrefsOperator(sharedPreferences));



    await initHive();


}


Future<void>initHive()async{
   await Hive.initFlutter();
    Hive.registerAdapter(CardModelAdapter());

  final box= await Hive.openBox<CardModel>('card');

    locator.registerSingleton<CardsDataHelper>(CardsDataHelper(box));


}