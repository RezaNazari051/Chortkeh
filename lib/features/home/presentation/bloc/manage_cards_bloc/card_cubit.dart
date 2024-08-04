import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/features/home/data/data_source/local/cards_data_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/model/card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'card_state.dart';


class CardCubit extends Cubit<CardState> {

  final CardsDataHelper dbHelper=locator<CardsDataHelper>();

  CardCubit() : super(GetCardsInitial());

  void loadCards() async {
    debugPrint('loading');
    emit(GetCardsLoading());
    try {
      final cards =await dbHelper.getCards();

      final totalBalance=cards.fold(0.0, (sum, card) => sum+card.balance);
      final allChannelsCard=CardModel(cardNumber: '0', balance: totalBalance, iconPath: 'ic_all_channels.svg', cardName: 'همه کانال‌ها');

      emit(GetCardsCompleted([allChannelsCard,...cards],selectedCard: allChannelsCard));
    } catch (e) {
      emit(GetCardsError('Failed to load cards'));
    }
  }

  void addCard(CardModel card) async {
    try {
      await dbHelper.insertCard(card);
      loadCards();
    } catch (e) {
      emit(GetCardsError('Failed to add card'));
    }
  }
  void deleteAllCards(){
    dbHelper.deleteAllCards();
  }

  void setSelectedCard(CardModel card){
    if(state is GetCardsCompleted){
      emit((state as GetCardsCompleted).copyWith(null,card));
    }
  }
}