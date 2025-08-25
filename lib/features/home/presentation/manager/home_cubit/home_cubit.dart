import 'package:ahmed_karam/core/constants.dart';
import 'package:ahmed_karam/features/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  logout() async {
    emit(LogoutLoadingState());
    try {
      var box = Hive.box<UserModel>(kUserBox);
      await box.clear();
      userModel = null;
      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutFailureState(error: "there was an error while logging out"));
    }
  }
}
