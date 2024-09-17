import 'package:chortkeh/core/models/pie_chart_data_model.dart';
import 'package:chortkeh/core/resources/data_state.dart';
import 'package:chortkeh/features/transaction/data/data_source/categories.dart';
import 'package:chortkeh/features/transaction/data/data_source/local/transaction_data_helper.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../transaction/data/models/transaction_category_model.dart';

class HomeRepository {
  HomeRepository(this._dataHelper);

  final TransactionDataHelper _dataHelper;

  Future <DataState<PieChartDataModel>> getRecentActivitiesChartData({required int touchedSection})async {
    final transactions =
        _dataHelper.getTransactions(type: TransactionType.withdraw);

    final Map<String, double> transactionsData = {};

    try{
      for (TransactionModel transaction in transactions) {
        final CategoryModel category =
        getCategoryById(transaction.categoryId, transaction.type);


        double amount = transaction.amount;

        if (transactionsData.containsKey(transaction.categoryId)) {
          transactionsData[transaction.categoryId] =
              transactionsData[transaction.categoryId]! + amount;
        } else {
          transactionsData[transaction.categoryId] = amount;
        }
      }
      final double totalAmount =
      transactionsData.values.fold(0, (double sum, value) => sum + value);
      List<PieChartSectionData> sectionData = [];
      int index=0;

      transactionsData.forEach((categoryId, amount) {
        final double? radius=index==touchedSection? 50:null;
        final percentage = (amount / totalAmount) * 100;
        final category = getCategoryById(categoryId, TransactionType.withdraw);
        sectionData.add(PieChartSectionData(
            value: percentage,
            title: category.name,
            color: category.primaryColor,
            radius: radius,
            showTitle: false));
        index++;
      });

      return DataSuccess(PieChartDataModel(chartData: sectionData, touchedSection: touchedSection));
    }catch(e){
      return const DataFailed('Failed to get recent activities chart data');
    }
  }
}
