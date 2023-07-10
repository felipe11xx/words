
import '../../data/model/sing_in_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/shared/services/auth_service.dart';
import 'package:words/user_session/auth/signin/cubit/sign__in_state.dart';

final $SignInCubit =  Bind.singleton((i) => SignInCubit(i()));

class SignInCubit extends Cubit<SignInState>{

  SignInCubit( this.authService) : super(SignInInitialState());

  final AuthService authService;

  doSignIn(SignInRequest signInRequest)async{
    emit(SignInLoadingState(true));
    try {
    await  authService.signIn(signInRequest);
      emit(SignInSuccessState());
    } on AuthException catch (e){
      emit(SignInErrorState(e));
    }

  }

 bool isEnable(bool isValidPassword,bool isValidEmail) => (isValidPassword && isValidEmail);


}