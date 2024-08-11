part of 'transaction_form_bloc.dart';

class TransactionFormState {
  final ChannelStatus? channelStatus;
  final CategoryStatus? categoryStatus;
  final DateStatus? dateStatus;
  final TimeStatus? timeStatus;
  final AddTransactionStatus transactionStatus;
  TransactionFormState(
      {required this.transactionStatus,
      this.channelStatus,
      this.categoryStatus,
      this.dateStatus,
      this.timeStatus});

  TransactionFormState copyWith({
    AddTransactionStatus? newTransactionStatus,
    ChannelStatus? newChannelStatus,
    CategoryStatus? newCategoryStatus,
    DateStatus? newDateStatus,
    TimeStatus? newTimeStatus,
  }) {
    return TransactionFormState(
      channelStatus: newChannelStatus ?? channelStatus,
      categoryStatus: newCategoryStatus ?? categoryStatus,
      dateStatus: newDateStatus ?? dateStatus,
      timeStatus: newTimeStatus ?? timeStatus,
      transactionStatus: newTransactionStatus ?? transactionStatus,
    );
  }
}
