import 'package:bloc/bloc.dart';
import 'package:book_store/logic/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitHomeState());
}
