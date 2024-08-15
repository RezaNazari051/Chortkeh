import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../model/card_model.dart';

class CardsDataHelper{
  

CardsDataHelper(this._box);
  final Box<CardModel> _box;


  Future<void> insertCard(CardModel card)async{

    if(await checkCardIsExist(card)){
      throw Exception('شماره کارت قبلا وجود دارد');
    }
    const Uuid uuid=Uuid();

    card.id??=uuid.v4(); //! Genereate id when ID is not defined

    await _box.put(card.id, card);
  }

  Future<List<CardModel>> getCards()async{
    return  _box.values.toList();
  }

  Future<CardModel> getCardWithId(final String cardId)async{

   return _box.values.firstWhere((CardModel card) => card.id==cardId ,orElse: () => throw Exception('چنین کارتی وجود ندارد'),);
  }
  
  Future<void> updateCard(CardModel card)async{
      if(await checkCardIsExist(card)){
      // throw Exception('شماره کارت قبلا وجود دارد');
    await _box.put(card.id, card);

    }else{
      throw Exception('چنین کارتی وجود ندارد');
    }
    

  }

  Future<void>deleteCard(String id)async{
    _box.delete(id);
  }
  Future<bool>checkCardIsExist(CardModel card)async{
  final cards= _box.values.toList();
  return cards.any((element) => element.id==card.id);
}

Future<void>deleteAllCards()async{
  final cars=_box.values.toList();
  _box.deleteAll(cars.map((e) => e.id));
}
}
