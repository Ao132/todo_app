import 'states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  int counter = 1;
  CounterCubit() : super(CounterInitialState());
  static CounterCubit get(context) => BlocProvider.of(context);
  void plus() {
    counter++;
    emit(CounterPlusState());
  }

  void minus() {
    counter--;
    emit(CounterMinusState());
  }
}
