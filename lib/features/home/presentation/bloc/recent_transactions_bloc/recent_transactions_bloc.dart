import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/features/home/presentation/bloc/recent_transactions_bloc/delete_transaction_status.dart';
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
  RecentTransactionsBloc()
      : super(
          RecentTransactionsState(
            getTransactionStatus: GetTransactionInitial(),
            deleteTransactionStatus: DeleteTransactionInitial()
          ),
        ) {
    on<GetAllTransactionsEvent>((event, emit) async {
      try {
              emit(
        state.copyWith(
          newGetTransactionStatus: GetTransactionLoading(),
        ),
      );
        final TransactionDataHelper dataHelper =
            locator<TransactionDataHelper>();
        final List<TransactionDetail> transactions =
            await dataHelper.getTransactionDetails(event.type);
        emit(
          state.copyWith(
            newGetTransactionStatus:
                GetTransactionCompeted(transactions,event.type),
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

    on<DeleteTransactionEvent>((event, emit)async {
      final TransactionDataHelper dataHelper =locator<TransactionDataHelper>();
      try{
        emit(state.copyWith(newDeleteTransactionStatus: DeleteTransactionLoading()));
        await dataHelper.deleteTransaction(event.transaction);
        
        add(GetAllTransactionsEvent(type: event.transaction.transaction.type));
        emit(state.copyWith(newDeleteTransactionStatus: DeleteTransactionComplete(transactionType: event.transaction.transaction.type)));
      }
      catch (e){
        emit(state.copyWith(newDeleteTransactionStatus: DeleteTransactionFailed(error: e.toString())));
        
      }
    },);
  }
}
