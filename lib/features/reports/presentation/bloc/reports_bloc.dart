import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/get_transaction_status.dart';
import 'package:chortkeh/features/reports/data/repository/transactions_report_repository.dart';
import 'package:chortkeh/features/reports/presentation/bloc/export_transactions_to_excel_status.dart';
import 'package:chortkeh/features/reports/presentation/screens/report_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/transaction_chart_data_model.dart';
import 'get_transactions_reports_status.dart';

part 'reports_event.dart';

part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final TransactionsReportsRepository _repository;

  ReportsBloc(this._repository)
      : super(
          ReportsState(
            transactionsReportsStatus: GetReportsInitial(),
            exportToExcelStatue: ExportToExcelInitial(),
          ),
        ) {
    on<GetTransactionsReportsEvent>((event, emit) async {
      emit(state.copyWith(newTransactionsReportsStatus: GetReportsLoading()));
      List<TransactionChartDataModel> chartData;
      switch (event.chartType) {
        case ReportChartType.weekly:
          chartData = await _repository.getWeeklyTransactionChartData();
          break;
        case ReportChartType.monthly:
          chartData = await _repository.getMonthlyTransactionChartData();

        case ReportChartType.yearly:
          chartData = await _repository.getYearlyTransactionChartData();
          break;
        default:
          throw 'Default';
      }
      try {
        emit(state.copyWith(
            newTransactionsReportsStatus:
                GetReportsSuccess(chartData: chartData)));
      } catch (e) {
        emit(state.copyWith(
            newTransactionsReportsStatus:
                GetReportsError('خطا در دریافت گزارشات')));
      }
    });

    on<ExportTransactionToExcelEvent>((event, emit) async {
     await _repository.exportReportsToExcel('fileName', event.type);
    });
  }
}
