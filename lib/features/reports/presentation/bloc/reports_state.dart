part of 'reports_bloc.dart';

class ReportsState {
  ReportsState(
      {required this.transactionsReportsStatus,
      required this.exportToExcelStatue});

  final GetTransactionReportsStatus transactionsReportsStatus;
  final ExportTransactionsToExcelStatue exportToExcelStatue;

  ReportsState copyWith({
    GetTransactionReportsStatus? newTransactionsReportsStatus,
    ExportTransactionsToExcelStatue? newExportToExcelStatue,
  }) {
    return ReportsState(
      transactionsReportsStatus:
          newTransactionsReportsStatus ?? transactionsReportsStatus,
      exportToExcelStatue: newExportToExcelStatue ?? exportToExcelStatue,
    );
  }
}
