import 'package:chortkeh/common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

const String a = 'sda';

const Map<String, Map<String, String>> homeFeaturesCardItem = {
  'item0': {
    'title': 'پله‌پله',
    'subtitle': 'هدف‌گذاری مالی',
    'icon': '$iconUrl/ic_feature_peleh.svg'
  },
  'item1': {
    'title': 'قلک',
    'subtitle': 'ذخیره پس‌انداز',
    'icon': '$iconUrl/ic_feature_gholak.svg'
  },
  'item2': {
    'title': 'بودجه‌بندی',
    'subtitle': 'مدیریت مالی',
    'icon': '$iconUrl/ic_feature_budgeting.svg'
  }
};

final adsad = {
  'item0': {
    'color': const Color(0xffFCF8D2),
    'category': 'ماشین',
    'date': Jalali.fromDateTime(DateTime.now()),
  }
};

class RecentActivities {
  final String category;
  final String icon;
  final String bankCard;
  final Color color;
  final DateTime date;
  final double price;
  final double value;

  RecentActivities(
      {required this.category,
      required this.icon,
      required this.color,
      required this.bankCard,
      required this.date,
      required this.price,
      required this.value});
}

class Target {
  final int id;
  final String name;
  final double amount;
  final double progress;
  final String image;

  Target(
      {required this.id,
      required this.name,
      required this.amount,
      required this.progress,
      required this.image});
}
