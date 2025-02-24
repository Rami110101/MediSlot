import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/state_main.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenState(currentIndex: 0));

   void changePage(int index) {
    emit(MainScreenState(currentIndex: index));
  }
}