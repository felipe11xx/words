import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/user_session/splash/cubit/cubits.dart';

final $SplashCubit = Bind.singleton((i) => SplashCubit(i()));

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.authService) : super(SplashInitialState());

  final AuthService authService;
  getUserSession() async {
    emit(SplashUserSessionLoadingState(true));
    if (authService.userAuth != null) {
      emit(SplashUserSessionSuccessState());
    } else {
      emit(SplashUserSessionErrorState(AuthException('')));
    }
  }

  bool isEnable(bool isValidPassword, bool isValidEmail) =>
      (isValidPassword && isValidEmail);


}
