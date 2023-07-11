import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/all_words/presenter/cubit/home_state.dart';

import '../../../shared/services/auth_service.dart';

final $HomeCubit = Bind.singleton((i) => HomeCubit(i()));
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._authServices) : super(HomeInitialState());
  final AuthService _authServices;

  signOut() async {
    try {
      await _authServices.signOut();
      emit(UserSignOutSuccessState());
    } on AuthException catch (e) {
      emit(UserSignOutErrorState(e));
    }
    await _authServices.signOut();
  }

  String? getUserEmail() {
    return _authServices.userAuth?.email;
  }


}
