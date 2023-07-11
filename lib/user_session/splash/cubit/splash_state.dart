import 'package:equatable/equatable.dart';
import '../../../shared/services/auth_service.dart';

abstract class SplashState  extends Equatable{}

class SplashInitialState extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashUserSessionLoadingState extends SplashState {
  final bool prop;

  SplashUserSessionLoadingState(this.prop);

  @override
  List<Object?> get props => [];
}

class SplashUserSessionSuccessState extends SplashState {

  @override
  List<Object?> get props => [];
}

class SplashUserSessionErrorState extends SplashState {
  AuthException exception;


  SplashUserSessionErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}
