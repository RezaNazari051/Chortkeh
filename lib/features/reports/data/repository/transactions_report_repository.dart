import 'package:chortkeh/features/transaction/data/data_source/local/transaction_data_helper.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:shamsi_date/shamsi_date.dart';

class TransactionsReportsRepository {
  final TransactionDataHelper _dbHelper;

  TransactionsReportsRepository(this._dbHelper);

  Future<List<TransactionChartData>> getWeeklyTransactionChartData() async {
    DateTime today = DateTime.now();

    int dayOfWeek = today.weekday;
    DateTime startWeek = today
        .subtract(Duration(days: (dayOfWeek + 1) % 7))
        .copyWith(hour: 0, minute: 0, second: 0);

    final transactions = _dbHelper.getTransactionsByDate(startWeek, today);

    // ایجاد یک لیست برای ذخیره تراکنش‌های هر روز از شنبه تا انتهای هفته (جمعه)
    final List<TransactionChartData> chartDataList = [];

    // اضافه کردن روزهای هفته (از شنبه تا جمعه) به لیست
    for (int i = 0; i < 7; i++) {
      // 7 روز هفته
      final date = startWeek.add(Duration(days: i));
      chartDataList.add(TransactionChartData(
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

  Future<List<TransactionChartData>> getMonthlyTransactionChartData() async {
    Jalali jalaliToday = Jalali.now();
    Jalali startOfYear = Jalali(jalaliToday.year, 1, 1); // شروع سال شمسی

    final transactions = _dbHelper.getTransactionsByDate(
        startOfYear.toDateTime(), jalaliToday.toDateTime());

    // ایجاد یک لیست برای ذخیره تراکنش‌های هر ماه از فروردین تا اسفند
    final List<TransactionChartData> chartDataList = [];

    // اضافه کردن ماه‌های سال (از فروردین تا اسفند) به لیست
    for (int i = 1; i <= 12; i++) {
      chartDataList.add(TransactionChartData(
        date: Jalali(jalaliToday.year, i, 1).toDateTime(), // تبدیل به میلادی
        totalDeposits: 0,
        totalWithdrawals: 0,
      ));
    }

    // پر کردن لیست با تراکنش‌ها
    for (var transaction in transactions) {
      // تبدیل تاریخ میلادی تراکنش به شمسی
      Jalali jalaliTransactionDate = Jalali.fromDateTime(transaction.dateTime);

      // پیدا کردن ماهی که این تراکنش مربوط به آن است
      final chartData = chartDataList.firstWhere(
        (data) =>
            Jalali.fromDateTime(data.date).month == jalaliTransactionDate.month,
        orElse: () => TransactionChartData(
            date: jalaliTransactionDate.toDateTime(),
            totalDeposits: 0,
            totalWithdrawals: 0),
      );

      // به‌روزرسانی مجموع واریزی‌ها و برداشتی‌ها برای آن ماه
      if (transaction.type == TransactionType.deposit) {
        chartData.totalDeposits += transaction.amount;
      } else if (transaction.type == TransactionType.withdraw) {
        chartData.totalWithdrawals += transaction.amount;
      }
    }

    return chartDataList;
  }

  Future<List<TransactionChartData>> getYearlyTransactionChartData() async {
    // تاریخ فعلی
    Jalali now = Jalali.now();

    // تاریخ شروع سال جاری
    Jalali startOfCurrentYear = Jalali(now.year, 1, 1);

    // تاریخ شروع سال گذشته
    Jalali startOfLastYear = Jalali(now.year - 1, 1, 1);

    // دریافت تراکنش‌ها از دیتابیس از تاریخ شروع سال گذشته تا به امروز
    final transactions = await _dbHelper.getTransactionsByDate(
      startOfLastYear.toDateTime(),
      now.toDateTime(),
    );

    // ایجاد لیست با دو سال (پارسال و امسال)
    List<TransactionChartData> chartDataList = [
      TransactionChartData(
          date: startOfLastYear.toDateTime(),
          totalDeposits: 0.0,
          totalWithdrawals: 0.0), // سال گذشته
      TransactionChartData(
          date: startOfCurrentYear.toDateTime(),
          totalDeposits: 0.0,
          totalWithdrawals: 0.0), // سال جاری
    ];

    // پر کردن مقادیر واریزی و برداشتی برای هر سال
    for (TransactionModel transaction in transactions) {
      // تبدیل تاریخ تراکنش از میلادی به شمسی
      Jalali jalaliTransactionDate = Jalali.fromDateTime(transaction.dateTime);

      // اگر تراکنش مربوط به سال گذشته است
      if (jalaliTransactionDate.year == startOfLastYear.year) {
        if (transaction.type == TransactionType.deposit) {
          chartDataList[0].totalDeposits += transaction.amount;
        } else if (transaction.type == TransactionType.withdraw) {
          chartDataList[0].totalWithdrawals += transaction.amount;
        }
      }

      // اگر تراکنش مربوط به سال جاری است
      if (jalaliTransactionDate.year == startOfCurrentYear.year) {
        if (transaction.type == TransactionType.deposit) {
          chartDataList[1].totalDeposits += transaction.amount;
        } else if (transaction.type == TransactionType.withdraw) {
          chartDataList[1].totalWithdrawals += transaction.amount;
        }
      }
    }

    // بازگرداندن لیست داده‌ها برای دو سال
    return chartDataList;
  }}

class TransactionChartData {
  DateTime date;
  double totalDeposits; // مجموع واریزی‌ها
  double totalWithdrawals; // مجموع برداشتی‌ها
  TransactionChartData({
    required this.date,
    required this.totalDeposits,
    required this.totalWithdrawals,
  });
}
