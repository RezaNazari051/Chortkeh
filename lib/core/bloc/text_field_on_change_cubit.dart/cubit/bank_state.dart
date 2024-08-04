part of 'bank_cubit.dart';

abstract class BankState extends Equatable {
  const BankState();

  @override
  List<Object> get props => [];
}

class BankInitial extends BankState {}

class BankUpdated extends BankState {
  final String formattedCardNumber;
  final BankModel? bankInfo;

  const BankUpdated(this.formattedCardNumber, this.bankInfo);

  @override
  List<Object> get props => [formattedCardNumber, bankInfo ?? ''];
}