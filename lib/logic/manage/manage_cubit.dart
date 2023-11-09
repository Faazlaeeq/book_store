import 'package:bloc/bloc.dart';
import 'package:book_store/logic/manage/manage_state.dart';

class ManageCubit extends Cubit<ManageState> {
  ManageCubit() : super(InitManageState());

  void startLoading() {
    emit(LoadingManageState());
    print("Loading State: State emiiterd");
  }

  void stopLoading() {
    emit(InitManageState());
    print("Loading State: State emiiterd InitMangeState");
  }
}
