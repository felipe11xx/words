import 'package:equatable/equatable.dart';

import '../../../../shared/services/auth_service.dart';

abstract class AllWordsState extends Equatable{}

class AllWordsStateInitialState extends AllWordsState {

  @override
  List<Object?> get props => [];
}

class AllWordsStateLoadingState extends AllWordsState {
  final bool prop;

  AllWordsStateLoadingState(this.prop);

  @override
  List<Object?> get props => [prop];
}

class AllWordsSuccessState extends AllWordsState {
  final List<String?> list;

  AllWordsSuccessState(this.list);

  @override
  List<Object?> get props => [list];
}

class UserSignOutSuccessState extends AllWordsState {

  UserSignOutSuccessState();

  @override
  List<Object?> get props => [];
}

class UserSignOutErrorState extends AllWordsState {
  AuthException exception;


  UserSignOutErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class AllWordsErrorState extends AllWordsState {
  final Exception exception;

  AllWordsErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}