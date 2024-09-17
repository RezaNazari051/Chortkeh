import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/core/resources/data_state.dart';
import 'package:chortkeh/features/home/data/repository/home_repository.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/delete_transaction_status.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/get_monthly_activities_chart_status.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/get_transaction_status.dart';
import 'package:chortkeh/features/transaction/data/data_source/local/transaction_data_helper.dart';
import 'package:chortkeh/features/transaction/data/data_source/local/transaction_detail.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recent_transactions_event.dart';

part 'recent_transactions_state.dart';

class RecentTransactionsBloc
    extends Bloc<RecentTransactionsEvent, RecentTransactionsState> {
  final TransactionDataHelper _dataHelper;

  RecentTransactionsBloc(this._dataHelper)
      : super(
          RecentTransactionsState(
            getTransactionStatus: GetTransactionInitial(),
            deleteTransactionStatus: DeleteTransactionInitial(),
            getMonthlyActivitiesChartStatus: GetMonthlyChartInitial(),
          ),
        ) {
    on<GetAllTransactionsEvent>((event, emit) async {
      try {
        emit(state.copyWith(newGetTransactionStatus: GetTransactionLoading()));

        final List<TransactionDetail> transactions =
            await _dataHelper.getAllTransactionsDetails(event.type);
        emit(
          state.copyWith(
            newGetTransactionStatus:
                GetTransactionCompeted(transactions, event.type),
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            newGetTransactionStatus: GetTransactionFailure(
              e.toString(),
            ),
          ),
        );
      }
    });

    on<DeleteTransactionEvent>((event, emit) async {
      final TransactionDataHelper dataHelper = locator<TransactionDataHelper>();
      try {
        emit(state.copyWith(
            newDeleteTransactionStatus: DeleteTransactionLoading()));
        await dataHelper.deleteTransaction(event.transaction);

        add(GetAllTransactionsEvent(type: event.transaction.transaction.type));
        emit(state.copyWith(
            newDeleteTransactionStatus: DeleteTransactionComplete(
                transactionType: event.transaction.transaction.type)));
      } catch (e) {
        emit(state.copyWith(
            newDeleteTransactionStatus:
                DeleteTransactionFailed(error: e.toString())));
      }
    });

    on<GetMonthlyChartDataEvent>((event, emit) async {
      final HomeRepository homeRepository = locator<HomeRepository>();
      emit(state.copyWith(
          newGetMonthlyActivitiesChartStatus: GetMonthlyChartLoading()));

      final DataState dataState =
          await homeRepository.getRecentActivitiesChartData(touchedSection: event.touchedSection);

      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newGetMonthlyActivitiesChartStatus:
                GetMonthlyChartCompleted(data: dataState.data)));
      } else if (dataState is DataFailed) {
        emit(state.copyWith(
            newGetMonthlyActivitiesChartStatus:
                GetMonthlyChartError(error: dataState.error.toString())));
      }
    });
  }
}
