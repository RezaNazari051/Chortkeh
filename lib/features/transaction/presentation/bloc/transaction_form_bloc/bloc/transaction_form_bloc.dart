import 'package:chortkeh/features/transaction/presentation/bloc/transaction_form_bloc/bloc/transaction_form_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ir_datetime_picker/ir_datetime_picker.dart';

import '../../../../../home/data/model/card_model.dart';
import '../../../../data/models/transaction_category_model.dart';

part 'transaction_form_event.dart';
part 'transaction_form_state.dart';

class TransactionFormBloc
    extends Bloc<TransactionFormEvent, TransactionFormState> {
  TransactionFormBloc() : super(TransactionFormState()) {
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
        if(event.date!=null){
          emit(state.copyWith(newDateStatus: DateStatus(date: event.date)));
        }
      },
    );
  }
}
