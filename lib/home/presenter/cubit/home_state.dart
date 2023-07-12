import 'package:equatable/equatable.dart';

import '../../../shared/services/auth_service.dart';

abstract class HomeState extends Equatable{}


class HomeInitialState extends HomeState {

  @override
  List<Object?> get props => [];
}

class UserSignOutSuccessState extends HomeState {

  UserSignOutSuccessState();

  @override
  List<Object?> get props => [];
}

class UserSignOutErrorState extends HomeState {
  AuthException exception;

  UserSignOutErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}
