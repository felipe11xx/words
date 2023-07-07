import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/dicionary/domain/usecase/do_get_completely_word.dart';
import 'package:words/dicionary/presenter/word_completely/cubit/word_completely_state.dart';

import '../../../domain/error/failure_word.dart';

final $WordCompletelyCubit = Bind((i) =>WordCompletelyCubit(i()) );

class WordCompletelyCubit extends Cubit<WordCompletelyState>{


  WordCompletelyCubit(this.wordUseCase): super(WordCompleteInitialState());

  final DoGetCompletelyWordUseCase wordUseCase;


  getCompletelyWord(String? word)async{
    emit(WordCompleteLoadingState(true));

    final result = await wordUseCase.call(word);

    result.fold((l) => emit(WordCompleteErrorState(l as CompletelyWordDataSourceError )),
        (r) => emit(WordCompleteSuccessState(r)));

  }

}