import 'package:equatable/equatable.dart';
import '../../../../../shared/services/auth_service.dart';

abstract class SignInState  extends Equatable{}

class SignInInitialState extends SignInState {
  @override
  List<Object?> get props => [];
}

class SignInLoadingState extends SignInState {
  final bool prop;

  SignInLoadingState(this.prop);

  @override
  List<Object?> get props => [];
}

class SignInSuccessState extends SignInState {

  @override
  List<Object?> get props => [];
}

class SignInErrorState extends SignInState {
  AuthException exception;


  SignInErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}
