import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/home/presenter/cubit/home_state.dart';

final $HomeCubit = Bind.singleton((i) => HomeCubit(i()));
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._authServices) : super(HomeInitialState());
  final AuthService _authServices;

  signOut() async {
    try {
      emit(HomeLoadingState());
      debugPrint("HomeLoadingState");
      await _authServices.signOut();
      emit(UserSignOutSuccessState());
      debugPrint("UserSignOutSuccessState");
      emit(HomeInitialState());

    } on AuthException catch (e) {
      emit(UserSignOutErrorState(e));
    }
  }

  String? getUserEmail() {
    return _authServices.userAuth?.email;
  }


}
