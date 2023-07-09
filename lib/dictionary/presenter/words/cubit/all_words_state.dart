import 'package:equatable/equatable.dart';

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
  final List<String> list;

  AllWordsSuccessState(this.list);

  @override
  List<Object?> get props => [list];
}

class AllWordsErrorState extends AllWordsState {
  final Exception exception;

  AllWordsErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}