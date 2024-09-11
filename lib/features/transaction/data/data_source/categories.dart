import 'package:chortkeh/core/utils/constants.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_category_model.dart';
import 'package:flutter/material.dart';

import '../models/transaction_model.dart';

List<CategoryModel> withdrawalTransactionCategory = [
  CategoryModel(
      id: '0',
      name: 'ماشین',
      iconPath: '$categoryIcon/ic_car.svg',
      backgroundColor: const Color(0xffFCF8D2),
      primaryColor: const Color(0xffF1DD1E)),
  CategoryModel(
    id: '1',
    name: 'سلامتی',
    iconPath: '$categoryIcon/ic_hospital.svg',
    backgroundColor: const Color(0xffDCF1DB),
    primaryColor: const Color(0xff4EB84C),
  ),
  CategoryModel(
    id: '2',
    name: 'خوردنی',
    iconPath: '$categoryIcon/ic_cake.svg',
    backgroundColor: const Color(0xffFCE6D4),
    primaryColor: const Color(0xffF2832A),
  ),
  CategoryModel(
    id: '3',
    name: 'خریدنی',
    iconPath: '$categoryIcon/ic_bag.svg',
    backgroundColor: const Color(0xffDAE2F0),
    primaryColor: const Color(0xff4570B5),
  ),
  CategoryModel(
    id: '4',
    name: 'خوش گذرونی',
    iconPath: '$categoryIcon/ic_headphone.svg',
    backgroundColor: const Color(0xffECDEED),
    primaryColor: const Color(0xff9E5CA4),
  ),
  CategoryModel(
    id: '5',
    name: 'خونه',
    iconPath: '$categoryIcon/ic_home.svg',
    backgroundColor: const Color(0xffEAF4D9),
    primaryColor: const Color(0xff95C940),
  ),
];

List<CategoryModel> depositTransactionCategories = [
  CategoryModel(
    id: '6',
    name: 'حقوق',
    iconPath: '$categoryIcon/ic_salary.svg',
    backgroundColor: const Color(0xffFCE6D4),
    primaryColor: const Color(0xffF2832A),
  ),
  CategoryModel(
    id: '7',
    name: 'پاداش',
    iconPath: '$categoryIcon/ic_coin.svg',
    backgroundColor: const Color(0xffDBDEED),
    primaryColor: const Color(0xff4959A6),
  ),
  CategoryModel(
    id: '8',
    name: 'وام',
    iconPath: '$categoryIcon/ic_loan.svg',
    backgroundColor: const Color(0xffECDEED),
    primaryColor: const Color(0xff9E5CA4),
  ),
  CategoryModel(
    id: '9',
    name: 'سود سرمایه',
    iconPath: '$categoryIcon/ic_percentage.svg',
    backgroundColor: const Color(0xffFCF8D2),
    primaryColor: const Color(0xffF1DD1E),
  ),
  CategoryModel(
    id: '10',
    name: 'یارانه',
    iconPath: '$categoryIcon/ic_money.svg',
    backgroundColor: const Color(0xffDCF1DB),
    primaryColor: const Color(0xff4EB84C),
  ),
];

CategoryModel getCategoryById(String categoryId, TransactionType type) {
  if (type == TransactionType.deposit) {
    return depositTransactionCategories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => CategoryModel(
        id: 'default',
        name: 'Unknown',
        iconPath: 'assets/default_icon.svg',
        backgroundColor: Colors.grey.withOpacity(.5),
        primaryColor: Colors.grey
      ),
    );
  } else {
    return withdrawalTransactionCategory.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => CategoryModel(
        id: 'default',
        name: 'Unknown',
        iconPath: 'assets/default_icon.svg',
        backgroundColor: Colors.grey.withOpacity(.5),
        primaryColor: Colors.grey
      ),
    );
  }
}
