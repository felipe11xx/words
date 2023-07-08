import 'package:equatable/equatable.dart';

import '../../../data/model/models.dart';
import '../../../domain/error/failure_word.dart';

abstract class CompletelyWordState extends Equatable{}

class CompleteWordInitialState extends CompletelyWordState {

  @override
  List<Object?> get props => [];
}

class CompleteWordLoadingState extends CompletelyWordState {
   final bool prop;

   CompleteWordLoadingState(this.prop);

  @override
  List<Object?> get props => [prop];
}

class CompleteWordSuccessState extends CompletelyWordState {
  final WordCompleted prop;


  CompleteWordSuccessState(this.prop);

  @override
  List<Object?> get props => [prop];
}

class CompleteWordErrorState extends CompletelyWordState {

  final CompletelyWordDataSourceError prop;


  CompleteWordErrorState(this.prop);

  @override
  List<Object?> get props => [prop];
}