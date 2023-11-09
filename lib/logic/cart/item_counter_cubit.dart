import 'package:bloc/bloc.dart';

class ItemCounterCubit extends Cubit<int> {
  ItemCounterCubit() : super(1);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
