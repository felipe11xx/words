import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/sing_in_request.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../shared/services/auth_service.dart';
import 'package:words/user_session/auth/presenter/signup/cubit/sign_up_state.dart';

final $SignUpCubit = Bind.singleton((i) => SignUpCubit(i()));

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authService) : super(SignUpInitialState());

  final AuthService authService;

  doSignUp(SignInRequest signInRequest) async {
    emit(SignUpLoadingState(true));
    try {
      await authService.signUp(signInRequest);
      emit(SignUpSuccessState());
    } on AuthException catch (e) {
      emit(SignUpErrorState(e));
    }
  }

  bool isEnable(bool isValidPassword, bool isValidEmail) =>
      (isValidPassword && isValidEmail );
}
