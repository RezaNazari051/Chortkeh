import 'package:equatable/equatable.dart';

abstract class ExportTransactionsToExcelStatue extends Equatable{}


final class ExportToExcelInitial extends ExportTransactionsToExcelStatue{
  @override
  List<Object?> get props => [];
}

final class ExportToExcelInProgress extends ExportTransactionsToExcelStatue{
  @override
  List<Object?> get props => [];
}
final class ExportToExcelCompleted extends ExportTransactionsToExcelStatue{
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class ExportToExcelFailed extends ExportTransactionsToExcelStatue{
  final String errorMessage;

  ExportToExcelFailed({required this.errorMessage});
  @override
  List<Object?> get props => [];
}
