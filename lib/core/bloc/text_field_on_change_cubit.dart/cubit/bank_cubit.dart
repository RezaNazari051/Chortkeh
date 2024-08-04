import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/check_card_number.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankState> {
  BankCubit() : super(BankInitial());

  void cardNumberChanged(String cardNumber) {
    final formattedCardNumber = _formatCardNumber(cardNumber);
    final bankInfo = _getBankInfo(cardNumber.replaceAll(' ', ''));
    emit(BankUpdated(formattedCardNumber, bankInfo));
  }

  String _formatCardNumber(String cardNumber) {
    cardNumber = cardNumber.replaceAll(' ', ''); // حذف فاصله‌های موجود
    String formatted = '';
    for (int i = 0; i < cardNumber.length; i++) {
      if (i % 4 == 0 && i != 0) {
        formatted += ' ';
      }
      formatted += cardNumber[i];
    }
    return formatted;
  }

  BankModel? _getBankInfo(String cardNumber) {
    if (cardNumber.length < 6) {
      return null;
    }
    String bin = cardNumber.substring(0, 6);
    return bankList.firstWhere(
      (bank) => bank.digits == bin,
      orElse: () => BankModel(name: 'بانک نامشخص', digits: '', iconPath: ''),
    );
  }

  void resetState(){
    emit(BankInitial());
  }
}