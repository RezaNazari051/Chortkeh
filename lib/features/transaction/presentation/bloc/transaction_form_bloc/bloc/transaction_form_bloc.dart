import 'package:chortkeh/core/operation/locator/locator.dart';
import 'package:chortkeh/features/transaction/data/data_source/local/transaction_data_helper.dart';
import 'package:chortkeh/features/transaction/data/models/transaction_model.dart';
import 'package:chortkeh/features/transaction/presentation/bloc/transaction_form_bloc/bloc/add_transaction_status.dart';
import 'package:chortkeh/features/transaction/presentation/bloc/transaction_form_bloc/bloc/transaction_form_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../home/data/model/card_model.dart';
import '../../../../data/models/transaction_category_model.dart';

part 'transaction_form_event.dart';
part 'transaction_form_state.dart';

class TransactionFormBloc
    extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc()
      : super(
            TransactionFormState(transactionStatus: AddTransactionInitial())) {
    on<SelectTransactionChannelEvent>((event, emit) {
      if (event.cardModel != null) {
        emit(state.copyWith(
            newChannelStatus: ChannelStatus(cardModel: event.cardModel)));
      }
    });

    on<SelectTransactionCategoryEvent>(
      (event, emit) {
        if (event.categoryModel != null) {
          emit(state.copyWith(
            newCategoryStatus: CategoryStatus(category: event.categoryModel),
          ));
        }
      },
    );
    on<SelectTransactionDateEvent>(
      (event, emit) {
        if (event.date != null) {
          emit(state.copyWith(newDateStatus: DateStatus(date: event.date)));
        }
      },
    );
    on<SelectTransactionTimeEvent>(
      (event, emit) {
        if (event.time != null) {
          emit(state.copyWith(newTimeStatus: TimeStatus(time: event.time)));
        }
      },
    );
    on<AddTransactionEvent>((event, emit) async {
      try {
        emit(state.copyWith(newTransactionStatus: AddTransactionLoading()));
        final TransactionDataHelper dnHelper = locator<TransactionDataHelper>();

        await dnHelper.insertTransaction(event.transactionModel);
        emit(state.copyWith(newTransactionStatus:AddTransactionCompleted() ));
      } catch (e) {
        print(e.toString());
        emit(
          state.copyWith(
            newTransactionStatus: AddTransactionFailed(
              error: e.toString(),
            ),
          ),
        );
      }
    });
    on<ResetTransactionFormEvent>((event, emit) {
      emit(state.copyWith(
        newChannelStatus: ChannelStatus(cardModel: null),
        newCategoryStatus: CategoryStatus(category: null),
        newDateStatus: DateStatus(date: null),
        newTimeStatus: TimeStatus(time: null),
        newTransactionStatus: AddTransactionInitial()
      ));
    });
  }
}
