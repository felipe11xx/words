import 'package:equatable/equatable.dart';
import '../../../../../shared/services/auth_service.dart';

abstract class SignUpState  extends Equatable{}

class SignUpInitialState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpLoadingState extends SignUpState {
  final bool prop;

  SignUpLoadingState(this.prop);

  @override
  List<Object?> get props => [];
}

class SignUpSuccessState extends SignUpState {

  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpState {
  AuthException exception;


  SignUpErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}
