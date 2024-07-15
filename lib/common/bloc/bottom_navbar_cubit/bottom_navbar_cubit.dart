import 'package:bloc/bloc.dart';


class BottomNavbarCubit extends Cubit<int> {
  BottomNavbarCubit() : super(0);
  int index=0;

  void changeNavbarIndex(int newIndex){
    if(newIndex!=2) {
      emit(index=newIndex);
    }

  }
}
