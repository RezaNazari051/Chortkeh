part of 'card_cubit.dart';

abstract class CardState extends Equatable{}


 final class GetCardsInitial extends CardState{
  @override
  List<Object?> get props => [];
}

final class GetCardsLoading extends CardState{
  @override
  List<Object?> get props =>[];
}

final class GetCardsCompleted extends CardState{
  final List<CardModel> cards;
  final CardModel selectedCard;
  GetCardsCompleted(this.cards,{required this.selectedCard});

  @override
  List<Object?> get props => [cards,selectedCard];

  GetCardsCompleted copyWith(List<CardModel>? cards,CardModel? selectedCard){
  return GetCardsCompleted(cards??this.cards,
  
  selectedCard: selectedCard??this.selectedCard);
}
}
final class GetCardsError extends CardState{
  GetCardsError(this.error);
  final String error;
  @override
  List<Object?> get props =>[error];
}

