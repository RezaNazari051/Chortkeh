import 'package:flutter/services.dart';

final Map<String, String> binList = {
  "603799": "بانک ملی ایران",
  "589210": "بانک سپه",
  "627648": "بانک توسعه صادرات",
  "627961": "بانک صنعت و معدن",
  "603770": "بانک کشاورزی",
  "628023": "بانک مسکن",
  "627760": "پست بانک ایران",
  "502908": "بانک توسعه تعاون",
  "627412": "بانک اقتصاد نوین",
  "622106": "بانک پارسیان",
  "502229": "بانک پاسارگاد",
  "627488": "بانک کارآفرین",
  "621986": "بانک سامان",
  "639346": "بانک سینا",
  "639607": "بانک سرمایه",
  "502806": "بانک شهر",
  "502938": "بانک دی",
  "603769": "بانک صادرات ایران",
  "610433": "بانک ملت",
  "627353": "بانک تجارت",
  "589463": "بانک رفاه",
  "606256": "موسسه اعتباری ملل",
  "606373": "بانک قرض‌الحسنه مهر ایران",
  "505416": "بانک گردشگری",
  // ... اضافه کردن سایر بانک‌ها
};

final List<BankModel> bankList = [

  BankModel(name: 'بانک صنعت و معدن', digits: '627961', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک توسعه صادرات', digits: '627648', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک سپه', digits: '589210', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک ملی ایران', digits: '603799', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک کشاورزی', digits: '603770', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک مسکن', digits: '628023', iconPath: 'ic_mashkan.svg'),
  BankModel(name: 'پست بانک ایران', digits: '627760', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک  توسعه تعاون', digits: '502908', iconPath: 'ic_mashkan.svg'),
  BankModel(name: 'بانک اقتصاد نوین', digits: '627412', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک پارسیان', digits: '622106', iconPath: 'ic_parsian.svg'),
  BankModel(name: 'بانک پاسارگاد', digits: '502229', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک کارآفرین', digits: '627488', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک سامان', digits: '621986', iconPath: 'ic_saman.svg'),
  BankModel(name: 'بانک سینا', digits: '639346', iconPath: 'ic_sina.svg'),
  BankModel(name: 'بانک سرمایه', digits: '639607', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک شهر', digits: '502806', iconPath: 'ic_shahr.svg'),
  BankModel(name: 'بانک دی', digits: '502938', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک صادرات ایران', digits: '603769', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک ملت', digits: '610433', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک تجارت', digits: '627353', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک رفاه', digits: '589463', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک گردشگری', digits: '505416', iconPath: 'ic_coin.svg'),
  BankModel(name: 'بانک قرض‌الحسنه مهر ایران', digits: '606373', iconPath: 'ic_coin.svg'),

];
BankModel? getBankInfo(String cardNumber) {
  if (cardNumber.length < 6) {
    return null;
  }

  String bin = cardNumber.substring(0, 6);
  return bankList.firstWhere(
    (bank) => bank.digits == bin,
    orElse: () => BankModel(name: 'بانک نامشخص', digits: '', iconPath: 'ic_coin.svg'),
  );
}

String formatCardNumber(String cardNumber) {
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

class BankModel{
  BankModel({required this.name,required this.digits,required this.iconPath});
  final String digits;
  final String name;
  final String iconPath;
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var inputText = newValue.text.replaceAll(' ', ''); // حذف فاصله‌ها

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
String getCardNumberWithoutSpaces(String value) {
      return value.replaceAll(' ', '');
    }