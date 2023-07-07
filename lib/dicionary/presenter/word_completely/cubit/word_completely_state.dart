import 'package:equatable/equatable.dart';

import '../../../data/model/models.dart';
import '../../../domain/error/failure_word.dart';

abstract class WordCompletelyState extends Equatable{}

class WordCompleteInitialState extends WordCompletelyState {

  @override
  List<Object?> get props => [];
}

class WordCompleteLoadingState extends WordCompletelyState {
   final bool prop;

   WordCompleteLoadingState(this.prop);

  @override
  List<Object?> get props => [prop];
}

class WordCompleteSuccessState extends WordCompletelyState {
  final WordCompleted prop;


  WordCompleteSuccessState(this.prop);

  @override
  List<Object?> get props => [prop];
}

class WordCompleteErrorState extends WordCompletelyState {

  final CompletelyWordDataSourceError prop;


  WordCompleteErrorState(this.prop);

  @override
  List<Object?> get props => [prop];
}