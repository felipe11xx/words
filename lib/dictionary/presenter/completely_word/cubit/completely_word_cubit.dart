import 'completely_word_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/error/failure_word.dart';
import '../../../../shared/services/tts_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:words/dictionary/domain/usecase/do_get_completely_word.dart';

final $CompletelyWordCubit = Bind.singleton((i) => CompletelyWordCubit(i(), i()));

class CompletelyWordCubit extends Cubit<CompletelyWordState> {
  CompletelyWordCubit(this.wordUseCase,this.tts) : super(CompleteWordInitialState());

  final DoGetCompletelyWordUseCase wordUseCase;
  final AppTTS tts;

  getCompletelyWord(String? word) async {
    emit(CompleteWordLoadingState(true));

    final result = await wordUseCase.call(word);

    result.fold(
      (l) => emit(CompleteWordErrorState(l as CompletelyWordDataSourceError)),
      (r) => emit(
        CompleteWordSuccessState(r),
      ),
    );
  }

  speak(String word) => tts.speakEN(word);


}
