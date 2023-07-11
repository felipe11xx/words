import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable{}

class HistoryInitialState extends HistoryState {

  @override
  List<Object?> get props => [];
}

class HistoryLoadingState extends HistoryState {
  final bool prop;

  HistoryLoadingState(this.prop);

  @override
  List<Object?> get props => [prop];
}

class HistorySuccessState extends HistoryState {
  final List<String?> list;

  HistorySuccessState(this.list);

  @override
  List<Object?> get props => [list];
}


class HistoryErrorState extends HistoryState {
  final Exception exception;

  HistoryErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}