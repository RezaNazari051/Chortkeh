import 'package:bloc/bloc.dart';

class ChartSectionCubit extends Cubit<int> {
  ChartSectionCubit() : super(-1);
  int index=-1;

  void toggleChartItem(int newIndex){
    if(newIndex !=state){
      emit(index=newIndex);
    }
  }
}
