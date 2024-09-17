import 'dart:io';

import 'package:chortkeh/core/models/date_range_model.dart';
import 'package:chortkeh/core/utils/extensions.dart';
import 'package:chortkeh/features/home/presentation/screens/home_screen.dart';
import 'package:chortkeh/features/reports/presentation/screens/report_screen.dart';
import 'package:chortkeh/features/transaction/data/data_source/categories.dart';
import 'package:chortkeh/features/transaction/data/data_source/local/transaction_data_helper.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../models/transaction_chart_data_model.dart';

class TransactionsReportsRepository {
  final TransactionDataHelper _dbHelper;

  TransactionsReportsRepository(this._dbHelper);

  Future<List<TransactionChartDataModel>>
      getWeeklyTransactionChartData() async {
    DateTime today = DateTime.now();

    int dayOfWeek = today.weekday;
    DateTime startWeek = today
        .subtract(Duration(days: (dayOfWeek + 1) % 7))
        .copyWith(hour: 0, minute: 0, second: 0);

    final transactions = _dbHelper.getTransactionsByDate(startWeek, today);

    // ایجاد یک لیست برای ذخیره تراکنش‌های هر روز از شنبه تا انتهای هفته (جمعه)
    final List<TransactionChartDataModel> chartDataList = [];

    // اضافه کردن روزهای هفته (از شنبه تا جمعه) به لیست
    for (int i = 0; i < 7; i++) {
      // 7 روز هفته
      final date = startWeek.add(Duration(days: i));
      chartDataList.add(TransactionChartDataModel(
          date: date, totalDeposits: 0, totalWithdrawals: 0));
    }

    // پر کردن لیست با تراکنش‌ها
    for (var transaction in transactions) {
      // گرفتن فقط تاریخ بدون زمان برای مقایسه صحیح
      final dateOnly = DateTime(transaction.dateTime.year,
          transaction.dateTime.month, transaction.dateTime.day);

      // پیدا کردن روزی که این تراکنش مربوط به آن است
      final chartData = chartDataList.firstWhere((data) =>
          data.date.year == dateOnly.year &&
          data.date.month == dateOnly.month &&
          data.date.day == dateOnly.day);

      // به‌روزرسانی مجموع واریزی‌ها و برداشتی‌ها برای آن روز
      if (transaction.type == TransactionType.deposit) {
        chartData.totalDeposits += transaction.amount;
      } else if (transaction.type == TransactionType.withdraw) {
        chartData.totalWithdrawals += transaction.amount;
      }
    }

    return chartDataList;
  }

  Future<List<TransactionChartDataModel>>
      getMonthlyTransactionChartData() async {
    Jalali jalaliToday = Jalali.now();
    Jalali startOfYear = Jalali(jalaliToday.year, 1, 1); 

    final transactions = _dbHelper.getTransactionsByDate(
        startOfYear.toDateTime(), jalaliToday.toDateTime());

    final List<TransactionChartDataModel> chartDataList = [];

    for (int i = 1; i <= 12; i++) {
      chartDataList.add(TransactionChartDataModel(
        date: Jalali(jalaliToday.year, i, 1).toDateTime(), 
        totalDeposits: 0,
        totalWithdrawals: 0,
      ));
    }

    for (var transaction in transactions) {
      Jalali jalaliTransactionDate = Jalali.fromDateTime(transaction.dateTime);

      final chartData = chartDataList.firstWhere(
        (data) =>
            Jalali.fromDateTime(data.date).month == jalaliTransactionDate.month,
        orElse: () => TransactionChartDataModel(
            date: jalaliTransactionDate.toDateTime(),
            totalDeposits: 0,
            totalWithdrawals: 0),
      );

      if (transaction.type == TransactionType.deposit) {
        chartData.totalDeposits += transaction.amount;
      } else if (transaction.type == TransactionType.withdraw) {
        chartData.totalWithdrawals += transaction.amount;
      }
    }

    return chartDataList;
  }

