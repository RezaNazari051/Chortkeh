// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';


class ChangeTabbarIndexCubit extends Cubit<int> {
  ChangeTabbarIndexCubit() : super(0);
  int index=0;
  void changeIndex(int newIndex){
    emit(index=newIndex);
  }
}