  Future<List<TransactionChartDataModel>>
      getYearlyTransactionChartData() async {
    Jalali now = Jalali.now();

    Jalali startOfCurrentYear = Jalali(now.year, 1, 1);

    Jalali startOfLastYear = Jalali(now.year - 1, 1, 1);

    final transactions = await _dbHelper.getTransactionsByDate(
      startOfLastYear.toDateTime(),
      now.toDateTime(),
    );

    List<TransactionChartDataModel> chartDataList = [
      TransactionChartDataModel(
          date: startOfLastYear.toDateTime(),
          totalDeposits: 0.0,
          totalWithdrawals: 0.0), // سال گذشته
      TransactionChartDataModel(
          date: startOfCurrentYear.toDateTime(),
          totalDeposits: 0.0,
          totalWithdrawals: 0.0), // سال جاری
    ];

    for (TransactionModel transaction in transactions) {
      Jalali jalaliTransactionDate = Jalali.fromDateTime(transaction.dateTime);

      if (jalaliTransactionDate.year == startOfLastYear.year) {
        if (transaction.type == TransactionType.deposit) {
          chartDataList[0].totalDeposits += transaction.amount;
        } else if (transaction.type == TransactionType.withdraw) {
          chartDataList[0].totalWithdrawals += transaction.amount;
        }
      }

      if (jalaliTransactionDate.year == startOfCurrentYear.year) {
        if (transaction.type == TransactionType.deposit) {
          chartDataList[1].totalDeposits += transaction.amount;
        } else if (transaction.type == TransactionType.withdraw) {
          chartDataList[1].totalWithdrawals += transaction.amount;
        }
      }
    }

    return chartDataList;
  }

  Future<void> exportReportsToExcel(
      String fileName, ReportChartType type) async {
    switch (type) {
      case ReportChartType.weekly:{
        final DateRange dateRange =calculateDateRange(ReportChartType.weekly);
        List<TransactionModel> transactions=_dbHelper.getTransactionsByDate(dateRange.start, dateRange.end);
        await exportWeeklyTransactionsToExcel(transactions);

      }
        break;
      case ReportChartType.monthly:
        {

          final DateRange dateRange =calculateDateRange(ReportChartType.monthly);
          List<TransactionModel> transactions=_dbHelper.getTransactionsByDate(dateRange.start, dateRange.end);
          await exportWeeklyTransactionsToExcel(transactions);
        }
        break;
      case ReportChartType.yearly:
        {
          final DateRange dateRange =calculateDateRange(ReportChartType.yearly);
          List<TransactionModel> transactions=_dbHelper.getTransactionsByDate(dateRange.start, dateRange.end);
          await exportWeeklyTransactionsToExcel(transactions);
        }
        break;
    }

    
  }
  Future<void> exportWeeklyTransactionsToExcel(
      List<TransactionModel> transactions) async {
    var excel = Excel.createExcel(); // ساخت فایل جدید Excel
    Sheet sheetObject = excel['Transactions']; // ساخت یک شیت

    sheetObject.appendRow([
      TextCellValue('شناسه تراکنش'),
      TextCellValue('کانال'),
      TextCellValue('دسته بندی تراکنش'),
      TextCellValue('مبلغ'),
      TextCellValue('تاریخ'),
      TextCellValue('نوع تراکنش')
    ]);
    int index=0;
      for (var transaction in transactions) {

        sheetObject.setColumnAutoFit(index);
      final  transactionDetail=await _dbHelper.getTransactionDetail(transaction.id!);
      final category=getCategoryById(transaction.categoryId, transaction.type);
      sheetObject.appendRow([
        TextCellValue(transaction.id.toString()),
        TextCellValue(transactionDetail!.card.cardName),
        TextCellValue(category.name),
        TextCellValue(transaction.amount.toStringAsFixed(0).toCurrencyFormat()),
        TextCellValue(formatJalali(transaction.dateTime,mode: FormatMode.withTime)),
        TextCellValue(transaction.type ==TransactionType.withdraw? 'برداشت':'واریز')
      ]);
      index++;
    }

    // ذخیره کردن فایل Excel
    final fileByte=  excel.save(fileName: 'transactions_report');
    Directory? directory=await getExternalStorageDirectory();
    String filePath='${directory?.path}/transactions_report.xlsx';
    File(filePath).writeAsBytesSync(fileByte!);


    print("Excel file saved at $filePath");
  }



  DateRange calculateDateRange(ReportChartType type) {
    DateTime now = DateTime.now();

    switch (type) {
      case ReportChartType.weekly:
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // شروع هفته از شنبه
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6)); // پایان هفته جمعه
        return DateRange(start: startOfWeek, end: endOfWeek);

      case ReportChartType.monthly:
        DateTime startOfMonth = DateTime(now.year, now.month, 1); // شروع ماه
        DateTime endOfMonth = DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1)); // پایان ماه
        return DateRange(start: startOfMonth, end: endOfMonth);

      case ReportChartType.yearly:
        DateTime startOfYear = DateTime(now.year, 1, 1); // شروع سال
        DateTime endOfYear = DateTime(now.year, 12, 31); // پایان سال
        return DateRange(start: startOfYear, end: endOfYear);

      default:
        throw Exception('Invalid export type');
    }
  }
}
